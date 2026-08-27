# SPEC-01 · Screen Specification

U+유모바일 비로그인 모바일 메인 개편 · Development Specification
작성 2026-08-27 · 기준 커밋 `beea5bb`
선행 · `SPEC-02_Functional.md` · `SPEC-03_State_Exception.md` · `SPEC-04_Data_Handoff.md` · `SPEC-05_Measurement.md`

**상태 표기** — `CONFIRMED` / `OBSERVED` / `RENDERED FACT` / `ASSUMED` / `PARTIAL` / `UNVERIFIED` / `OPEN` / `PROTOTYPE-ONLY` / `OUT OF SCOPE` / `SPEC GAP`

> 이 문서는 확정된 결정과 **실렌더 측정값**을 화면 명세로 옮긴다. 새로운 UX·디자인을 만들지 않는다. 문서 간 값이 다르면 통합하지 않고 출처별로 병기한다.
> **실렌더 측정값이 기존 결정을 변경하지 않는다.** 측정은 "현재 프로토타입이 이렇게 렌더된다"는 사실의 기록이다.

---

## 01. 적용 대상

| 항목 | 내용 | 상태 |
|---|---|---|
| 대상 URL | `/nologfirst` · `/nologrevisit` | `CONFIRMED` |
| 화면 차등 | **만들지 않는다** — 두 URL은 동일 화면 | `CONFIRMED` — PHASE 5.2 "FIRST / REVISIT Keep" · PHASE 6 "화면 차등은 만들지 않는다. 두 페이지 GTM 시그니처 해시가 완전히 일치한다(−1113317340)" |
| FIRST / REVISIT | 쿠키로 판정한 **방문 이력 분류**이며 사람의 가입 여부가 아니다 | `CONFIRMED` |
| 운영 단위 병합 | **미결** — 2벌 유지 / 1벌 통합 | **`OPEN`** · D-01(FR-07) |
| 노출 환경 | 모바일 전용(쿠키 기반 분기). PC는 별도 화면 존재(`메인_PC` GTM 카테고리 관측) | `CONFIRMED` |

### 적용 범위 / 제외 범위

| 범위 | 대상 |
|---|---|
| **포함** | M-01 ~ M-09 본문 모듈 · M-10 구조 · M-11 진입점과 오버레이 동작 · C-01 ~ C-11 · 반응형 · 접근성 · 목적지 매핑 |
| **제외** | GNB 내부 메뉴 트리 (`OUT OF SCOPE` — PHASE 5.2 "주요 메뉴(GNB) Keep. 변경 없음") |
| **제외** | M-10 팝업 **노출 규칙** (`OPEN` — DV-03) |
| **제외** | `pricList` 등 목적지 화면 설계 (`OUT OF SCOPE`) |
| **제외** | 비주얼 확정 · 카피 확정 (D-10(FR-07) · OI-05) |
| **제외** | 프로토타입 검증 장치 일체 (`PROTOTYPE-ONLY`) |

---

## 02. 화면 기준값

### 2-1. 측정 조건 (2026-08-27 실렌더)

| 항목 | 값 |
|---|---|
| 측정 대상 | `prototype.html` (커밋 `beea5bb`) |
| 측정 도구 | Chromium 실렌더 · `getBoundingClientRect()` |
| 측정 뷰포트 | 390 × 844 · `isMobile` · 실기기 경로(`@media (max-width:640px)` 적용) |
| 기준점 | `#paneMain` 상단 = 0 |

> **측정 경로에 따라 화면 폭이 달라진다.**
> 데스크톱 프레임에서는 `.device{padding:11px}` 때문에 `--dw:390px` 이어도 실제 화면 폭이 **368px**이다. 실기기 경로에서는 `padding:0`이 적용되어 **390px**이다.
> **기존 CH 기록의 "모바일 390 실측"이 어느 경로의 값인지 원자료에 표기가 없다** `UNVERIFIED`.

### 2-2. 세로 좌표 실측 — 390px 기준

| 요소 | top | height | 상태 |
|---|---:|---:|---|
| M-01 Header | 0 | **56.00** | `RENDERED FACT` |
| M-02 QuickMenu | 68 | **72.00** | `RENDERED FACT` |
| M-03 (섹션 전체) | 152 | **522.59** | `RENDERED FACT` |
| ├ hero | 176 | 82.47 | `RENDERED FACT` |
| └ m03card | 258.5 | 400.13 | `RENDERED FACT` |
| &nbsp;&nbsp;&nbsp;└ 구간 5행(`#ranges`) | 258.5 | **358.63** | `RENDERED FACT` |
| M-04 (영역 전체) | **690.6** | 313.39 | `RENDERED FACT` |
| ├ 섹션 헤더 | 710.6 | 44.00 | `RENDERED FACT` |
| └ 배너 캐러셀 | **766.6** | — | `RENDERED FACT` |
| M-05 | 1020.3 | 258.27 | `RENDERED FACT` |
| M-06 (접힘) | 1294.5 | 59.00 | `RENDERED FACT` |
| M-07 (접힘) | 1369.5 | 59.00 | `RENDERED FACT` |
| M-08 (접힘) | 1428.5 | 58.00 | `RENDERED FACT` |
| M-09 Footer | 1510.5 | 276.56 | `RENDERED FACT` |

### 2-3. AtF 기준값 — 가정과 사실의 구분

| 값 | 성격 | 상태 |
|---|---|---|
| **실효 뷰포트 700px** | 844 − 상태바 − 브라우저 주소창. "기기·브라우저별 편차 있음" | **`ASSUMED`** — 프로토타입 화면에도 "AtF 700px · **가정값**"으로 표기됨. OI-10 미해소 |
| 뷰포트 844px | 측정 기기 기준 | `OBSERVED` |
| 배너 상단 682px (CH-57) | 문서 기록 | `OBSERVED`(기록) — **현재 렌더와 불일치, §2-4** |
| 배너 상단 766.6px | 2026-08-27 실렌더 (390) | **`RENDERED FACT`** |

> **OI-10이 해소되기 전까지 700px을 실측값으로 기록하지 않는다.**

### 2-4. 배너 상단 값 — 문서 간 불일치 (통합하지 않음)

| 출처 | 값 | 맥락 |
|---|---:|---|
| CH-58 부작용 기록 | 829px | 히어로 추가 시점 · "AtF 스필오버 소멸" |
| CH-57 | **682px** | "행 68px·상단 여백 조정으로 회수 — 모바일 390 실측 · 스필오버 유지" |
| CH-13 관련 서술 | 661px | "섹션 여백을 조여 배너 상단을 661px로 끌어올려 스필오버 확보" |
| 프로토타입 QA 표 (390 대표 화면) | **656px** | "AtF 700 안, 헤드라인·CTA까지 노출" |
| 프로토타입 본문 서술 | 758px | "실측상 배너 상단은 758px로 뷰포트(844px) 안에 남는다" |
| **2026-08-27 실렌더 (390 실기기)** | **766.6px** | 본 명세 측정 |
| 2026-08-27 실렌더 (데스크톱 프레임 368) | 766.9px → 775.2px | 폭 차이 |

> **다섯 개의 문서 값(829 / 682 / 661 / 656 / 758)과 실렌더 값(766.6)이 모두 다르다.**
> 어느 값도 임의로 선택하지 않는다. **`UNVERIFIED` — 기준 시점·측정 경로 확인 필요.**
> 각 값이 서로 다른 CH 시점의 스냅샷일 가능성이 있으나, **원자료에 측정 시점·경로 표기가 없어 확인할 수 없다.**

---

## 03. 모듈 명세

> 각 모듈에서 **근거가 없는 항목은 채우지 않는다.** 치수는 실렌더 측정값이며 운영 디자인 확정값이 아니다.

