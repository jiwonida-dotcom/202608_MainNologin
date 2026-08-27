# PUSH_GUIDE — 커밋 · 배포

## 1. 기본

레포 루트에서 **`push.cmd`** 를 더블클릭하거나 실행합니다.

```text
push.cmd                          메시지 자동 생성 → 바로 커밋 · push
.\push.ps1 "docs(00): 변경 내용"    메시지 직접 지정
.\push.ps1 -Ask                   자동 생성 메시지를 확인 후 확정
```

`push.cmd` 는 `push.ps1` 을 호출할 뿐입니다. 실제 동작은 —

| 단계 | 하는 일 |
|---|---|
| 1/4 | `.git` 의 `*.lock` · `tmp_obj_*` 정리 — 이전 실행이 비정상 종료했을 때를 대비 |
| 2/4 | `git add -A` → 스테이징된 변경이 있으면 커밋 |
| 3/4 | `git fetch` → 올릴 커밋 수 확인 → `git push -u origin HEAD:main` |
| 4/4 | 다시 `git fetch` 해서 **로컬 HEAD 와 원격 HEAD 를 대조** |

**4단계가 이 스크립트의 존재 이유입니다.** push 가 됐는지 알 수 없는 상태를 만들지 않습니다.

## 2. 커밋 메시지 규약

```text
<type>(<scope>): <요약>
```

| type | 언제 |
|---|---|
| `feat` | `index.html` · `tools/` 에 **새 파일이 생겼을 때** |
| `fix` | `index.html` · `tools/` 를 고쳤을 때 |
| `docs` | 문서만 바뀌었을 때 |
| `chore` | 스크립트 · 설정 파일 |

| scope | 대상 |
|---|---|
| `report` | `index.html` |
| `tools` | `tools/` · `*.cmd` · `*.ps1` · `package.json` · `.git*` |
| `00` ~ `99` | 프로젝트 폴더 번호 (`00_Project` → `00`, `03_Analysis` → `03`) |
| `guide` | 루트 문서 (`README` · `HANDOFF` · `CLAUDE` …) |

scope 는 **가장 많이 바뀐 영역**이 자동으로 선택됩니다.

> **`docs: 내용 갱신` 같은 메시지를 쓰지 않습니다.** 이력이 무용지물이 됩니다.
> 자동 생성 메시지가 어색하면 `.\push.ps1 -Ask` 로 확인 후 고쳐 쓰세요.

## 3. 커밋 위생

`push.ps1` 이 `git add -A` 를 쓰므로 **작업 폴더의 모든 파일이 커밋 대상**입니다.

- 임시 파일은 `99_Working/` 에서 다루고, 끝나면 지웁니다.
- 압축 파일 · 백업본을 루트에 남기지 않습니다.
- 불가피하면 **먼저 `.gitignore` 에 추가**한 뒤 만듭니다.

## 4. 실패했을 때

| 증상 | 확인 |
|---|---|
| 커밋 실패 | `user.name` / `user.email` 미설정 — `git config --global user.name "jiwonida-dotcom"` |
| push 반영 안 됨 | 저장소 생성 시 README 를 만들었다면 첫 push 만 `git push -u origin main --force` |
| 인증 오류 | git credential-manager 로그인 만료 · Personal Access Token 권한 |
| 원격이 앞섬 | `git pull --rebase origin main` 후 다시 push |
| 배포 화면이 옛 내용 | push 문제가 아니라 캐시 — URL 뒤에 `?v=2` |

## 5. 배포

`main` 브랜치 루트가 GitHub Pages 배포 대상입니다 (`.nojekyll` 로 Jekyll 처리를 끕니다).

https://jiwonida-dotcom.github.io/202608_MainNologin/

반영까지 1~2분 걸립니다.

> **공개 범위 주의.** `01_Source` 에 고객사 · 사내 자료 원본이 들어갈 수 있습니다.
> GitHub Pages 는 **Public 저장소**를 요구합니다. 원본을 등록하기 전에
> **Private 전환(Pages 포기) / 저장소 2개 분리 / `01_Source` 를 `.gitignore` 처리** 중
> 하나를 먼저 고릅니다. — `00_Project/RULES.md` 8절
