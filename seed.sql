-- CONES View 1 snapshot observed 2026-09-25 (not a CSV/API export).
-- Exactly the 19 cards listed in data/raw/CONES_board_status_view1_2026-09-25.txt.
begin;

insert into public.projects (project_name, github_repo_full_name, github_project_number, github_project_url) values ('CONES','seune-h0203/cones',3,'https://github.com/users/seune-h0203/projects/3') on conflict (github_repo_full_name) do update set project_name=excluded.project_name, github_project_number=excluded.github_project_number, github_project_url=excluded.github_project_url;
insert into public.users (github_username, display_name) values ('Hamchaelim','Hamchaelim'), ('ohoobae','ohoobae'), ('qkrtpfls03','qkrtpfls03'), ('seune-h0203','seune-h0203') on conflict (github_username) do update set display_name=excluded.display_name;
insert into public.statuses (project_id,status_name,position,is_done) select project_id,v.status_name,v.position,v.is_done from public.projects cross join (values ('Todo',0,false),('In Progress',1,false),('Done',2,true)) v(status_name,position,is_done) where github_repo_full_name='seune-h0203/cones' on conflict (project_id,status_name) do update set position=excluded.position,is_done=excluded.is_done;
insert into public.milestones (project_id,github_milestone_number,title,state,due_date) select project_id,1,'CONES ? FINAL SUBMISSION','open',null from public.projects where github_repo_full_name='seune-h0203/cones' on conflict (project_id,github_milestone_number) do update set title=excluded.title,state=excluded.state;