### M-01 · Header

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 로그인 진입을 최상위로 노출한다 — 전체메뉴 경유 단계 제거 | `CONFIRMED` DD-01 |
| 위치 | 최상단 · top 0 | `CONFIRMED` |
| 구성 요소 | 로고(BI) · 검색(아이콘) · 로그인(텍스트+아이콘) · 전체메뉴(아이콘) | `CONFIRMED` C-01 |
| 크기 | 높이 **56.00px** (7-1 정의 56 = 터치 타깃 44 + 상하 여백 6) | `RENDERED FACT` · 정의와 일치 |
| 반응형 | 전 폭 공통 | `CONFIRMED` |
| 상태 | `default` / `sticky` / `scrolled`(그림자 전환) | → SPEC-03 §02. `scrolled`는 CH-20 신설 `PARTIAL` |
| Interaction | 로그인 이동 · 검색 레이어 · GNB 오버레이 | → SPEC-02 F-10 · F-11 |
| Accessibility | 아이콘 타깃 44×44 · 인접 간격 8 · 포커스 링 · `aria-expanded`(전체메뉴) | `CONFIRMED` PHASE 7-1 G |
| Destination | 로그인 → `/login/app` | `CONFIRMED` PHASE 6 E |
| Data dependency | 없음 | — |
| Measurement | 로그인 배너·검색·전체메뉴는 `MAIN_NOTLOGIN` **범위 밖**(`UTIL_TOP` · `GNB`) | `OBSERVED` → SPEC-05 §02 |
| Implementation note | sticky 시 세로 56px 상시 점유 — 부작용 미검토 | `UNVERIFIED` OI-07 |
| 근거 ID | DD-01 · C-01 · D-09(5.2)(검색 등급 유보) |
| 상태 판정 | **`CONFIRMED`** (구성) · `PARTIAL`(그림자 전환) |

**회원가입 링크** — 헤더 병기안(CH-61)은 **CH-64로 철회**됐다. 회원가입 경로는 전체메뉴에만 둔다. `CONFIRMED`

### M-02 · QuickMenu

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 콘텐츠를 읽지 않고 목적지로 바로 점프 | `CONFIRMED` PHASE 6 M-02 |
| 위치 | M-01 아래 · top 68 | `RENDERED FACT` |
| 구성 요소 | 3등분 그리드 · C-02 QuickItem × 3 | `CONFIRMED` D-01(5.2) · DD-02 |
| 콘텐츠 | ① 전체 요금제 ② 휴대폰 ③ 셀프개통 (실사용 순) | `CONFIRMED` · 라벨 ①은 CH-35로 변경 · 문구는 OI-05 |
| 크기 | 높이 **72.00px** | **`RENDERED FACT`** — **PHASE 7-1 정의 65px과 불일치** (§2-4 계열 발견, 아래 note) |
| 반응형 | **3등분 유지 · 2행으로 접히지 않는다**(라벨을 줄인다) · 항목당 최소 폭 96 | `CONFIRMED` PHASE 7-1 C-02 · E |
| 상태 | `default` / `pressed` / `focus` | `CONFIRMED` |
| Interaction | 항목 탭 → 목적지 이동 | → SPEC-02 F-01 |
| Accessibility | 타깃 44×44 · 인접 간격 8 · 포커스 링 | `CONFIRMED` |
| Destination | ① `/product/pric/usim/pricList` ② `/shop/mobile/mobileJoinIntro` ③ `/shop/self/openingGuide` | `CONFIRMED` PHASE 6 E |
| Data dependency | 없음 | — |
| Measurement | GTM `QuickMenu` 존재(현행 4항목) · 개편 시 **정의 변경** · DV-05 동일 단위 비교 | → SPEC-05 §06 |
| Implementation note | **이벤트 항목을 두지 않는다**(D-02(5.2)) · 항목 추가·제거 없음 | `CONFIRMED` |
| 근거 ID | D-01(5.2) · D-02(5.2) · DD-02 · CH-35 · C-02 |
| 상태 판정 | **`CONFIRMED`**(구성) · **`UNVERIFIED`**(높이) |

> **높이 불일치 — 확인 필요** PHASE 7-1 B의 레이아웃 불변 조건 ②는 "**M-02는 65px를 넘지 않는다**"이고 AtF 예산표도 65로 잡았다. 실렌더는 **72px**이다. 두 값을 병기하고 임의로 선택하지 않는다 `UNVERIFIED`.

### M-03 · 요금제 탐색

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 내 기준(데이터·가격)으로 좁혀 목록으로 이동 | `CONFIRMED` PHASE 6 M-03 |
| 위치 | M-02 아래 · top 152 · **AtF 안** | `RENDERED FACT` · DD-03 |
| 구성 요소 | hero(섹션 타이틀·보조) + m03card(구간 5행) | `RENDERED FACT` |
| 콘텐츠 | 구간 5종 — 3GB 이하 / 4~6GB / 7~14GB / 15~70GB / 71GB 이상 · 각 행에 **대표 가격 병기** · 보조 설명 1줄 | `CONFIRMED` D-04(5.2) · DD-04 · CH-14/CH-44 |
| 크기 | 섹션 522.59 · hero 82.47 · 5행 영역 358.63 · **행 높이 §04 C-03 참조** | `RENDERED FACT` |
| 반응형 | **어떤 폭에서도 5행 동시 노출** · 가로 스크롤·2열·칩 금지 · 200% 확대 시 2줄 허용하되 5행 탭 가능 | `CONFIRMED` DD-04 · PHASE 7-1 C-03 · E |
| 상태 | `default` / `selected` / `focus` / `pressed` / `가격 미수신` / `조회 실패` / `retry` | → SPEC-03 §02 (뒤 3종은 `PARTIAL` · CH-21) |
| Interaction | 행 전체 탭 → 단일 선택 → 목록 이동 | → SPEC-02 F-02 · F-03 |
| Accessibility | 행 전체가 하나의 링크로 읽힌다 · 타깃 44×44 · 5행 강도 동일 | `CONFIRMED` PHASE 7-1 G · F |
| Destination | `/product/pric/usim/pricList` (조건 동반) | `CONFIRMED` |
| Data dependency | 구간 경계 = 정적 값 · 대표 가격 = DOM 스냅샷 · **소스 미정** | → SPEC-04 §02 · §04 · OI-06 |
| Measurement | 현행 `SearchFee`는 **다른 구간 체계** — Before/After 비교 불가 | → SPEC-05 §06 · §08 |
| Implementation note | **추천·개인화·메인 필터·결과 개수·다중 선택 금지** | `CONFIRMED` DD-07 |
| 근거 ID | D-04(5.2) · DD-03 · DD-04 · DD-05 · DD-07 · C-03 · CH-13 · CH-21 · CH-29 · CH-30 |
| 상태 판정 | **`CONFIRMED`**(구조) · 치수는 `RENDERED FACT` |

### M-04 · 이벤트 · 프로모션

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 지금 받을 수 있는 혜택 확인 → 해당 이벤트로 이동 | `CONFIRMED` PHASE 6 M-04 |
| 위치 | M-03 아래 · top **690.6** · 섹션 헤더 710.6 · 배너 766.6 | `RENDERED FACT` |
| 구성 요소 | C-05 BannerCarousel + 컨트롤 행(인디케이터·이전/다음·카운터·정지) + 전체보기 | `CONFIRMED` C-05 · CH-53 계열 |
| 콘텐츠 | 운영 등록 배너 · **개수 상한·정렬 규칙 없음** | `UNVERIFIED` → SPEC-04 DS-3 |
| 크기 | 영역 313.39 · 섹션 헤더 44.00 | `RENDERED FACT` |
| 반응형 | 높이 고정 · 배너 폭만 증가 | `CONFIRMED` |
| 상태 | `default` / `loading` / `playing` / `paused` / `swipe` / `등록 0건`(영역 미노출) | → SPEC-03 §02 |
| Interaction | 배너 탭 · 스와이프 · 이전/다음 · 인디케이터 · 정지/재생 | → SPEC-02 F-08 |
| Accessibility | **정지 컨트롤 필수** · `prefers-reduced-motion` 자동 전환 중지 · 현재 위치 텍스트 전달 · 배너 텍스트 이미지 굽기 금지 | `CONFIRMED` PHASE 7-1 G |
| Destination | 배너 → `/event-benefit/event/ongoing/{id}` · 전체보기 → `/event-benefit/event/ongoing` | `CONFIRMED` PHASE 6 E |
| Data dependency | 배너 데이터 `SAMPLE`(`SLIDES` 3종) | `PROTOTYPE-ONLY` |
| Measurement | `ProductBanner` / `ProductProBanner` 관측 존재 · **조작(정지/스와이프) 미측정** | → SPEC-05 §06 |
| Implementation note | 테두리·모션 강조 추가 금지(UI-P4) · 컨트롤 행은 배너 아래 | `CONFIRMED` |
| 근거 ID | DD-08 · R-02 · C-05 · CH-53 계열 |
| 상태 판정 | **`CONFIRMED`** |

