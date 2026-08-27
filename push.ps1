# U+유모바일 비로그인 메인 UX 개선 — 커밋 & 배포
# 사용법 :  push.cmd                          (메시지 자동 생성 → 바로 커밋 · push)
#           .\push.ps1 "docs(00): 변경 내용"   (메시지 직접 지정)
#           .\push.ps1 -Ask                   (자동 생성한 메시지를 확인 후 확정)
#
# push 가 됐는지 알 수 없는 상태를 만들지 않습니다 —
#   push 전후로 로컬 HEAD 와 원격을 대조해 **실제로 올라갔는지** 확인합니다.

param([string]$m = "", [switch]$Ask)

Set-Location -LiteralPath $PSScriptRoot
$ErrorActionPreference = "Continue"

$repoUrl  = (git config --get remote.origin.url)
$pagesUrl = "https://jiwonida-dotcom.github.io/202608_MainNologin/"

# ─────────────────────────────────────────────────────────────
#  커밋 메시지 자동 생성
#
#  형식 : <type>(<scope>): <요약>
#    type  = docs · feat · fix · chore
#    scope = report(index.html) · tools · guide(루트 문서) · NN(프로젝트 폴더 번호)
#
#  스테이징된 변경을 읽어 만듭니다. 손으로 적는 것보다 정확하고,
#  「docs: 내용 갱신」 같은 무의미한 메시지가 남지 않습니다.
# ─────────────────────────────────────────────────────────────
function Get-AutoMessage {
    $lines = @(git diff --cached --name-status)
    if (-not $lines -or $lines.Count -eq 0) { return "" }

    $added    = New-Object System.Collections.ArrayList
    $modified = New-Object System.Collections.ArrayList
    $deleted  = New-Object System.Collections.ArrayList
    $paths    = New-Object System.Collections.ArrayList

    foreach ($l in $lines) {
        if ([string]::IsNullOrWhiteSpace($l)) { continue }
        $parts = $l -split "`t"
        $code  = $parts[0]
        $path  = $parts[$parts.Count - 1]
        [void]$paths.Add($path)
        if     ($code -like 'A*') { [void]$added.Add($path) }
        elseif ($code -like 'D*') { [void]$deleted.Add($path) }
        else                      { [void]$modified.Add($path) }
    }

    # ── scope : 가장 많이 바뀐 영역. 프로젝트 폴더는 번호(NN)를 그대로 씁니다.
    $cnt = @{}
    foreach ($p in $paths) {
        $key = 'guide'
        if     ($p -eq 'index.html')                                   { $key = 'report' }
        elseif ($p -like 'tools/*' -or $p -like '*.cmd' -or $p -like '*.ps1' -or
                $p -eq 'package.json' -or $p -like '.git*' -or $p -eq '.nojekyll') { $key = 'tools' }
        elseif ($p -match '^(\d{2})_')                                 { $key = $Matches[1] }
        if (-not $cnt.ContainsKey($key)) { $cnt[$key] = 0 }
        $cnt[$key]++
    }
    $scope = 'guide'
    $max = -1
    foreach ($k in $cnt.Keys) { if ($cnt[$k] -gt $max) { $max = $cnt[$k]; $scope = $k } }

    # ── type
    $codeTouched = @($paths | Where-Object { $_ -eq 'index.html' -or $_ -like 'tools/*' }).Count
    if     ($codeTouched -gt 0 -and $added.Count -gt 0) { $type = 'feat'  }
    elseif ($codeTouched -gt 0)                         { $type = 'fix'   }
    elseif ($scope -eq 'tools')                         { $type = 'chore' }
    else                                                { $type = 'docs'  }

    # ── 요약
    $bits = New-Object System.Collections.ArrayList
    if ($added.Count -gt 0) {
        $first = [System.IO.Path]::GetFileNameWithoutExtension($added[0])
        if ($added.Count -eq 1) { [void]$bits.Add("$first 신설") }
        else { [void]$bits.Add("$first 외 " + ($added.Count - 1) + "건 신설") }
    }
    if ($modified.Count -gt 0) {
        if ($modified.Count -le 2) {
            $names = ($modified | ForEach-Object { [System.IO.Path]::GetFileNameWithoutExtension($_) }) -join ' · '
            [void]$bits.Add("$names 갱신")
        } else {
            [void]$bits.Add($modified.Count.ToString() + "건 갱신")
        }
    }
    if ($deleted.Count -gt 0) { [void]$bits.Add($deleted.Count.ToString() + "건 삭제") }

    $summary = $bits -join ' · '
    if ([string]::IsNullOrWhiteSpace($summary)) { $summary = "작업 내용 갱신" }

    return "$type($scope): $summary"
}

