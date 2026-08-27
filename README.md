# U+유모바일 비로그인 모바일 메인 UX 개선 (202608_MainNologin)

`/nologfirst` · `/nologrevisit` 두 화면의 비로그인 요금제 탐색/가입 진입 경험을
Clarity·GA4 행동 데이터로 재분석하고 설계한 개편안이다.

## 실행

저장소 루트(`index.html`)가 **FINAL REPORT**다. 처음 여는 사람이 화면보다 **결정 항목**을 먼저 보도록 진입점을 맞췄다.

| 순서 | 파일 | 답하는 질문 |
|---|---|---|
| 01 | [index.html](./index.html) | 무엇을 결정해야 하는가 |
| 02 | [targetuser.html](./targetuser.html) | 이 화면의 실제 이용자는 누구인가 |
| 03 | [timedeal.html](./timedeal.html) | 타임딜 요청을 어떻게 해석할 것인가 |
| 04 | [alignment.html](./alignment.html) | 왜 그렇게 판단했는가 |
| 05 | [audit.html](./audit.html) | 그 근거가 검증되었는가 |
| 06 | [prototype.html](./prototype.html) | 화면은 어떻게 달라지는가 |

- `stakeholder.html`은 이전 주소이며 `index.html`로 자동 이동한다.
- 상단 메뉴는 리포트 5문서에서 **고정(sticky)** 이다. 프로토타입에서는 고정하지 않는다 — 기기 목업 위에 바가 떠 있으면 화면 판단을 방해한다.
- 로컬 확인: 파일을 브라우저로 바로 열면 된다(외부 의존은 웹폰트 CDN뿐).
- 프로토타입은 모바일 폭(≤640px)에서 디바이스 프레임 없이 전체화면으로 렌더된다.
- 우하단 톱니 버튼 = 검증용 Drawer. 기본 실행 화면은 실제 서비스 화면만 보여준다.

## 서체

본문 서체는 운영과 동일하게 **Pretendard**(SIL OFL 1.1)를 사용한다.
운영은 자체 호스팅이고, 이 저장소는 jsDelivr의 dynamic-subset CSS로 로드한다.

```html
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/pretendard@1.3.9/dist/web/static/pretendard-dynamic-subset.css">
```

- dynamic-subset은 실제로 쓰인 글리프 구간만 내려받는다(이 화면 기준 31개 조각).
- 운영 Pretendard는 **Light·Regular·SemiBold·Bold 4종만** 제공하므로
  본문 타이포는 최대 굵기 **700**을 넘지 않는다(CH-50).
- 예외 2건은 아래 "확인 필요"에 적었다.

## 확인 필요

| 항목 | 내용 |
|---|---|
| weight 500 | UI에 Medium(500)을 쓰는 곳이 있으나 운영 Pretendard에는 500이 없다. 운영 적용 시 400/600 중 하나로 정리하거나 운영에 Medium을 추가할지 결정이 필요하다. |
| weight 800 | BI 로고 재현(`.bi-*`)에만 사용한다. 운영 BI는 이미지 자산이므로 본문 타이포 규칙과 무관하지만, 실제 적용 시 원본 CI 벡터로 교체하는 것이 맞다(OI-11). |

## 상태

프로토타입은 **확정 디자인이 아니라 검증용 산출물**이다.
실제 상품 가격·상품명·이벤트·프로모션은 확정값이 아니며,
근거 등급(OBSERVED / SAMPLE / UNVERIFIED)은 화면 내 Drawer에서 확인할 수 있다.