> **AtF 관계** — 7-1 B는 "M-04의 상단 일부가 의도적으로 잘려 보이게 배치"를 의도로 기록했다. 현재 실렌더에서 **영역 상단 690.6은 700 안, 섹션 헤더 710.6과 배너 766.6은 700 밖**이다. 이 상태가 그 의도를 충족하는지는 **본 명세에서 판단하지 않는다** `UNVERIFIED` (§05 · §2-4).

### M-05 · 가입 · 개통

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 가입 방법 확인 또는 즉시 개통 시작 | `CONFIRMED` PHASE 6 M-05 |
| 위치 | top 1020.3 | `RENDERED FACT` |
| 구성 요소 | C-06 ActionCard × 2 (가입 안내 · 셀프개통) + C-07 InlineNotice | `CONFIRMED` |
| 콘텐츠 | 가입 안내 · 셀프개통 진입 · **가능 시간대 인라인 안내** | `CONFIRMED` DD-09 |
| 크기 | 258.27 | `RENDERED FACT` |
| 상태 | `개통 가능` / `개통 불가`(CTA `disabled` + 인라인 사유 · **팝업 금지**) | `CONFIRMED` → SPEC-03 §02 |
| Interaction | 카드 탭 → 이동 · 불가 시간에는 차단 | → SPEC-02 F-09 |
| Accessibility | **비활성 상태도 읽을 수 있어야 한다**(대비 유지) · 색 단독 의존 금지 | `CONFIRMED` PHASE 7-1 G |
| Destination | `/shop/mobile/mobileJoinIntro` · `/shop/self/openingGuide` (`/onsale/*` 아님) | `CONFIRMED` DD-10 |
| Data dependency | **가능 시간 값 미확정** — 프로토타입 `09:00 ~ 20:00`은 결정 문서에 없음 | **`PROTOTYPE-ONLY` / `UNVERIFIED`** → SPEC-04 DS-5 |
| Measurement | `openingGuide` 도달 4,724 / 1,745 sessions 관측 · **불가 상태 노출은 미측정** | → SPEC-05 §06 |
| Implementation note | 새 팝업을 추가하지 않는다(P-A) | `CONFIRMED` |
| 근거 ID | DD-09 · DD-10 · P-A · R-09 · R-10 · UI-P3 · C-06 · C-07 · CH-45 · CH-52 |
| 상태 판정 | **`CONFIRMED`**(구조) · **`UNVERIFIED`**(시간 값) |

### M-06 · 휴대폰 (NDV)

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 성과를 가정하지 않고 **측정 가능한 구조로만** 둔다 | `CONFIRMED` DD-11 |
| 위치 | top 1294.5 (접힘 기준) | `RENDERED FACT` |
| 구성 요소 | C-08 CollapsibleSection · 펼침 시 3탭 + 상품 카드 | `CONFIRMED` |
| 콘텐츠 | 3탭 — **라벨이 문서 간 다르다**(§07 발견) | **`UNVERIFIED`** |
| 크기 | 접힘 59.00 | `RENDERED FACT` |
| 상태 | `collapsed`(기본) / `loading` / `expanded` / **`펼침 실패`(미구현)** | → SPEC-03 §02 · **`SPEC GAP`** |
| Interaction | 헤더 탭 → 지연 로드 → 펼침 · 탭 전환(좌우 방향키) | → SPEC-02 F-06 · F-07 |
| Accessibility | `aria-expanded` · 화살표 방향만으로 상태 전달 금지 · `role=tablist/tab` · `aria-selected` · roving tabindex | `CONFIRMED` PHASE 7-1 G |
| Destination | `/shop/mobile/detail` · `/shop/mobile/list` | `OBSERVED`(프로토타입) · 실서비스 경로 `UNVERIFIED` |
| Data dependency | 상품 데이터 `SAMPLE`(`PHONES` 12종) | `PROTOTYPE-ONLY` |
| Measurement | **`#phoneArea` 내 링크·버튼 13개 중 GTM 태깅 0개** · 필요 측정 4종 `PROPOSED` | `OBSERVED` DV-01 |
| Implementation note | **태깅 전까지 영역 확대 금지** · 강조·시각 비중 부여 금지 · M-02 휴대폰 수요를 근거로 인용 금지 | `CONFIRMED` D-03(5.2) · OI-08 |
| 근거 ID | D-03(5.2) · DD-11 · DV-01 · OI-08 · C-08 · CH-51 |
| 상태 판정 | **`CONFIRMED`**(구조) · `UNVERIFIED`(라벨) · **`SPEC GAP`**(펼침 실패) |

> **식별자** — 실서비스 컨테이너는 `#phoneArea`(PHASE 2 관측). 프로토타입은 `phoneHd` / `phoneBody`를 쓴다. **매핑 필요** → SPEC-04 PS-09 · DQ-12.

### M-07 · 브랜드 · 혜택

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 시안 신설 요구에 대응하되 **경로 근거가 없어 하단 접힘 배치** | `CONFIRMED` PHASE 6 M-07 |
| 위치 | top 1369.5 (접힘) | `RENDERED FACT` |
| 구성 요소 | C-08 + 타일 그리드 | `OBSERVED` |
| 콘텐츠 | 브랜드혜택 · U+인터넷 결합 · 가족 결합 · 친구 추천 | `OBSERVED`(프로토타입) |
| 크기 | 접힘 59.00 | `RENDERED FACT` |
| 상태 | `collapsed` / `expanded` | `CONFIRMED` |
| Destination | `/benefit/brand` · `/benefit/combine` · `/benefit/family` · `/benefit/friend` | `OBSERVED`(프로토타입) · 실서비스 경로 `UNVERIFIED` |
| Implementation note | **운영 슬롯 규칙 미정** — 브랜드 배너 고정 2건의 교체 주기 등 | **`OPEN`** DC-03 |
| 근거 ID | DD-14 · DC-03 · C-08 |
| 상태 판정 | **`PARTIAL`** — 구조 확정 · 슬롯 규칙 공백 |

### M-08 · 고객지원

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 고객센터 진입 분산 해소 · 안정 수요 유지 | `CONFIRMED` PHASE 6 M-08 |
| 위치 | top 1428.5 (접힘) | `RENDERED FACT` |
| 구성 요소 | C-08 + C-09 LinkList / 타일 | `OBSERVED` |
| 콘텐츠 | FAQ · 1:1문의 · 챗봇 · 이용방법 | `OBSERVED`(프로토타입) |
| 크기 | 접힘 58.00 | `RENDERED FACT` |
| Destination | `/support/faq` · `/support/inquiry` · `/support/chatbot` · `/support/howto` | `OBSERVED`(프로토타입) · 실서비스 경로 `UNVERIFIED` |
| Measurement | `CustomerCenter` 0.0101 / 0.0102 회/세션 — **두 집단 동일 수요** | `OBSERVED` |
| 근거 ID | PHASE 6 M-08 · C-08 · C-09 · CH-39 |
| 상태 판정 | **`CONFIRMED`** |