Write-Host ""
if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "원격이 설정되어 있지 않습니다." -ForegroundColor Yellow
    Write-Host '    git remote add origin https://github.com/jiwonida-dotcom/202608_MainNologin.git' -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "커밋까지만 진행합니다." -ForegroundColor DarkGray
} else {
    Write-Host "원격 : $repoUrl" -ForegroundColor DarkGray
}

# ── 1) 잠금 · 임시 파일 정리
Get-ChildItem -Path .git -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like '*.lock' -or $_.Name -like 'tmp_obj_*' } |
    Remove-Item -Force -ErrorAction SilentlyContinue
Write-Host "[1/4] 잠금 파일 정리 완료" -ForegroundColor Cyan

# ── 2) 변경분이 있으면 커밋
git add -A
git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    if ([string]::IsNullOrWhiteSpace($m)) {
        $auto = Get-AutoMessage
        Write-Host ""
        Write-Host "변경 내역" -ForegroundColor DarkGray
        git --no-pager diff --cached --stat | Select-Object -Last 12
        Write-Host ""
        if ($Ask) {
            Write-Host "자동 생성한 커밋 메시지" -ForegroundColor Yellow
            Write-Host "  $auto" -ForegroundColor Green
            Write-Host ""
            $inp = Read-Host "Enter = 그대로 사용 / 바꾸려면 메시지 입력"
            if ([string]::IsNullOrWhiteSpace($inp)) { $m = $auto } else { $m = $inp }
        } else {
            $m = $auto
            Write-Host "커밋 메시지 (자동 생성)" -ForegroundColor Yellow
            Write-Host "  $m" -ForegroundColor Green
            Write-Host "  ※ 확인 후 확정하려면 : .\push.ps1 -Ask" -ForegroundColor DarkGray
        }
    }
    git commit -m $m
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "커밋 실패 — 위 오류를 확인하세요. push 하지 않고 중단합니다." -ForegroundColor Red
        Write-Host "  자주 있는 원인 : user.name / user.email 미설정" -ForegroundColor DarkGray
        Write-Host '    git config --global user.name  "jiwon"' -ForegroundColor DarkGray
        Write-Host '    git config --global user.email "jiwon@medialog.co.kr"' -ForegroundColor DarkGray
        exit 1
    }
    Write-Host "[2/4] 커밋 완료 : $m" -ForegroundColor Cyan
} else {
    Write-Host "[2/4] 새 변경 없음 — 이미 커밋된 것만 전송합니다" -ForegroundColor DarkGray
}

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "[3/4] 원격이 없어 push 를 건너뜁니다" -ForegroundColor DarkGray
    exit 0
}

# ── 3) push
$local = (git rev-parse --short HEAD)
git fetch origin --quiet 2>$null
$ahead = (git rev-list --count origin/main..HEAD 2>$null)
if ([string]::IsNullOrWhiteSpace($ahead)) { $ahead = "?" }

if ($ahead -eq "0") {
    Write-Host "[3/4] 올릴 커밋이 없습니다 — 원격이 이미 로컬과 같습니다 ($local)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "배포 화면이 옛 내용으로 보인다면 push 문제가 아니라 캐시입니다 — URL 뒤에 ?v=2" -ForegroundColor Yellow
    Write-Host "  $pagesUrl" -ForegroundColor Green
    exit 0
}

Write-Host "[3/4] push ... (올릴 커밋 $ahead 건)" -ForegroundColor Cyan
git --no-pager log --oneline origin/main..HEAD
git push -u origin HEAD:main
$pushCode = $LASTEXITCODE

# ── 4) 실제로 올라갔는지 대조
git fetch origin --quiet 2>$null
$remote = (git rev-parse --short origin/main 2>$null)

Write-Host ""
if ($pushCode -eq 0 -and $local -eq $remote) {
    Write-Host "[4/4] 확인 완료 — 로컬 $local = 원격 $remote" -ForegroundColor Green
    Write-Host ""
    Write-Host "배포 : $pagesUrl  (Pages 설정 후 1~2분 · 캐시면 ?v=2)" -ForegroundColor Green
    git --no-pager log --oneline -3
} else {
    Write-Host "[4/4] push 가 반영되지 않았습니다 — 로컬 $local / 원격 $remote" -ForegroundColor Red
    Write-Host ""
    Write-Host "확인 순서 :" -ForegroundColor Yellow
    Write-Host "  1) 히스토리 충돌  저장소 생성 시 README 를 만들었다면 첫 push 는 : git push -u origin main --force" -ForegroundColor DarkGray
    Write-Host "  2) 인증           git credential-manager 로그인 만료 · 토큰 권한" -ForegroundColor DarkGray
    Write-Host "  3) 원격 주소      git remote -v" -ForegroundColor DarkGray
    Write-Host "  4) 원격이 앞서면  git pull --rebase  후 다시 push" -ForegroundColor DarkGray
    exit 1
}