delete from public.task_assignees ta using public.tasks t join public.projects p on p.project_id=t.project_id where ta.task_id=t.task_id and p.github_repo_full_name='seune-h0203/cones';
delete from public.tasks t using public.projects p where p.project_id=t.project_id and p.github_repo_full_name='seune-h0203/cones';
insert into public.tasks (project_id,status_id,milestone_id,author_id,github_issue_number,github_project_item_id,issue_url,title,body,issue_state,created_at,closed_at,status_position,card_position)
select p.project_id,s.status_id,m.milestone_id,a.user_id,v.issue_number,null,v.issue_url,v.title,v.body,v.issue_state,v.created_at::timestamptz,v.closed_at::timestamptz,v.status_position,v.card_position from public.projects p cross join (values
(9, 'In Progress', 1, 1, 'https://github.com/seune-h0203/cones/issues/9', '[QA] Animation 및 Interaction 최종 테스트', '## 작업 목적

스크롤 기반 연출과 인터랙션이 모든 환경에서 오류 없이 동작하고, 모션 최소화 설정을 존중하는지 확인한다.


## Task

- [x] Scroll Reveal 확인
- [x] ConnectionSequence 확인
- [x] SystemCycle 확인
- [x] AbilityMotif 확인
- [x] Page Transition 확인
- [x] Custom Cursor 확인
- [x] Video Modal 확인


## Acceptance Criteria

- [x] Animation 오류가 없다.
- [x] Scroll Interaction이 정상이다.
- [x] Mobile에서 문제가 발생하지 않는다.
- [x] Reduced Motion 대응이 유지된다.


## Note

`prefers-reduced-motion: reduce` 환경에서 `ConnectionSequence`가 스크롤 애니메이션 대신 완성된 구도로 표시되는지 함께 확인한다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **SERINA** | `BACKLOG` | `3` |
', 'open', '2026-09-10T05:47:32Z', null, 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(13, 'In Progress', 1, 2, 'https://github.com/seune-h0203/cones/issues/13', '[PRESENTATION] 3분 발표 및 Demo 준비', '## 작업 목적

3분 안에 CONES의 세계관·팀 협업 과정·결과물을 보여줄 수 있도록 발표와 Demo 흐름을 확정한다.


## Task

- [x] 1. CONES 소개
- [x] 2. TWO ORIGINS, ONE SYSTEM
- [x] 3. AI UNIT / COMPUTER UNIT
- [x] 4. 4명의 Artist
- [x] 5. CONNECTION : 00
- [ ] 6. GitHub Kanban
- [ ] 7. Landing Page Demo


## Acceptance Criteria

- [ ] 3분 이내 발표 가능
- [ ] Demo 순서 확정
- [ ] GitHub Repository 링크 준비
- [ ] GitHub Project 링크 준비
- [ ] Landing Page 링크 준비


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `BACKLOG` | `3` |
', 'open', '2026-09-10T05:47:36Z', null, 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(39, 'In Progress', 1, 3, 'https://github.com/seune-h0203/cones/issues/39', '[PRESENTATION] 발표 대본 준비', null, 'open', '2026-09-14T05:10:00Z', null, 'ohoobae', null),
(3, 'Done', 2, 1, 'https://github.com/seune-h0203/cones/issues/3', '[FE] 전체 페이지 콘텐츠 연결 검수', '## 작업 목적

모든 라우트가 정상 연결되고 페이지 간 콘텐츠(월드관/유닛/아티스트)가 서로 모순되지 않는지 확인한다.


## Task

- [ ] Home 연결 확인
- [ ] World 연결 확인
- [ ] Artists 연결 확인
- [ ] Artist Detail 연결 확인
- [ ] Project 연결 확인
- [ ] About 연결 확인
- [ ] Not Found 연결 확인


## Acceptance Criteria

- [ ] 모든 페이지가 정상적으로 연결된다.
- [ ] Navigation이 정상 작동한다.
- [ ] 콘텐츠 간 불일치가 없다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `IN PROGRESS` | `3` |
', 'closed', '2026-09-10T05:47:28Z', '2026-09-12T16:23:17Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(1, 'Done', 2, 2, 'https://github.com/seune-h0203/cones/issues/1', '[PLAN] CONES 프로젝트 최종 작업 관리', '## 작업 목적

CONES 최종 제출까지의 모든 작업을 Kanban으로 관리하고, 팀원별 작업 배분과 진행 상태를 실제 상황과 일치시킨다.


## Task

- [ ] 전체 작업 현황 확인
- [ ] Kanban 상태 관리
- [ ] Milestone 관리
- [ ] 팀원 작업 배분
- [ ] 최종 제출 상태 확인


## Acceptance Criteria

- [ ] 모든 주요 작업이 Kanban에 등록되어 있다.
- [ ] 담당자가 명확하다.
- [ ] 작업 상태가 실제 진행 상황과 일치한다.
- [ ] 최종 제출 전 모든 작업의 상태를 확인할 수 있다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `IN PROGRESS` | `3` |
', 'closed', '2026-09-10T05:47:26Z', '2026-09-10T06:17:02Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(2, 'Done', 2, 3, 'https://github.com/seune-h0203/cones/issues/2', '[CONTENT] 아티스트 정보 최종 검수', '## 작업 목적

4명 아티스트의 프로필 데이터가 로스터·상세 페이지·OG 태그 전반에서 일치하는지 검수한다.


## Task

- [ ] SERINA / BAESAN / HYUN JIZEL / HAM BOM 4명 정보 검수
- [ ] Stage Name 확인
- [ ] Unit 확인
- [ ] Ability 확인
- [ ] Position 확인
- [ ] Image 확인
- [ ] Artist Detail Route 확인


## Acceptance Criteria

- [ ] 4명의 정보가 일치한다.
- [ ] 잘못된 이미지가 없다.
- [ ] Artist Detail 페이지와 정보가 일치한다.


## Note

모든 아티스트 데이터는 `src/data/artists.ts` 단일 소스에서 관리된다. `id`(예: `rina`)는 기존 라우트/에셋 호환을 위해 유지하되, 노출 텍스트는 **SERINA / 세리나**로 표기되는지 확인한다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **SERINA** | `READY` | `2` |
', 'closed', '2026-09-10T05:47:27Z', '2026-09-10T07:19:50Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(4, 'Done', 2, 4, 'https://github.com/seune-h0203/cones/issues/4', '[FE] 이미지 및 Asset 경로 최종 검수', '## 작업 목적

로컬 dev 환경과 GitHub Pages 서브패스 환경 양쪽에서 모든 이미지 에셋이 정상 로딩되는지 확인한다.


## Task

- [ ] Logo 경로 확인
- [ ] Artist Image 경로 확인
- [ ] Director Image 경로 확인
- [ ] Poster 경로 확인
- [ ] 기타 Image Asset 경로 확인


## Acceptance Criteria

- [ ] Broken Image가 없다.
- [ ] GitHub Pages에서도 Asset이 정상적으로 로딩된다.


## Note

에셋 경로는 `src/utils/asset.ts`의 `asset()`을 통해 `BASE_URL` 기준으로 해석된다. `vite.config.ts`의 `base: "./"` 설정과 함께 확인할 것.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `READY` | `2` |
', 'closed', '2026-09-10T05:47:29Z', '2026-09-12T16:23:02Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(5, 'Done', 2, 5, 'https://github.com/seune-h0203/cones/issues/5', '[FE] Teaser Video Manifest 최종 검수', '## 작업 목적

`manifest.json`이 실제로 존재하는 영상 파일만 참조하도록 하고, 없는 경우 SIGNAL PENDING 정책이 유지되는지 확인한다.


## Task

- [ ] Desktop video 확인
- [ ] Mobile video 확인
- [ ] Poster 확인
- [ ] Video path 확인
- [ ] 실제 파일 존재 여부 확인


## Acceptance Criteria

- [ ] 존재하지 않는 파일을 참조하지 않는다.
- [ ] 실제 영상이 정상적으로 연결된다.
- [ ] 영상이 없는 경우 기존 SIGNAL PENDING 정책을 유지한다.


## Note

**현재 상태 확인 결과:** `public/videos/manifest.json`의 `teasers`에는 `baesan`만 등록되어 있다. 홈페이지 `WATCH TEASER` 버튼이 참조하는 `project` 키는 아직 등록되어 있지 않아 포스터 폴백으로 동작한다. 의도된 상태인지 확인 필요.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `3` |
', 'closed', '2026-09-10T05:47:29Z', '2026-09-12T16:22:43Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(6, 'Done', 2, 6, 'https://github.com/seune-h0203/cones/issues/6', '[FE] GitHub Pages Routing 최종 검수', '## 작업 목적

HashRouter 기반 라우팅이 GitHub Pages 정적 호스팅에서 새로고침·딥링크 포함 정상 동작하는지 확인한다.


## Task

- [ ] `/` 확인
- [ ] `#/world` 확인
- [ ] `#/artists` 확인
- [ ] `#/artists/:artistId` 확인 (rina · baesan · hyun-jizel · ham-bom)
- [ ] `#/project` 확인
- [ ] `#/about` 확인
- [ ] Not Found Route 확인


## Acceptance Criteria

- [ ] 모든 Route가 정상 작동한다.
- [ ] HashRouter 구조가 정상이다.
- [ ] GitHub Pages 환경에서 정상적으로 접근된다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `3` |
', 'closed', '2026-09-10T05:47:30Z', '2026-09-12T16:22:27Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(7, 'Done', 2, 7, 'https://github.com/seune-h0203/cones/issues/7', '[QA] Desktop 반응형 테스트', '## 작업 목적

데스크톱 해상도 전반에서 레이아웃이 깨지지 않고 타이포그래피가 의도대로 보이는지 검수한다.


## Task

- [ ] Navigation 확인
- [ ] Hero 확인
- [ ] Typography 확인
- [ ] Artist Grid 확인
- [ ] World 확인
- [ ] Connection 확인
- [ ] System Cycle 확인
- [ ] Video 확인
- [ ] CTA 확인
- [ ] Footer 확인


## Acceptance Criteria

- [ ] Layout이 깨지지 않는다.
- [ ] 텍스트가 잘리지 않는다.
- [ ] 가로 스크롤이 발생하지 않는다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **SERINA** | `READY` | `3` |
', 'closed', '2026-09-10T05:47:31Z', '2026-09-10T06:17:13Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(10, 'Done', 2, 8, 'https://github.com/seune-h0203/cones/issues/10', '[QA] Accessibility 최종 검수', '## 작업 목적

키보드 사용자와 스크린리더 사용자가 사이트의 주요 기능을 문제없이 사용할 수 있는지 검수한다.


## Task

- [ ] alt text 확인
- [ ] semantic HTML 확인
- [ ] keyboard navigation 확인
- [ ] focus-visible 확인
- [ ] skip link 확인
- [ ] modal focus trap 확인
- [ ] Escape 동작 확인
- [ ] reduced motion 확인


## Acceptance Criteria

- [ ] 주요 기능을 키보드로 사용할 수 있다.
- [ ] 이미지에 적절한 alt가 있다.
- [ ] Modal이 정상적으로 닫힌다.
- [ ] 접근성 관련 치명적인 문제가 없다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **BAESAN** | `BACKLOG` | `3` |
', 'closed', '2026-09-10T05:47:33Z', '2026-09-12T16:22:08Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(11, 'Done', 2, 9, 'https://github.com/seune-h0203/cones/issues/11', '[QA] Production Build 테스트', '## 작업 목적

배포 전에 프로덕션 빌드가 타입 오류 없이 통과하는지 확인한다.


## Task

- [ ] `npm run build` 실행
- [ ] 필요 시 `npm run dev` / `npm run preview` 확인
- [ ] TypeScript Error 확인
- [ ] Build Error 확인
- [ ] Import Error 확인
- [ ] Asset Error 확인


## Acceptance Criteria

- [ ] `npm run build`가 성공한다.
- [ ] 치명적인 오류가 없다.


## Note

`npm run build`는 `tsc --noEmit` 후 Vite 프로덕션 빌드를 수행한다.


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `2` |
', 'closed', '2026-09-10T05:47:34Z', '2026-09-12T16:21:37Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(12, 'Done', 2, 10, 'https://github.com/seune-h0203/cones/issues/12', '[DEPLOY] GitHub Pages 최종 배포 확인', '## 작업 목적

GitHub Pages에 실제 배포된 프로덕션 사이트가 정상 동작하는지 최종 확인한다.


## Task

- [ ] GitHub Pages 접속 확인
- [ ] Home 확인
- [ ] World 확인
- [ ] Artists 확인
- [ ] Artist Detail 확인
- [ ] Project 확인
- [ ] About 확인
- [ ] Images 확인
- [ ] Videos 확인
- [ ] Navigation 확인


## Acceptance Criteria

- [ ] Production 사이트가 정상적으로 열린다.
- [ ] 주요 페이지가 정상적으로 작동한다.


## Note

**선행 조건:** 저장소 `Settings → Pages → Source → GitHub Actions` 설정이 필요하다. 저장소가 방금 생성되었으므로 아직 Pages 배포가 한 번도 실행된 적 없다. 대상 URL: https://seune-h0203.github.io/cones/


---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `2` |
', 'closed', '2026-09-10T05:47:35Z', '2026-09-12T16:21:22Z', 'seune-h0203', 'CONES — FINAL SUBMISSION'),
(32, 'Done', 2, 11, 'https://github.com/seune-h0203/cones/issues/32', '[BE] Supabase 커머스 백엔드(스키마·RLS·RPC) 구축', '## 작업 목적

MD Collection 이미지를 하나의 상품으로 뭉뚱그리지 않고, 4명 × 8종 = 32개의 실제 상품을 실제 데이터베이스로 관리하며 주문 생성 시 서버 측에서 가격/재고를 재계산하는 백엔드를 구축한다.

## 구현 내용

- Supabase(Postgres + Auth + PostgREST) 프로젝트 연동
- `products` / `carts` / `cart_items` / `orders` / `order_items` 5개 테이블 + 인덱스 정의
- 전 테이블 Row Level Security 적용 — 사용자는 자신의 장바구니/주문만 읽고 쓸 수 있음
- `create_order()` SECURITY DEFINER RPC: 장바구니 내용을 서버에서 재검증(재고 `FOR UPDATE` 잠금, 가격 재계산, 배송비 계산)한 뒤 orders/order_items 생성, 재고 차감, 품절 처리, 장바구니 비우기
- `mock_pay_order()` RPC: `PENDING → PAID` 목업 결제 전환 (실 PG 연동 전 시연용)
- 32개 상품 시드 데이터 (`ON CONFLICT DO UPDATE`로 재실행 안전)

## 주요 변경사항

- `supabase/schema.sql` 신규 (테이블, RLS, RPC, 시드)
- `src/lib/supabase.ts` 신규 (Supabase 클라이언트, `isCommerceConfigured` 플래그)
- `src/lib/database.types.ts` 신규 (테이블 타입 정의)
- `.env.example`, `.gitignore`(.env 제외) 추가

## 관련 파일

- `supabase/schema.sql`
- `src/lib/supabase.ts`
- `src/lib/database.types.ts`
- `.env.example`

## 완료 조건

- [x] 5개 테이블과 RLS 정책이 실제 Supabase 프로젝트에 배포된다
- [x] `create_order()`가 클라이언트가 보낸 총액이 아니라 서버에서 재계산한 금액으로 주문을 생성한다
- [x] 재고가 0이 되면 자동으로 SOLD_OUT 처리된다
- [x] 다른 사용자의 장바구니/주문을 조회·수정할 수 없다 (RLS)

## 실제 완료 여부

**완료.** REST API로 실제 회원가입 → 장바구니 담기 → `create_order()` 호출 → orders/order_items 생성 → 재고 차감(37→35 등) 확인 → 다른 계정으로 접근 차단까지 전 구간을 직접 호출해 검증했다. 검증 도중 `create_order()`의 `where order_id = v_order_id` 구문이 함수의 OUT 파라미터명과 충돌해 "ambiguous column" 오류가 발생하는 버그를 발견해 `oi.order_id`로 수정, 재배포 후 재검증까지 완료했다.

---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `5` |
', 'closed', '2026-09-12T16:20:20Z', '2026-09-12T16:20:46Z', 'seune-h0203', null),
(33, 'Done', 2, 12, 'https://github.com/seune-h0203/cones/issues/33', '[FE] Shop/Cart/Checkout/Order 커머스 프론트엔드 구현', '## 작업 목적

랜딩페이지 MD 배너에서 이어지는 실제 커머스 UI(Shop → Product Detail → Cart → Checkout → Order Complete → My Orders)와 회원가입/로그인 화면을 구현한다.

## 구현 내용

- `react-router-dom`의 `BrowserRouter`를 재도입해 One Page Landing(`Home`)과 커머스 라우트를 함께 렌더링
- Shop(아티스트 필터, 32개 상품 그리드), Product Detail, Cart(수량 변경/삭제, 소계), Checkout(주문 생성), Order Complete(주문 요약), My Orders(주문 목록 + mock 결제 버튼) 페이지
- `AuthContext`(Supabase 세션/회원가입/로그인/로그아웃), `CartContext`(장바구니 상태, 낙관적 업데이트, `ensureCartId`) 신규
- Navbar에 CART(수량 배지) / LOGIN / MY ORDERS 링크 추가, 아티스트 프로필 모달의 "OFFICIAL MD" 버튼을 실제 `/shop?artist=` 딥링크로 연결
- 로그인하지 않은 사용자가 `/cart`, `/checkout`, `/mypage/orders` 접근 시 `/login`으로 리다이렉트

## 주요 변경사항

- `src/App.tsx` — BrowserRouter/Routes 추가 (랜딩페이지 히어로/스크롤 구조는 변경 없음)
- `src/pages/shop/*`, `src/pages/auth/*` 신규
- `src/contexts/AuthContext.tsx`, `src/contexts/CartContext.tsx` 신규
- `src/components/Navbar.tsx`, `src/components/ArtistProfileModal.tsx`, `src/pages/Home.tsx` 커머스 딥링크 연동
- `public/404.html` 신규 — GitHub Pages SPA 라우팅 리다이렉트

## 관련 파일

- `src/App.tsx`
- `src/pages/shop/Shop.tsx`, `ProductDetail.tsx`, `Cart.tsx`, `Checkout.tsx`, `OrderComplete.tsx`, `MyOrders.tsx`
- `src/pages/auth/Login.tsx`, `Signup.tsx`
- `src/contexts/AuthContext.tsx`, `src/contexts/CartContext.tsx`
- `src/components/Navbar.tsx`, `src/components/ArtistProfileModal.tsx`, `src/pages/Home.tsx`
- `public/404.html`

## 완료 조건

- [x] Shop → Product Detail → Cart → Checkout → Order Complete → My Orders 전체 흐름이 실제 로그인 세션과 DB로 동작한다
- [x] 랜딩페이지 첫 화면(히어로)은 이 작업 과정에서 수정되지 않았다
- [x] 로그인하지 않은 사용자는 장바구니/주문 페이지에서 로그인 화면으로 리다이렉트된다
- [x] `npm run build`(`tsc --noEmit` + `vite build`)가 통과한다

## 실제 완료 여부

**완료.** 실제 Supabase 프로젝트에 연결해 회원가입 → 로그인 → 상품 조회 → 장바구니 담기 → 결제 → 주문 완료 → My Orders 조회까지, 프론트엔드가 호출하는 것과 동일한 요청을 REST API 레벨로 직접 실행해 검증했다 (이 작업 환경에 브라우저 자동화 도구가 없어 UI 스크린샷 대신 API/빌드 레벨로 검증).

---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `5` |
', 'closed', '2026-09-12T16:20:23Z', '2026-09-12T16:20:49Z', 'seune-h0203', null),
(34, 'Done', 2, 13, 'https://github.com/seune-h0203/cones/issues/34', '[DB] order_items 이미지 컬럼 추가 및 주문 데이터 마이그레이션', '## 작업 목적

주문 상세 / My Orders 화면에서 실제 구매했던 상품 사진을 보여줄 수 있도록, 주문 시점의 상품 이미지를 주문 데이터에 별도로 저장한다.

## 구현 내용

- `order_items` 테이블에 `image` 컬럼 추가 (`ALTER TABLE ... ADD COLUMN IF NOT EXISTS`로 기존 배포 환경에도 안전하게 적용)
- `create_order()` RPC가 주문 생성 시 상품의 `image`를 `order_items`에 함께 복사하도록 갱신 — `product_name`과 같은 이유로, 이후 상품이 삭제·변경돼도 과거 주문 화면은 그대로 유지됨
- `MyOrders.tsx`에서 PostgREST embedded resource(`orders?select=*,order_items(id,product_name,image)`)로 주문별 썸네일 조회, `OrderComplete.tsx`에서 라인 아이템별 이미지 렌더링

## 주요 변경사항

- `supabase/schema.sql` — `order_items.image` 컬럼 및 `create_order()` INSERT 구문 갱신
- `src/lib/database.types.ts` — `OrderItemRow.image` 필드 추가
- `src/pages/shop/OrderComplete.tsx`, `MyOrders.tsx`, `shop.module.css` — 썸네일 렌더링

## 관련 파일

- `supabase/schema.sql`
- `src/lib/database.types.ts`
- `src/pages/shop/OrderComplete.tsx`
- `src/pages/shop/MyOrders.tsx`
- `src/pages/shop/shop.module.css`

## 완료 조건

- [x] 새로 생성되는 주문의 `order_items.image`가 실제로 채워진다
- [x] My Orders 목록과 주문 상세 페이지에 상품 이미지가 표시된다
- [x] 마이그레이션 이전에 생성된 주문은 에러 없이 빈 자리로 표시된다 (하위 호환)

## 실제 완료 여부

**완료.** 실제 Supabase 프로젝트에 `ALTER TABLE`과 갱신된 RPC를 배포한 뒤, 신규 주문(SERINA KEYRING) 생성 → `order_items.image`에 `images/md/products/rina-keyring.jpg`가 정상적으로 채워지는 것과 embedded 쿼리 결과까지 REST API로 직접 확인했다.

---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `2` |
', 'closed', '2026-09-12T16:20:25Z', '2026-09-12T16:20:51Z', 'seune-h0203', null),
(35, 'Done', 2, 14, 'https://github.com/seune-h0203/cones/issues/35', '[FIX] 라우팅 서브패스 및 이미지 경로 버그 수정', '## 작업 목적

GitHub Pages 서브패스(`/cones/`) 배포 환경에서 발견된 두 가지 실사용 버그 — 네비게이션이 도메인 루트로 이탈하는 문제와 상품 상세 페이지 사진이 깨지는 문제 — 를 수정한다.

## 구현 내용

- **Navbar 서브패스 이탈**: `Navbar.tsx`의 섹션 링크가 `href={"/" + item.path}`로 도메인 루트 기준 절대경로를 하드코딩하고 있어, `/cones/` 하위에 배포된 사이트에서 ORIGINS/ARTISTS 등을 누르면 `/cones/`가 빠진 `https://seune-h0203.github.io/#artists`로 이동하던 버그를 수정. `BrowserRouter`의 `basename`과 동일한 런타임 감지값(`window.__CONES_BASE__`)을 사용하도록 변경.
- **상품 이미지 깨짐**: `utils/asset.ts`가 Vite 빌드타임 상대 경로(`import.meta.env.BASE_URL`, 값은 `"./"`)를 그대로 써서, `/shop/product/:slug`처럼 라우트가 3단계 깊어지면 브라우저의 상대경로 해석 규칙상 배포 루트가 아니라 상위 경로 한 단계만 벗겨진 잘못된 URL이 만들어져 이미지가 404 나던 버그를 수정. 동일하게 `window.__CONES_BASE__` 기준 절대경로로 변경.
- **MD 상품 이미지 화질**: 원본 MD 포스터(1536×1024)에서 상품 하나가 차지하는 영역이 약 250~290px로 작아, Shop 4열 고정 그리드(카드당 ~300~390px)와 Product Detail 480px 컬럼이 이를 최대 ~2배로 확대 표시해 흐릿하게 보이던 문제를, 그리드 컬럼을 `auto-fill, minmax(240px, 1fr)`로 상품 원본 해상도에 가깝게, Detail 컬럼을 320px로 줄여 완화.

## 주요 변경사항

- `src/components/Navbar.tsx`
- `src/utils/asset.ts`
- `src/pages/shop/shop.module.css`

## 관련 파일

- `src/components/Navbar.tsx`
- `src/utils/asset.ts`
- `src/pages/shop/shop.module.css`

## 완료 조건

- [x] `https://seune-h0203.github.io/cones/`에서 네비게이션이 `/cones/` 하위에서만 이동한다
- [x] `/shop/product/:slug` 페이지의 상품 사진이 정상 로드된다
- [x] Shop / Detail 이미지 확대 배율이 완화된다

## 실제 완료 여부

**완료.** 실 배포 사이트(`https://seune-h0203.github.io/cones/`)에 각 수정을 순서대로 배포한 뒤, `curl`로 이미지 URL 200 응답과 GitHub Actions 빌드 성공을 직접 확인했다.

---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `3` |
', 'closed', '2026-09-12T16:20:28Z', '2026-09-12T16:20:54Z', 'seune-h0203', null),
(36, 'Done', 2, 15, 'https://github.com/seune-h0203/cones/issues/36', '[DEVOPS] GitHub Actions 배포 워크플로 Supabase 환경변수 연동', '## 작업 목적

GitHub Pages 배포 빌드가 Supabase 접속 정보 없이 실행되어, 실제 배포된 사이트에서는 커머스가 항상 비활성 상태로 나오던 문제를 해결한다.

## 구현 내용

- `.github/workflows/deploy.yml`의 빌드 스텝에 `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY` 환경변수 추가
- anon(publishable) key는 클라이언트에 공개되도록 설계된 키이며 실제 데이터 보호는 RLS가 담당하므로, 저장소에 평문으로 있어도 새로운 보안 위험이 없음을 확인하고 채택 (서버 전용 `service_role` 키는 어디에도 사용하지 않음)

## 주요 변경사항

- `.github/workflows/deploy.yml`

## 관련 파일

- `.github/workflows/deploy.yml`

## 완료 조건

- [x] `main` push 후 GitHub Actions 빌드가 성공한다
- [x] 배포된 사이트의 JS 번들에 실제 Supabase 프로젝트 URL이 포함되고 placeholder 값은 제거된다
- [x] `service_role` 키는 어디에도 사용하지 않는다

## 실제 완료 여부

**완료.** GitHub Actions 실행 결과(success)와, 배포된 번들 안에 실제 프로젝트 참조(`ljkfoiiefhszjufxjbep`)가 포함되고 placeholder 문자열은 제거된 것을 직접 확인했다.

---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `1` |
', 'closed', '2026-09-12T16:20:31Z', '2026-09-12T16:20:56Z', 'seune-h0203', null),
(37, 'Done', 2, 16, 'https://github.com/seune-h0203/cones/issues/37', '[DOCS] README 구조 개편 및 멤버 데이터 정합성 수정', '## 작업 목적

README의 목차가 10장으로 늘어나며 가독성이 떨어지고, 팀명 어원 설명이 여러 장에서 반복되며, 멤버 능력 순환 명칭(THINK/BUILD vs LEARN/DESIGN)이 장마다 다르게 쓰이고, 멤버 데이터(팬덤·생일)가 일부만 채워져 있던 문제를 정리한다.

## 구현 내용

- 목차를 10장 → 7장으로 축소 (개요 / 멤버 / 세계관 / 프로젝트 / 기술 / 협업과 기록 / 여담), 옛 UNIT 심화 챕터·GitHub/Daily Snapshot/활동/기록 챕터를 상위 챕터로 통합
- 그룹명 어원(CON + ONES) 설명을 1장에만 두고 다른 장에서는 참조만 하도록 정리
- 능력 순환 명칭을 코드와 일치하는 `LEARN → PREDICT → DESIGN → EXECUTE`로 전 문서 통일, 서사용으로만 쓰이던 THINK/BUILD 명칭 제거
- 신규 커머스 기능을 설명하는 "4.4. OFFICIAL MD" 장 추가
- Tech Stack / 프로젝트 구조 / 배포 설명을 실제 최신 코드(라우팅, Supabase, contexts/lib 폴더 등) 기준으로 갱신 — "react-router-dom 미사용" 등 더 이상 사실이 아닌 서술 수정
- `src/data/artists.ts`: BAESAN·HYUN JIZEL에 팬덤(각각 "에아"/"피터", 같은 유닛 파트너와 동일)을 추가해 네 멤버 모두 팬덤 항목을 갖도록 통일, HAM BOM의 `age: "25"` 임시값을 실제 생일(`2002.09.06`)로 교체, SERINA의 임시 인스타그램 계정 제거

## 주요 변경사항

- `README.md` 전면 개편
- `src/data/artists.ts` 멤버 데이터 수정

## 관련 파일

- `README.md`
- `src/data/artists.ts`

## 완료 조건

- [x] 목차가 7장 구조로 정리된다
- [x] 능력 순환 명칭이 문서 전체에서 하나로 통일된다
- [x] 네 멤버 모두 동일한 항목(생일/팬덤)을 가진다
- [x] `tsc --noEmit`이 통과한다 (데이터 타입 변경 검증)

## 실제 완료 여부

**완료.**

---

| 담당 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `DONE` | `3` |
', 'closed', '2026-09-12T16:20:33Z', '2026-09-12T16:20:58Z', 'seune-h0203', null)) v(issue_number,status_name,status_position,card_position,issue_url,title,body,issue_state,created_at,closed_at,author_login,milestone_title) join public.statuses s on s.project_id=p.project_id and s.status_name=v.status_name left join public.milestones m on m.project_id=p.project_id and m.title=v.milestone_title left join public.users a on a.github_username=v.author_login where p.github_repo_full_name='seune-h0203/cones';
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-24T07:16:51Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='Hamchaelim' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=9 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:06:52Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=13 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:10:16Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='ohoobae' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=39 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:08:03Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=3 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:08:03Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='qkrtpfls03' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=3 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:07:15Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=1 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:07:15Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='qkrtpfls03' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=1 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:07:41Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='ohoobae' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=2 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:07:41Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='qkrtpfls03' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=2 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-24T07:17:05Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='Hamchaelim' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=4 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-24T07:17:05Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='ohoobae' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=4 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:06:54Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='ohoobae' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=5 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:08:28Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=6 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:08:28Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='qkrtpfls03' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=6 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-10T07:43:27Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='Hamchaelim' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=7 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-24T07:16:11Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='Hamchaelim' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=10 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-24T07:16:30Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='Hamchaelim' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=11 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-24T07:16:42Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='Hamchaelim' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=12 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:11:22Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='ohoobae' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=32 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:11:22Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=32 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:07:34Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=33 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:07:34Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='qkrtpfls03' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=33 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-12T16:20:51Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=34 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-14T05:09:04Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=35 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-12T16:20:56Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=36 on conflict do nothing;
insert into public.task_assignees(task_id,user_id,assigned_at) select t.task_id,u.user_id,'2026-09-12T16:20:58Z'::timestamptz from public.tasks t join public.projects p on p.project_id=t.project_id join public.users u on u.github_username='seune-h0203' where p.github_repo_full_name='seune-h0203/cones' and t.github_issue_number=37 on conflict do nothing;
commit;