### M-09 · Footer · 기타

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 정책·앱·리뷰 링크 정리 | `CONFIRMED` PHASE 6 M-09 |
| 위치 | top 1510.5 | `RENDERED FACT` |
| 구성 요소 | C-09 LinkList — **카드 형태를 쓰지 않는다** | `CONFIRMED` PHASE 7-1 C-09 |
| 크기 | 276.56 | `RENDERED FACT` |
| Destination | `/terms` · `/privacy` · `/notice` · `/review` · `/app/android` · `/app/ios` | `OBSERVED`(프로토타입) · 실서비스 경로 `UNVERIFIED` |
| Measurement | **'푸터 영역 보기' 클릭 목적 미확인** | `UNVERIFIED` DV-06 — 추적 복원 필요 |
| Implementation note | 프로토타입 고지 문구는 `PROTOTYPE-ONLY` | — |
| 근거 ID | PHASE 6 M-09 · C-09 · CH-40 |
| 상태 판정 | **`CONFIRMED`**(구조) |

### M-10 · 팝업

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 운영 고지·프로모션 레이어 | `OBSERVED` |
| 위치 | 오버레이 — 인라인 위치 없음 | — |
| 구성 요소 | C-10 PopupLayer — 딤 + 콘텐츠 + **닫기 3종** | `CONFIRMED` |
| **노출 조건 · 개수 · 재노출 주기** | **정의하지 않는다** | **`OPEN`** DV-03 · OI-04 |
| 상태 | 구조만 | → SPEC-03 §02 |
| Accessibility | 열림 시 포커스 트랩 · 닫으면 호출 지점 복귀 · 배경 스크롤 잠금 · 닫기 타깃 44×44 — **"구조 요건이며 노출 규칙과 무관"** | `CONFIRMED` PHASE 7-1 G |
| Measurement | `PopupTop` · `PopupClose` · `Popup_79` · `Popup_95` 관측 · **닫기 3종 분해 불가** | `OBSERVED` → SPEC-05 |
| 근거 ID | D-07(5.2)(레이어 분리) · D-07(FR-07)(정책 재설계) · DD-12 · DV-03 · OI-04 · C-10 · P-01 |
| 상태 판정 | **`PARTIAL`**(구조) / **`OPEN`**(규칙) |

### M-11 · 전체메뉴 (GNB)

| 항목 | 내용 | 상태 |
|---|---|---|
| 영역 목적 | 전체 카테고리 진입 유지 — DD-01 적용 후에도 기존 경로를 끊지 않는다 | `CONFIRMED` |
| 위치 | 오버레이 | — |
| 구성 요소 | C-11 GnbOverlay | `CONFIRMED` |
| **내부 메뉴 트리** | **명세하지 않는다** | **`OUT OF SCOPE`** — PHASE 5.2 "GNB Keep. 변경 없음" |
| 상태 | `open` / `closed` | `CONFIRMED` |
| Accessibility | 배경 스크롤 잠금 · 포커스 트랩 · ESC · 호출 지점 복귀 · `aria-expanded` | `CONFIRMED` PHASE 7-1 G |
| Destination | 프로토타입의 GNB 목적지 16개 | **`PROTOTYPE-ONLY`** — 실제 구조 미대조 |
| Measurement | `GNB` 카테고리 — `MAIN_NOTLOGIN` 범위 밖 | `OBSERVED` |
| Implementation note | 2026.01 GNB 개편안과의 **관계 미정** | `OPEN` OPEN-12 |
| 근거 ID | C-11 · DD-01 · OPEN-12 |
| 상태 판정 | **`CONFIRMED`**(동작) / **`OUT OF SCOPE`**(내부) |

---

### 화면 복귀 · 재진입 요구 (모듈 횡단)

전용 모듈이 없는 **화면 전체의 확정 요구**다. PHASE 7-1 Navigation에 기록되어 있으며 SPEC-02 F-05 · SPEC-03 §3-4와 같은 사안이다.

| # | 요구 | 근거 | 요구 상태 | 수단 |
|---|---|---|---|---|
| ① | **메인 복귀 시 스크롤 위치 복원** | PHASE 7-1 Navigation | `CONFIRMED` | **`UNVERIFIED`** |
| ② | **메인 복귀 시 접힘 상태(C-08) 유지** | PHASE 7-1 Navigation | `CONFIRMED` | **`UNVERIFIED`** |
| ③ | **같은 세션 재진입 시 접힘·닫힘 상태 유지** | PHASE 7-1 Navigation | `CONFIRMED` | **`UNVERIFIED`** |

- 근거 — "Quick back 54.8% / 39.3% — 되돌아오는 행동 자체가 흔하다"(PHASE 7-1) `OBSERVED`
- **요구는 확정, 수단은 미확정이다.** 저장소 사용 여부·방식은 정하지 않는다 → SPEC-04 §07 · `DQ-13`
- 관련 미확정 — `TR-03A`(뒤로가기·새로고침 후 조건 유지) · `TR-03B`(목록→메인 복귀 시 선택 구간 유지). **둘 다 원 ID는 `TR-03` 하나이며 신규 ID가 아니다**
- `RS-01`의 지속 범위는 별개다 — "해당 진입 1회. 세션 전체로 확장하지 않는다"(확정). **RS-01을 근거로 저장소를 도입하지 않는다**
- 프로토타입은 메모리 전용 `S` 객체로 구현했다 — `PROTOTYPE-ONLY`. 실서비스 구현 방식이 아니다
- 적용 대상 — M-06 · M-07 · M-08(C-08 접힘 상태) · M-03(선택 구간) · `paneMain` 스크롤 위치
- 근거 ID — PHASE 7-1 Navigation · `TR-03` · SPEC-02 F-05 · SPEC-03 §3-4
- 상태 판정 — **`CONFIRMED`(요구) / `UNVERIFIED`(수단)**

---

## 04. 컴포넌트 명세

PHASE 7-1 C절 정의를 **그대로 승계**한다. 재해석하지 않는다.

| ID | 컴포넌트 | 적용 모듈 | 구조 | 상태 | 반응형 | 근거 |
|---|---|---|---|---|---|---|
| **C-01** | AppBar | M-01 | 로고 · 검색(아이콘) · 로그인(텍스트+아이콘) · 전체메뉴(아이콘) · 높이 56 · 스크롤 시 sticky | default / pressed / focus | 전 폭 공통 | PHASE 7-1 C |
| **C-02** | QuickItem | M-02 | 아이콘 + 1줄 라벨 · 3등분 그리드 · 항목당 최소 폭 96 | default / pressed / focus | 2행으로 접히지 않음 | PHASE 7-1 C |
| **C-03** | DataRangeRow **(신규)** | M-03 | 구간 라벨(좌) · 대표 가격(우) · 이동 표식 · **행 전체가 탭 영역** | default / pressed / focus / 가격 미수신 | 세로 1열 5행 고정 · 2열·가로 스크롤·칩 금지 | PHASE 7-1 C · §04-1 |
| **C-04** | SectionHeader | 공통 | 타이틀(18/600) + 선택적 전체보기 링크 · 높이 56 | default | — | PHASE 7-1 C |
| **C-05** | BannerCarousel | M-04 | 가로 슬라이드 + 인디케이터 + **자동재생 정지 컨트롤** · 높이 고정 | default / loading / empty | 폭만 증가 | PHASE 7-1 C |
| **C-06** | ActionCard | M-05 | 제목 · 보조 설명 1줄 · CTA · **이동이 발생하는 카드에만 사용** | default / pressed / disabled | — | PHASE 7-1 C |
| **C-07** | InlineNotice | M-05 | 아이콘 + 문구 · **레이어가 아니라 흐름 안에** | info / caution | — | PHASE 7-1 C |
| **C-08** | CollapsibleSection | M-06 · M-07 · M-08 | 헤더(탭 영역) + 펼침 화살표 + 콘텐츠 · **접힘이 기본값** | collapsed / expanded / loading | — | PHASE 7-1 C |
| **C-09** | LinkList | M-08 · M-09 | 텍스트 링크 세로 나열 · **카드 형태 금지** | default / focus | — | PHASE 7-1 C |
| **C-10** | PopupLayer | M-10 | 딤 + 콘텐츠 + **닫기 3종** | 구조만 · **노출 규칙 미정** | — | PHASE 7-1 C · DV-03 |
| **C-11** | GnbOverlay | M-11 | 전체 카테고리 + 로그인 진입 유지 | open / closed | — | PHASE 7-1 C |

### 04-1. C-03 · M-03 행 높이 — 특별 검증

**문서 간 기록**

| 출처 | 값 | 맥락 |
|---|---:|---|
| PHASE 7-1 C-03 | 60px | "행 높이 60. 60은 터치 타깃 44 + 상하 8" |
| CH-13 | 64px | "보조 설명 1줄 추가에 따른 조정. AtF 551 → 588px" |
| CH-57 | 68px | "행 72px 시도 → 배너 714px(폴드 밖) · 행 68px으로 회수" |
| CH-60 | 행 68px 유지 (리스트 전환) | — |
| 프로토타입 CSS `.rrow` | `min-height: 70px` | — |

**2026-08-27 실렌더 측정** — `RENDERED FACT`

| 항목 | 값 |
|---|---|
| `box-sizing` | `border-box` |
| `min-height` | 70px |
| `padding` | 상 12 / 하 12 |
| `border` | 0 |
| **기본 렌더 높이** | **70.00px** |
| **콘텐츠 높이** | **46.00px** (= 70 − 24) |
| **보조 설명이 2줄이 되는 행** | **78.63 ~ 78.92px** (콘텐츠 54.6~54.9) |
| 행간 간격 | 0 (헤어라인 구분) |

**폭별 2줄 발생 양상**

| 화면 폭 | 렌더 높이 |
|---|---|
| 360 | 70 / 78.63 혼재 |
| 368 (데스크톱 프레임 `--dw:390`) | 70 × 3 · 78.63 × 2 |
| 390 (실기기) | 70 × 4 · 78.92 × 1 |
| 430 | **70 × 5 (전부 균일)** |

**판정**

| 구분 | 내용 |
|---|---|
| 실렌더 기본값 | **70px** `RENDERED FACT` |
| 실렌더 최대값 | **78.92px** (보조 설명 2줄) `RENDERED FACT` |
| 문서 값과의 차이 | 60 / 64 / 68 **어느 것과도 일치하지 않는다** |
| **SPEC-01에서 적용할 기준** | **적용하지 않는다.** 실렌더 값을 사실로 기록하되, **어느 값을 운영 기준으로 할지는 결정하지 않는다** |
| 추가 확인 필요 | **예** — ① 60/64/68/70 중 어느 것이 기준인가 ② 보조 설명 2줄 허용 여부(행 높이 가변 허용 여부) ③ 폭에 따라 5행 높이가 달라지는 것이 의도인가 |
| 상태 | **`UNVERIFIED` — 기준값 결정 필요** |

> **7-1의 근거 "44 + 상하 8 = 60"은 터치 타깃 최소치를 만족한다.** 실렌더 70px도 44px 타깃을 만족한다. 접근성 관점의 위반은 없다 `CONFIRMED`. 다만 **AtF 예산 계산의 입력값이 달라진다**(§05).

---

## 05. AtF 예산

### 5-1. PHASE 7-1 B의 예산 (문서 기록)

| 항목 | 값 | 산출 근거 |
|---|---:|---|
| 실효 뷰포트 | ≈700 | 844 − 상태바 − 브라우저 주소창 · **가정** |
| M-01 Header | 56 | 터치 타깃 44 + 상하 여백 6 |
| M-02 QuickMenu | 65 | 현행 높이 유지 |
| 모듈 간 간격 | 20 | — |
| M-03 섹션 헤더 | 56 | 타이틀 1줄 + 여백 |
| M-03 구간 5행 | 300 | 60 × 5 |
| M-03 하단 여백 | 24 | — |
| **합계** | **521** | — |
| **잔여** | **약 179** | "M-04 섹션 헤더와 배너 상단이 경계에 걸친다" |

### 5-2. 2026-08-27 실렌더와의 대조

| 항목 | 7-1 문서 | 실렌더(390) | 차이 |
|---|---:|---:|---|
| M-01 | 56 | **56.00** | 일치 |
| M-02 | 65 | **72.00** | **+7** |
| M-03 전체 | 380 (56+300+24) | **522.59** | **+142.59** |
| M-01+M-02+M-03 누적 | 521 | **674.59** (M-04 top 690.6 − 간격) | — |
| M-04 영역 상단 | 경계에 걸침 | **690.6** | AtF 700 **안** |
| M-04 섹션 헤더 상단 | — | **710.6** | AtF 700 **밖** |
| 배너 상단 | 656 / 661 / 682 / 758 (문서별 상이) | **766.6** | AtF 700 **밖** |

> **본 명세는 이 차이를 해석하지 않는다.** 7-1의 예산은 행 60px·QuickMenu 65px 기준이고, 현재 렌더는 행 70px(일부 78.9)·QuickMenu 72px이다. **입력값이 달라졌으므로 예산도 달라진다는 사실만 기록한다** `UNVERIFIED`.

### 5-3. 잔여 영역에 대한 기존 기록 (승계 · 재해석 없음)

> PHASE 7-1 원문 — "잔여 179px을 비우지 않는 이유: M-04의 상단 일부가 **의도적으로 잘려 보이게 배치**한다. 아래에 콘텐츠가 더 있다는 신호를 만들기 위해서다. 스크롤 도달률이 44.5% / 39.2%인 상태에서 첫 화면이 깔끔하게 끝나면 '여기까지'로 읽힐 수 있다. **가설 · 검증 필요** — 개편 후 도달률로 확인한다."

이 항목은 **`ASSUMED`(가설)** 로 유지한다. 현재 렌더가 이 의도를 충족하는지는 판단하지 않는다.

### 5-4. 레이아웃 불변 조건 (7-1 B · 그대로 승계)

| # | 조건 | 실렌더 대조 |
|---|---|---|
| ① | M-03의 5행은 **어떤 폭에서도 5개 모두 보인다** | **충족** — 360/368/390/430 전부 5행 `RENDERED FACT` |
| ② | **M-02는 65px를 넘지 않는다** | **미충족 — 72px** `UNVERIFIED` (§03 M-02) |
| ③ | M-01+M-02+M-03이 실효 뷰포트를 초과하면 **M-02를 내리는 것이 아니라 M-03 섹션 헤더를 압축**한다 — 모듈 순서는 PHASE 6 확정값 | 조건 자체는 `CONFIRMED` · 적용 여부 미판단 |

---

## 06. 반응형

### 6-1. 확정 규칙 (PHASE 7-1 E)

| 구간 | 폭 | 규칙 |
|---|---|---|
| **BP-S** compact | **< 360** | 좌우 여백 12로 축소 · C-03은 여전히 1행 1구간 · 가격 폰트 13px 허용 |
| **BP-M** 기본 | **360 ~ 430** | 좌우 여백 16 · 본 문서의 모든 수치가 이 구간 기준 |
| **BP-L** 대형 | **> 430** | 콘텐츠 폭 상한 480 · 중앙 정렬 · 요소를 늘려 채우지 않는다 |

결정 요인 — C-03에서 최장 라벨 "71GB 이상" + 최장 가격 "39,200원~"이 한 줄에 들어가는 최소 폭. `CONFIRMED`

**어떤 폭에서도 깨지지 않아야 하는 것** — ① C-03 5행 동시 노출 ② 터치 타깃 44×44 ③ M-02 3등분 유지 ④ 가격 우측 정렬. `CONFIRMED`
**가로 모드·확대** — 가로 모드는 별도 설계하지 않되 깨지지 않을 것만 보장. 200% 확대에서 C-03이 2줄이 되는 것은 허용하되 5행 존재·탭 가능. `CONFIRMED`

### 6-2. 프로토타입 구현과의 차이 — 두 건

| # | 항목 | 문서 규칙 | 프로토타입 구현 | 판정 |
|---|---|---|---|---|
| ① | BP-S 경계 | **< 360** (360은 BP-M) | `w <= 360 ? "s"` — **360을 BP-S로 처리** | **1px 경계 불일치** `UNVERIFIED` |
| ② | BP 전환 방식 | 화면 폭에 따른 구간 | `data-bp`는 **검증 도구의 폭 버튼(360/390/430/480)으로만 갱신**된다. 실제 뷰포트 폭 변화에 반응하지 않는다 | **`PROTOTYPE-ONLY`** — 검증 장치의 한계이며 운영 요구가 아니다 |

> 추가 관측 — 실기기 경로(`@media max-width:640px`)에서는 `.screen[data-bp]{--pad:16px}`가 모든 구간을 덮어써 **BP-S의 여백 12px이 적용되지 않는다** `PROTOTYPE-ONLY`.
> **새 breakpoint를 만들지 않는다.** 위 두 건은 확인 항목으로만 기록한다.

---

## 07. 접근성 요건

PHASE 7-1 G에서 확정된 항목만 승계한다. **새 규칙을 추가하지 않는다.**

| # | 항목 | 규칙 | 적용 위치 | 상태 |
|---|---|---|---|---|
| 1 | **터치 영역** | 최소 44 × 44 · 인접 타깃 간 최소 간격 8 | C-01 아이콘 · C-02 · C-03 행 · C-10 닫기 | `CONFIRMED` |
| 2 | **`aria-expanded`** | C-08에 부여 · **화살표 방향만으로 상태를 전달하지 않는다** | M-06 · M-07 · M-08 · M-01(전체메뉴 버튼) | `CONFIRMED` |
| 3 | **`aria-current`** | 선택 상태 전달 | M-03 선택 행 | `OBSERVED`(프로토타입 구현) |
| 4 | **tab semantics** | `role=tablist` / `role=tab` / `aria-selected` / roving tabindex / 좌우 방향키 | M-06 3탭 | `CONFIRMED` |
| 5 | **focus trap** | 레이어 열림 시 포커스를 안에 가두고, 닫으면 **호출 지점으로 복귀** | M-10 · M-11 · 검색 | `CONFIRMED` |
| 6 | **reduced motion** | `prefers-reduced-motion`에서 자동 전환 중지 · 정지 컨트롤 필수 · 현재 위치를 텍스트로도 전달 | C-05 / M-04 | `CONFIRMED` |
| 7 | **scroll lock** | 열림 중 배경 스크롤 잠금 | M-10 · M-11 (C-10 · C-11) | `CONFIRMED` |

**함께 확정된 항목 (7-1 G · 위 7항목과 같은 절)**

| 항목 | 규칙 |
|---|---|
| 명도 대비 | 본문 4.5:1 이상 · 큰 텍스트·아이콘 3:1 이상 · **비활성 상태도 읽을 수 있어야 한다**(C-06 disabled) |
| 색 단독 의존 금지 | 상태를 색으로만 구분하지 않는다 — 문구·아이콘 병행 (C-07) |
| 접근가능 이름 | C-03 **행 전체가 하나의 링크로 읽혀야 한다** — "데이터 3GB 이하, 8,900원부터, 요금제 목록" |
| 포커스 순서 | DOM 순서 = 화면 순서 = 우선순위 순서 (M-01 → M-02 → M-03 → …) |
| 포커스 표시 | 모든 조작 요소에 보이는 포커스 링. 제거하지 않는다 |
| 텍스트 확대 | 200% 확대에서 콘텐츠 손실 없음 · 가로 스크롤 발생 금지 |
| 이미지 텍스트 | 배너 텍스트를 이미지에 굽지 않는다. 굽는 경우 동일 내용 대체 텍스트 필수 |

> 근거 — "Dead click이 2.4% / 1.5%로 존재한다(FACT). 원인은 특정되지 않았지만, 어포던스·타깃 크기·상태 전달은 접근성 규칙과 정확히 같은 항목을 다룬다."

---

## 08. 디자인 토큰

**세 가지를 섞지 않는다.**

| 구분 | 대상 | 상태 |
|---|---|---|
| **1. 실측 / 기존 확정값** | 뉴트럴 스케일 — `--n-0` ~ `--n-900` (ink `#191919` · muted `#666666` 등 실측, CH-43 "실측 토큰 전면 교체") | `OBSERVED` |
| **2. Prototype 임시값** | 브랜드 강조색 `--brand-50` ~ `--brand-700` (인디고 `#6B55E6` 계열) — **요청자 지시로 시안값 채택**(CH-59). 운영 실측 퍼플 `#662D91`이 확인됐으나 채택되지 않음 | **`UNVERIFIED`** OI-01 · D-10(FR-07) |
| **2. Prototype 임시값** | BI 색 — 제공 이미지 **샘플링값** (`--bi-magenta` 등) | **`UNVERIFIED`** |
| **3. 미확보 / 미확정** | **BI 원본 CI 벡터·컬러값** — 브랜드 부서 원본 미제공 | **`OPEN`** OI-11 |
| **3. 미확보 / 미확정** | 타이포·아이콘 토큰 실측값 | `UNVERIFIED` OI-01 |
| **3. 미확정** | M-03 라벨 문구 · 섹션 타이틀 · 가격 표기 문구 | **`OPEN`** OI-05 |

> **브랜드 컬러·토큰을 추정하지 않는다.** 프로토타입 `:root` 값은 **개발 명세값이 아니다.**
> 원자료 주의 — "`:root` 토큰 교체 시 **대비 검증을 다시 수행해야 한다**"(OI-01). 현재 인디고 스케일에서 흰 텍스트를 얹는 채운 버튼은 500(5.16:1)이 아니라 **600(7.00:1)**을 쓴다는 기록이 있다 `OBSERVED`.
> UI-P6 — "기존 서비스의 시각 언어를 승계한다. 새 디자인 시스템을 정의하지 않는다. **브랜드 색상값은 본 문서에서 확정하지 않는다**" `CONFIRMED`

---

## 09. 모듈 순서

### 9-1. 현재 프로토타입 순서 (실렌더)

```
M-01 P0 → M-02 P2 → M-03 P0 → M-04 P1 → M-05 P1
       → M-06 NDV → M-07 P3 → M-08 P2 → M-09 P3
       (M-10 · M-11 = 오버레이)
```
`RENDERED FACT` — PHASE 6 확정 순서 및 PHASE 7-1 B와 일치.

### 9-2. 기존 결정사항

| 항목 | 내용 | 상태 |
|---|---|---|
| 모듈 순서 | PHASE 6 확정값 · PHASE 7-1은 이를 그대로 사용 | `CONFIRMED` |
| M-02 / M-03 상하 순서 | **초기값이며 확정이 아니다** — M-03의 성과 이력이 없어 데이터로 결정할 수 없다. 개편 후 동일 단위 비교 | **`OPEN`** DV-05 · OI-03 |
| 순서 변경 시 원칙 | 순서를 바꾸는 대신 **M-03 섹션 헤더를 압축**한다 | `CONFIRMED` (7-1 B 불변 조건 ③) |

### 9-3. D-02(FR-07) 타임딜 순서

> **Prototype 기준 현재 순서를 참조하되, D-02(FR-07) 확정 전까지 최종 적용 순서는 미확정.**

| 항목 | 내용 | 상태 |
|---|---|---|
| D-02(FR-07) 상태 | **결정 필요** — "우선"의 정의와 요금제와의 순서 | **`OPEN`** |
| 검토된 안 | A~D 4안 (`timedeal.html`) — 본 명세에서 평가하지 않는다 | `OPEN` |
| AtF 영향 | A안은 M-03을 아래로 밀 가능성이 기록돼 있다 | `OBSERVED`(기록) |
| M-07 귀착 | PHASE 6 문장상 타임딜의 **유일한 명시적 귀착점이나 결정으로 기록되지 않음** | `UNVERIFIED` — 추적 공백 |

**따라서 §9-1의 순서를 최종 확정 순서로 기술하지 않는다.** `OPEN`

---

## 10. 목적지 매핑

| 모듈 | 요소 | 목적지 | 상태 |
|---|---|---|---|
| M-01 | 로그인 | `/login/app` | `CONFIRMED` PHASE 6 E |
| M-02 | ① 전체 요금제 | `/product/pric/usim/pricList` | `CONFIRMED` |
| M-02 | ② 휴대폰 | `/shop/mobile/mobileJoinIntro` | `CONFIRMED` |
| M-02 | ③ 셀프개통 | `/shop/self/openingGuide` | `CONFIRMED` |
| M-03 | 구간 행 | `/product/pric/usim/pricList` (조건 동반) | `CONFIRMED` |
| M-04 | 배너 / 전체보기 | `/event-benefit/event/ongoing/{id}` · `/event-benefit/event/ongoing` | `CONFIRMED` |
| M-05 | 가입 안내 / 셀프개통 | `/shop/mobile/mobileJoinIntro` · `/shop/self/openingGuide` | `CONFIRMED` DD-10 |
| M-06 · M-07 · M-08 · M-09 · M-11 | 각 링크 | 프로토타입 경로 | **`PROTOTYPE-ONLY`** — 실서비스 경로 미대조 |

**미확정 2건 (유지)**

| ID | 내용 | 상태 |
|---|---|---|
| **DC-01** | 중복 목적지 라벨 — **M-02 '휴대폰'과 M-05 '가입 안내'가 동일 URL(`/shop/mobile/mobileJoinIntro`)을 다른 이름으로 가리킨다** | **`OPEN`** — 사실만 기록 · 라벨 정책은 요청자 결정 |
| **DC-04** | 일부 CTA의 **목적지 화면 주체**(기존 페이지 / 신규) 미정 | **`OPEN`** — 목적지 URL만 기록 |

> **목적지 화면의 상세 구조를 작성하지 않는다.** `OUT OF SCOPE`
> DD-15 — 메인 → `pplrPpn` **직결 폐기**(페이지는 유지). 현재 `pplrPpn`은 M-11에만 존재 `CONFIRMED`.

---

## 11. 추적성

```
D / DD / C / REQ / DV / OI / DC / TR / RS
                 ↓
              SPEC-01
                 ↓
           M-xx / C-xx
                 ↓
             TC-01-xx
```

| 관계 | 연결 |
|---|---|
| **Screen ↔ Functional** | M-01~M-11 ↔ SPEC-02 F-01~F-12 (§03 각 모듈 Interaction 행). F-04는 §10 목적지 매핑, **F-05는 §03 「화면 복귀·재진입 요구(모듈 횡단)」**에 연결된다 |
| **Screen ↔ State** | 각 모듈 상태 행 ↔ SPEC-03 §02 · §03 · §04 |
| **Screen ↔ Data/Handoff** | M-03 대표 가격 · M-04 배너 · M-06 상품 ↔ SPEC-04 §02 · §04 · §05 |
| **Screen ↔ Measurement** | 각 모듈 Measurement 행 ↔ SPEC-05 §02 · §06 |

**새 추적 ID를 만들지 않았다.** 신규는 `TC-01-xx` 뿐이다.

---

## 부록 A. TC — 화면 검증

| TC ID | 대상 | 검증 조건 | 기대 결과 | 근거 ID | 판정 |
|---|---|---|---|---|---|
| TC-01-01 | M-01 | 390 화면 렌더 | 높이 56px · sticky | C-01 · 7-1 B | 가능 |
| TC-01-02 | M-02 | 전 폭(360/390/430) | 3등분 유지 · 2행 미발생 | C-02 · 7-1 E | 가능 |
| TC-01-03 | M-02 | 높이 측정 | **판정 기준 없음** (65 vs 72) | 7-1 B ② | **검증 불가 — 선행 결정 필요** |
| TC-01-04 | M-03 / C-03 | 전 폭 5행 노출 | 5행 전부 존재·탭 가능 | DD-04 · 7-1 E | 가능 |
| TC-01-05 | C-03 | 행 높이 측정 | **판정 기준 없음** (60/64/68/70) | §04-1 | **검증 불가 — 선행 결정 필요** |
| TC-01-06 | C-03 | 터치 타깃 | 44×44 이상 | 7-1 G | 가능 |
| TC-01-07 | C-03 | 접근가능 이름 | 행 전체가 한 문장으로 읽힘 | 7-1 G | 가능 |
| TC-01-08 | M-03 | 금지 요소 | 추천 정렬·체크박스·결과 개수 0건 | DD-07 | 가능 |
| TC-01-09 | AtF | 배너 상단 위치 | **판정 기준 없음** (656/661/682/758 vs 766.6) | §2-4 · §05 | **검증 불가 — 기준 확인 필요** |
| TC-01-10 | AtF | 실효 뷰포트 | **가정값 700px** — 실측 필요 | OI-10 | **검증 불가 — 실측 필요** |
| TC-01-11 | M-04 | 등록 0건 | 영역 미노출 · 빈 상태 문구 없음 | 7-1 · PHASE 6 F | 가능 |
| TC-01-12 | C-05 | 정지 컨트롤 · reduced-motion | 정지 동작 · 자동 전환 미시작 | 7-1 G | 가능 |
| TC-01-13 | M-05 / C-06 | 개통 불가 | CTA disabled + C-07 인라인 · 팝업 없음 | DD-09 · UI-P3 | 가능 |
| TC-01-14 | C-06 | disabled 대비 | 비활성도 읽힘 | 7-1 G | 가능 |
| TC-01-15 | M-06 / C-08 | 초기 상태 | collapsed · `aria-expanded=false` | DD-11 | 가능 |
| TC-01-16 | M-06 | 3탭 semantics | role=tab · aria-selected · 방향키 | 7-1 G | 가능 |
| TC-01-17 | M-06 | 탭 라벨 | **판정 기준 없음** (문서 간 상이) | §07 발견 | **검증 불가 — 라벨 미확정** |
| TC-01-18 | M-07 | 슬롯 규칙 | **판정 기준 없음** | DC-03 | **검증 불가 — 선행 결정 필요** |
| TC-01-19 | M-09 / C-09 | 카드 형태 미사용 | 텍스트 링크 나열 | 7-1 C-09 | 가능 |
| TC-01-20 | M-10 / C-10 | 레이어 접근성 | 포커스 트랩 · 복귀 · 스크롤 잠금 · 닫기 3종 | 7-1 G | 가능 |
| TC-01-21 | M-10 | 노출 규칙 | **판정 기준 없음** | DV-03 | **검증 불가 — 규칙 미확정** |
| TC-01-22 | M-11 / C-11 | open/close | 스크롤 잠금 · ESC · 복귀 · aria-expanded | 7-1 G | 가능 |
| TC-01-23 | M-11 | 내부 메뉴 구조 | **판정 기준 없음** | §03 M-11 | **검증 불가 — 범위 밖** |
| TC-01-24 | 반응형 | BP 경계 | **판정 기준 없음** (360 = S vs M) | §06-2 | **검증 불가 — 확인 필요** |
| TC-01-25 | 반응형 | BP-L 콘텐츠 폭 | 480 상한 · 중앙 정렬 | 7-1 E | 가능 |
| TC-01-26 | 전 화면 | 200% 확대 | 콘텐츠 손실 없음 · 가로 스크롤 없음 · 5행 유지 | 7-1 E · G | 가능 |
| TC-01-27 | 전 화면 | 하단 고정 바 부재 | fixed CTA 0건 | 7-1 Navigation | 가능 |
| TC-01-28 | 디자인 토큰 | 브랜드 값 | **판정 기준 없음** | D-10(FR-07) · OI-01 · OI-11 | **검증 불가 — 미확정** |
| TC-01-29 | 모듈 순서 | 최종 순서 | **판정 기준 없음** | D-02(FR-07) | **검증 불가 — 선행 결정 필요** |
| TC-01-30 | 목적지 | M-01~M-05 경로 | §10 표와 일치 · `/onsale/*` 0건 | PHASE 6 E · DD-10 | 가능 |
| TC-01-31 | 적용 대상 | 두 URL 화면 동일성 | 구성 동일 | PHASE 5.2 · PHASE 6 | 가능 |
| TC-01-32 | 포커스 순서 | DOM 순서 = 화면 순서 | M-01 → M-02 → M-03 → … | 7-1 G | 가능 |
| TC-01-33 | 화면 복귀 | 메인 복귀 시 스크롤 위치·접힘 상태 복원 | 복원됨 | 7-1 Navigation | **부분 — 수단 미확정** |
| TC-01-34 | 재진입 | 같은 세션 재진입 시 접힘·닫힘 상태 유지 | 유지됨 | 7-1 Navigation | **검증 불가 — 수단 미확정** |

**총 34건 — 판정 가능 22 · 부분 1 · 검증 불가 11.** 미확정 사항을 확정형 기대값으로 만들지 않았다.

---

## 부록 B. 미확정 이월

원자료를 재대조해 **실제 상태**로 기록한다. 기존 ID를 변경하지 않는다.

| ID | 항목 | 상태 | 해소 경로 |
|---|---|---|---|
| **D-01**(FR-07) | 운영 단위 병합 여부 | **`OPEN`** | 이해관계자 결정 |
| **D-02**(FR-07) | 타임딜 "우선"의 정의와 순서 | **`OPEN`** | 요청자 결정 |
| **DC-01** | 중복 목적지 라벨 (M-02 '휴대폰' / M-05 '가입 안내') | **`OPEN`** | 요청자 라벨 정책 |
| **DC-03** | M-07 운영 슬롯 규칙 | **`OPEN`** | 제휴영업팀 협의 |
| **DC-04** | 목적지 화면 주체 | **`OPEN`** | 요청자 확정 |
| **DV-01** | `#phoneArea` 태깅 · 내부 요소 식별자 | `UNVERIFIED` · 확대 금지 | 태깅 추가 후 재판정 |
| **DV-03** | 팝업 개수·노출 규칙·주기 | **`OPEN`** | 운영/CMS |
| **DV-05** | M-02 / M-03 순서 | **`OPEN`** · 초기값 | 개편 후 동일 단위 비교 |
| **DV-06** | 푸터 '영역 보기' 클릭 목적 | `UNVERIFIED` · 추적 복원 | 세션 녹화 |
| **DV-07** | Clarity 스크롤 지표 정의 | `UNVERIFIED` | 지표 정의 확인 |
| **OI-01** | 브랜드 토큰 실측값 | `UNVERIFIED` — 실측은 확보됐으나 **채택값은 시안값** | D-10(FR-07) 결정 |
| **OI-05** | M-03 라벨 문구 · 섹션 타이틀 | **`OPEN`** | 카피 단계 |
| **OI-06** | 대표 가격 소스·갱신 주기·정의 | `UNVERIFIED` | 개발/운영 |
| **OI-07** | sticky 헤더 세로 공간 부작용 | `UNVERIFIED` | 실측(OI-10 연동) |
| **OI-10** | **실효 뷰포트 700px = 가정값** | `UNVERIFIED` | 기기 해상도 분포 실측 |
| **OI-11** | BI 원본 CI 벡터·컬러값 | **`OPEN`** | 브랜드 부서 제공 |
| **TR-03**(표기 A) | 뒤로가기·새로고침 후 조건 유지 | `UNVERIFIED` | 개발 확인 |
| **TR-03**(표기 B) | 목록→메인 복귀 시 선택 유지 | `UNVERIFIED` · 범위 밖 | 상세 설계 |
| **TR-04** | 초기화 로직 연결 | **`OPEN`** | 개발 확인 |
| **RS-01** | 복귀 목적 · 인지 수단 · `joinComplete` 내용 · **화면 변형 0건** | `UNVERIFIED` / `OPEN` / `CONDITIONAL` | ME-01 선행 |
| — | **M-03 행 높이 기준값** (60 / 64 / 68 / 실렌더 70·78.9) | **`UNVERIFIED`** | **기준 결정 필요** |
| — | **M-02 높이** (7-1 65 vs 실렌더 72 · 불변 조건 ② 미충족) | **`UNVERIFIED`** | 확인 필요 |
| — | **배너 상단 기준값** (656 / 661 / 682 / 758 vs 실렌더 766.6) | **`UNVERIFIED`** | 기준 시점·경로 확인 |
| — | **BP-S 경계** (문서 <360 vs 구현 ≤360) | `UNVERIFIED` | 확인 필요 |
| — | M-06 탭 라벨 (문서 간 상이) | `UNVERIFIED` | 확인 필요 |
| — | M-06 펼침 실패 동작 | **`SPEC GAP`** | 원칙만 확정 |
| — | 전역 네트워크 오류 감지·복구 전이 | **`SPEC GAP`** | 원칙만 확정 |
| — | 앱 WebView 진입 처리 | **`OPEN`** · `SPEC GAP` | PHASE 6 "상세 설계" 이행 |
| — | 로그인 오류 복귀 처리 | **`OPEN`** · `SPEC GAP` | 동일 |
| — | 셀프개통 가능 시간 값·판정 주체 | `UNVERIFIED` · `PROTOTYPE-ONLY` | SPEC-04 DS-5 |
| — | M-06~M-09 · M-11 목적지 실서비스 경로 | `UNVERIFIED` | 대조 필요 |
| — | 실제 GNB 구조 · 2026.01 개편안과의 관계 | `UNVERIFIED` / `OPEN` | 개발 확인 · OPEN-12 |

**재대조 결과 이월하지 않는 항목**

| ID | 사유 |
|---|---|
| **TR-01 · TR-02** | 실측으로 확정 (SPEC-04 §03) |
| **DV-02** | 검증 **종결** — 결론은 "승격 없이 유보 유지" |
| **DV-04** | 프로토타입은 해소 표기 · PHASE 5.1은 1일 오차 잔존 → **SPEC-05에서 이미 병기·이월 중**. 화면 명세 사안이 아니므로 여기서 중복 이월하지 않는다 |
| **D-12**(FR-07) | 2026-08-27 확정 (대상 정의) |

**본 명세에서 새로 만든 것**

| 항목 | 성격 |
|---|---|
| `TC-01-01` ~ `TC-01-34` | 검증 항목 ID (신규) |

새로운 D / DD / C / REQ / DV / OI / DC / TR / RS ID는 만들지 않았고, 기존 ID를 재번호화하지 않았다.

---

## SPEC-02 · 03 · 04 · 05와의 정합

| 항목 | SPEC-01 | 타 SPEC | 충돌 |
|---|---|---|---|
| 모듈 상태 | 요약 + 참조 | SPEC-03 §02 상세 | 없음 |
| 기능 동작 | Interaction 행에서 참조 | SPEC-02 F-01~F-12 | 없음 |
| 대표 가격 · SAMPLE | 데이터 의존만 표기 | SPEC-04 §02 · §04 · §05 | 없음 |
| 측정 | 모듈별 관측 상태만 | SPEC-05 §02 · §06 | 없음 |
| 셀프개통 시간 | `PROTOTYPE-ONLY` | SPEC-02/03 동일 · SPEC-04 DS-5 | 없음 |
| 탭 라벨 | `UNVERIFIED` | SPEC-02 F-07 · SPEC-03 동일 | 없음 |
| 팝업 규칙 | `OPEN` | SPEC-02 F-12 · SPEC-03 M-10 · SPEC-05 DV-03 | 없음 |
| GNB 내부 | `OUT OF SCOPE` | SPEC-02 F-10 · SPEC-05 §09 동일 | 없음 |
| 브랜드 토큰 | 3구분 | SPEC_PREFLIGHT C-09 동일 | 없음 |
| AtF 700px | `ASSUMED` | SPEC_PREFLIGHT C-10 동일 | 없음 |

---

기준 · PHASE 5.1 · PHASE 5.2 · PHASE 6 · PHASE 7-1(B · C · D · E · F · G · H) · PHASE 7-2 · 7-3 · 7-4 Prototype · PHASE 2 현행 DOM 관측 · SPEC-02 · 03 · 04 · 05 · SPEC_PREFLIGHT · PHASE9_SPEC_READINESS
실렌더 측정 · 2026-08-27 · Chromium · 390×844 실기기 경로 · `prototype.html`(커밋 `beea5bb`)
본 명세는 확정된 결정과 실렌더 사실만을 기술한다. 문서 간 값이 다른 항목은 통합하지 않고 병기했으며, 새로운 UX·디자인·토큰·breakpoint를 만들지 않았다.
