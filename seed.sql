-- CONES Project View 1 final TSV snapshot supplied on 2026-09-25.
-- The 19 card URLs and Status values come from data/raw/cones-project-view1.tsv; Issue metadata is joined from the raw Issue snapshot.
begin;

insert into public.projects (project_name, github_repo_full_name, github_project_number, github_project_url) values ('CONES','seune-h0203/cones',3,'https://github.com/users/seune-h0203/projects/3') on conflict (github_repo_full_name) do update set project_name=excluded.project_name, github_project_number=excluded.github_project_number, github_project_url=excluded.github_project_url;
insert into public.users (github_username, display_name) values ('Hamchaelim','Hamchaelim'), ('ohoobae','ohoobae'), ('qkrtpfls03','qkrtpfls03'), ('seune-h0203','seune-h0203') on conflict (github_username) do update set display_name=excluded.display_name;
insert into public.statuses (project_id,status_name,position,is_done) select project_id,v.status_name,v.position,v.is_done from public.projects cross join (values ('Todo',0,false),('In Progress',1,false),('Done',2,true)) v(status_name,position,is_done) where github_repo_full_name='seune-h0203/cones' on conflict (project_id,status_name) do update set position=excluded.position,is_done=excluded.is_done;
insert into public.milestones (project_id,github_milestone_number,title,state,due_date) select project_id,1,'CONES ? FINAL SUBMISSION','open',null from public.projects where github_repo_full_name='seune-h0203/cones' on conflict (project_id,github_milestone_number) do update set title=excluded.title,state=excluded.state;

delete from public.task_assignees ta using public.tasks t join public.projects p on p.project_id=t.project_id where ta.task_id=t.task_id and p.github_repo_full_name='seune-h0203/cones';
delete from public.tasks t using public.projects p where p.project_id=t.project_id and p.github_repo_full_name='seune-h0203/cones';
insert into public.tasks (project_id,status_id,milestone_id,author_id,github_issue_number,github_project_item_id,issue_url,title,body,issue_state,created_at,closed_at,status_position,card_position)
select p.project_id,s.status_id,m.milestone_id,a.user_id,v.issue_number,null,v.issue_url,v.title,v.body,v.issue_state,v.created_at::timestamptz,v.closed_at::timestamptz,v.status_position,v.card_position from public.projects p cross join (values
(9, 'In Progress', 1, 1, 'https://github.com/seune-h0203/cones/issues/9', '[QA] Animation 諛?Interaction 理쒖쥌 ?뚯뒪??, '## ?묒뾽 紐⑹쟻

?ㅽ겕濡?湲곕컲 ?곗텧怨??명꽣?숈뀡??紐⑤뱺 ?섍꼍?먯꽌 ?ㅻ쪟 ?놁씠 ?숈옉?섍퀬, 紐⑥뀡 理쒖냼???ㅼ젙??議댁쨷?섎뒗吏 ?뺤씤?쒕떎.


## Task

- [x] Scroll Reveal ?뺤씤
- [x] ConnectionSequence ?뺤씤
- [x] SystemCycle ?뺤씤
- [x] AbilityMotif ?뺤씤
- [x] Page Transition ?뺤씤
- [x] Custom Cursor ?뺤씤
- [x] Video Modal ?뺤씤


## Acceptance Criteria

- [x] Animation ?ㅻ쪟媛 ?녿떎.
- [x] Scroll Interaction???뺤긽?대떎.
- [x] Mobile?먯꽌 臾몄젣媛 諛쒖깮?섏? ?딅뒗??
- [x] Reduced Motion ??묒씠 ?좎??쒕떎.


## Note

`prefers-reduced-motion: reduce` ?섍꼍?먯꽌 `ConnectionSequence`媛 ?ㅽ겕濡??좊땲硫붿씠??????꾩꽦??援щ룄濡??쒖떆?섎뒗吏 ?④퍡 ?뺤씤?쒕떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **SERINA** | `BACKLOG` | `3` |
', 'open', '2026-09-10T05:47:32Z', null, 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(13, 'In Progress', 1, 2, 'https://github.com/seune-h0203/cones/issues/13', '[PRESENTATION] 3遺?諛쒗몴 諛?Demo 以鍮?, '## ?묒뾽 紐⑹쟻

3遺??덉뿉 CONES???멸퀎愿쨌? ?묒뾽 怨쇱젙쨌寃곌낵臾쇱쓣 蹂댁뿬以????덈룄濡?諛쒗몴? Demo ?먮쫫???뺤젙?쒕떎.


## Task

- [x] 1. CONES ?뚭컻
- [x] 2. TWO ORIGINS, ONE SYSTEM
- [x] 3. AI UNIT / COMPUTER UNIT
- [x] 4. 4紐낆쓽 Artist
- [x] 5. CONNECTION : 00
- [ ] 6. GitHub Kanban
- [ ] 7. Landing Page Demo


## Acceptance Criteria

- [ ] 3遺??대궡 諛쒗몴 媛??
- [ ] Demo ?쒖꽌 ?뺤젙
- [ ] GitHub Repository 留곹겕 以鍮?
- [ ] GitHub Project 留곹겕 以鍮?
- [ ] Landing Page 留곹겕 以鍮?


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `BACKLOG` | `3` |
', 'open', '2026-09-10T05:47:36Z', null, 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(39, 'In Progress', 1, 3, 'https://github.com/seune-h0203/cones/issues/39', '[PRESENTATION] 諛쒗몴 ?蹂?以鍮?, null, 'open', '2026-09-14T05:10:00Z', null, 'ohoobae', null),
(3, 'Done', 2, 1, 'https://github.com/seune-h0203/cones/issues/3', '[FE] ?꾩껜 ?섏씠吏 肄섑뀗痢??곌껐 寃??, '## ?묒뾽 紐⑹쟻

紐⑤뱺 ?쇱슦?멸? ?뺤긽 ?곌껐?섍퀬 ?섏씠吏 媛?肄섑뀗痢??붾뱶愿/?좊떅/?꾪떚?ㅽ듃)媛 ?쒕줈 紐⑥닚?섏? ?딅뒗吏 ?뺤씤?쒕떎.


## Task

- [ ] Home ?곌껐 ?뺤씤
- [ ] World ?곌껐 ?뺤씤
- [ ] Artists ?곌껐 ?뺤씤
- [ ] Artist Detail ?곌껐 ?뺤씤
- [ ] Project ?곌껐 ?뺤씤
- [ ] About ?곌껐 ?뺤씤
- [ ] Not Found ?곌껐 ?뺤씤


## Acceptance Criteria

- [ ] 紐⑤뱺 ?섏씠吏媛 ?뺤긽?곸쑝濡??곌껐?쒕떎.
- [ ] Navigation???뺤긽 ?묐룞?쒕떎.
- [ ] 肄섑뀗痢?媛?遺덉씪移섍? ?녿떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `IN PROGRESS` | `3` |
', 'closed', '2026-09-10T05:47:28Z', '2026-09-12T16:23:17Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(1, 'Done', 2, 2, 'https://github.com/seune-h0203/cones/issues/1', '[PLAN] CONES ?꾨줈?앺듃 理쒖쥌 ?묒뾽 愿由?, '## ?묒뾽 紐⑹쟻

CONES 理쒖쥌 ?쒖텧源뚯???紐⑤뱺 ?묒뾽??Kanban?쇰줈 愿由ы븯怨? ??먮퀎 ?묒뾽 諛곕텇怨?吏꾪뻾 ?곹깭瑜??ㅼ젣 ?곹솴怨??쇱튂?쒗궓??


## Task

- [ ] ?꾩껜 ?묒뾽 ?꾪솴 ?뺤씤
- [ ] Kanban ?곹깭 愿由?
- [ ] Milestone 愿由?
- [ ] ????묒뾽 諛곕텇
- [ ] 理쒖쥌 ?쒖텧 ?곹깭 ?뺤씤


## Acceptance Criteria

- [ ] 紐⑤뱺 二쇱슂 ?묒뾽??Kanban???깅줉?섏뼱 ?덈떎.
- [ ] ?대떦?먭? 紐낇솗?섎떎.
- [ ] ?묒뾽 ?곹깭媛 ?ㅼ젣 吏꾪뻾 ?곹솴怨??쇱튂?쒕떎.
- [ ] 理쒖쥌 ?쒖텧 ??紐⑤뱺 ?묒뾽???곹깭瑜??뺤씤?????덈떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HYUN JIZEL** | `IN PROGRESS` | `3` |
', 'closed', '2026-09-10T05:47:26Z', '2026-09-10T06:17:02Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(2, 'Done', 2, 3, 'https://github.com/seune-h0203/cones/issues/2', '[CONTENT] ?꾪떚?ㅽ듃 ?뺣낫 理쒖쥌 寃??, '## ?묒뾽 紐⑹쟻

4紐??꾪떚?ㅽ듃???꾨줈???곗씠?곌? 濡쒖뒪?걔룹긽???섏씠吏쨌OG ?쒓렇 ?꾨컲?먯꽌 ?쇱튂?섎뒗吏 寃?섑븳??


## Task

- [ ] SERINA / BAESAN / HYUN JIZEL / HAM BOM 4紐??뺣낫 寃??
- [ ] Stage Name ?뺤씤
- [ ] Unit ?뺤씤
- [ ] Ability ?뺤씤
- [ ] Position ?뺤씤
- [ ] Image ?뺤씤
- [ ] Artist Detail Route ?뺤씤


## Acceptance Criteria

- [ ] 4紐낆쓽 ?뺣낫媛 ?쇱튂?쒕떎.
- [ ] ?섎せ???대?吏媛 ?녿떎.
- [ ] Artist Detail ?섏씠吏? ?뺣낫媛 ?쇱튂?쒕떎.


## Note

紐⑤뱺 ?꾪떚?ㅽ듃 ?곗씠?곕뒗 `src/data/artists.ts` ?⑥씪 ?뚯뒪?먯꽌 愿由щ맂?? `id`(?? `rina`)??湲곗〈 ?쇱슦???먯뀑 ?명솚???꾪빐 ?좎??섎릺, ?몄텧 ?띿뒪?몃뒗 **SERINA / ?몃━??*濡??쒓린?섎뒗吏 ?뺤씤?쒕떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **SERINA** | `READY` | `2` |
', 'closed', '2026-09-10T05:47:27Z', '2026-09-10T07:19:50Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(4, 'Done', 2, 4, 'https://github.com/seune-h0203/cones/issues/4', '[FE] ?대?吏 諛?Asset 寃쎈줈 理쒖쥌 寃??, '## ?묒뾽 紐⑹쟻

濡쒖뺄 dev ?섍꼍怨?GitHub Pages ?쒕툕?⑥뒪 ?섍꼍 ?묒そ?먯꽌 紐⑤뱺 ?대?吏 ?먯뀑???뺤긽 濡쒕뵫?섎뒗吏 ?뺤씤?쒕떎.


## Task

- [ ] Logo 寃쎈줈 ?뺤씤
- [ ] Artist Image 寃쎈줈 ?뺤씤
- [ ] Director Image 寃쎈줈 ?뺤씤
- [ ] Poster 寃쎈줈 ?뺤씤
- [ ] 湲고? Image Asset 寃쎈줈 ?뺤씤


## Acceptance Criteria

- [ ] Broken Image媛 ?녿떎.
- [ ] GitHub Pages?먯꽌??Asset???뺤긽?곸쑝濡?濡쒕뵫?쒕떎.


## Note

?먯뀑 寃쎈줈??`src/utils/asset.ts`??`asset()`???듯빐 `BASE_URL` 湲곗??쇰줈 ?댁꽍?쒕떎. `vite.config.ts`??`base: "./"` ?ㅼ젙怨??④퍡 ?뺤씤??寃?


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `READY` | `2` |
', 'closed', '2026-09-10T05:47:29Z', '2026-09-12T16:23:02Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(5, 'Done', 2, 5, 'https://github.com/seune-h0203/cones/issues/5', '[FE] Teaser Video Manifest 理쒖쥌 寃??, '## ?묒뾽 紐⑹쟻

`manifest.json`???ㅼ젣濡?議댁옱?섎뒗 ?곸긽 ?뚯씪留?李몄“?섎룄濡??섍퀬, ?녿뒗 寃쎌슦 SIGNAL PENDING ?뺤콉???좎??섎뒗吏 ?뺤씤?쒕떎.


## Task

- [ ] Desktop video ?뺤씤
- [ ] Mobile video ?뺤씤
- [ ] Poster ?뺤씤
- [ ] Video path ?뺤씤
- [ ] ?ㅼ젣 ?뚯씪 議댁옱 ?щ? ?뺤씤


## Acceptance Criteria

- [ ] 議댁옱?섏? ?딅뒗 ?뚯씪??李몄“?섏? ?딅뒗??
- [ ] ?ㅼ젣 ?곸긽???뺤긽?곸쑝濡??곌껐?쒕떎.
- [ ] ?곸긽???녿뒗 寃쎌슦 湲곗〈 SIGNAL PENDING ?뺤콉???좎??쒕떎.


## Note

**?꾩옱 ?곹깭 ?뺤씤 寃곌낵:** `public/videos/manifest.json`??`teasers`?먮뒗 `baesan`留??깅줉?섏뼱 ?덈떎. ?덊럹?댁? `WATCH TEASER` 踰꾪듉??李몄“?섎뒗 `project` ?ㅻ뒗 ?꾩쭅 ?깅줉?섏뼱 ?덉? ?딆븘 ?ъ뒪???대갚?쇰줈 ?숈옉?쒕떎. ?섎룄???곹깭?몄? ?뺤씤 ?꾩슂.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `3` |
', 'closed', '2026-09-10T05:47:29Z', '2026-09-12T16:22:43Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(6, 'Done', 2, 6, 'https://github.com/seune-h0203/cones/issues/6', '[FE] GitHub Pages Routing 理쒖쥌 寃??, '## ?묒뾽 紐⑹쟻

HashRouter 湲곕컲 ?쇱슦?낆씠 GitHub Pages ?뺤쟻 ?몄뒪?낆뿉???덈줈怨좎묠쨌?λ쭅???ы븿 ?뺤긽 ?숈옉?섎뒗吏 ?뺤씤?쒕떎.


## Task

- [ ] `/` ?뺤씤
- [ ] `#/world` ?뺤씤
- [ ] `#/artists` ?뺤씤
- [ ] `#/artists/:artistId` ?뺤씤 (rina 쨌 baesan 쨌 hyun-jizel 쨌 ham-bom)
- [ ] `#/project` ?뺤씤
- [ ] `#/about` ?뺤씤
- [ ] Not Found Route ?뺤씤


## Acceptance Criteria

- [ ] 紐⑤뱺 Route媛 ?뺤긽 ?묐룞?쒕떎.
- [ ] HashRouter 援ъ“媛 ?뺤긽?대떎.
- [ ] GitHub Pages ?섍꼍?먯꽌 ?뺤긽?곸쑝濡??묎렐?쒕떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `3` |
', 'closed', '2026-09-10T05:47:30Z', '2026-09-12T16:22:27Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(7, 'Done', 2, 7, 'https://github.com/seune-h0203/cones/issues/7', '[QA] Desktop 諛섏쓳???뚯뒪??, '## ?묒뾽 紐⑹쟻

?곗뒪?ы넲 ?댁긽???꾨컲?먯꽌 ?덉씠?꾩썐??源⑥?吏 ?딄퀬 ??댄룷洹몃옒?쇨? ?섎룄?濡?蹂댁씠?붿? 寃?섑븳??


## Task

- [ ] Navigation ?뺤씤
- [ ] Hero ?뺤씤
- [ ] Typography ?뺤씤
- [ ] Artist Grid ?뺤씤
- [ ] World ?뺤씤
- [ ] Connection ?뺤씤
- [ ] System Cycle ?뺤씤
- [ ] Video ?뺤씤
- [ ] CTA ?뺤씤
- [ ] Footer ?뺤씤


## Acceptance Criteria

- [ ] Layout??源⑥?吏 ?딅뒗??
- [ ] ?띿뒪?멸? ?섎━吏 ?딅뒗??
- [ ] 媛濡??ㅽ겕濡ㅼ씠 諛쒖깮?섏? ?딅뒗??


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **SERINA** | `READY` | `3` |
', 'closed', '2026-09-10T05:47:31Z', '2026-09-10T06:17:13Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(10, 'Done', 2, 8, 'https://github.com/seune-h0203/cones/issues/10', '[QA] Accessibility 理쒖쥌 寃??, '## ?묒뾽 紐⑹쟻

?ㅻ낫???ъ슜?먯? ?ㅽ겕由곕━???ъ슜?먭? ?ъ씠?몄쓽 二쇱슂 湲곕뒫??臾몄젣?놁씠 ?ъ슜?????덈뒗吏 寃?섑븳??


## Task

- [ ] alt text ?뺤씤
- [ ] semantic HTML ?뺤씤
- [ ] keyboard navigation ?뺤씤
- [ ] focus-visible ?뺤씤
- [ ] skip link ?뺤씤
- [ ] modal focus trap ?뺤씤
- [ ] Escape ?숈옉 ?뺤씤
- [ ] reduced motion ?뺤씤


## Acceptance Criteria

- [ ] 二쇱슂 湲곕뒫???ㅻ낫?쒕줈 ?ъ슜?????덈떎.
- [ ] ?대?吏???곸젅??alt媛 ?덈떎.
- [ ] Modal???뺤긽?곸쑝濡??ロ엺??
- [ ] ?묎렐??愿??移섎챸?곸씤 臾몄젣媛 ?녿떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **BAESAN** | `BACKLOG` | `3` |
', 'closed', '2026-09-10T05:47:33Z', '2026-09-12T16:22:08Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(11, 'Done', 2, 9, 'https://github.com/seune-h0203/cones/issues/11', '[QA] Production Build ?뚯뒪??, '## ?묒뾽 紐⑹쟻

諛고룷 ?꾩뿉 ?꾨줈?뺤뀡 鍮뚮뱶媛 ????ㅻ쪟 ?놁씠 ?듦낵?섎뒗吏 ?뺤씤?쒕떎.


## Task

- [ ] `npm run build` ?ㅽ뻾
- [ ] ?꾩슂 ??`npm run dev` / `npm run preview` ?뺤씤
- [ ] TypeScript Error ?뺤씤
- [ ] Build Error ?뺤씤
- [ ] Import Error ?뺤씤
- [ ] Asset Error ?뺤씤


## Acceptance Criteria

- [ ] `npm run build`媛 ?깃났?쒕떎.
- [ ] 移섎챸?곸씤 ?ㅻ쪟媛 ?녿떎.


## Note

`npm run build`??`tsc --noEmit` ??Vite ?꾨줈?뺤뀡 鍮뚮뱶瑜??섑뻾?쒕떎.


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `2` |
', 'closed', '2026-09-10T05:47:34Z', '2026-09-12T16:21:37Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(12, 'Done', 2, 10, 'https://github.com/seune-h0203/cones/issues/12', '[DEPLOY] GitHub Pages 理쒖쥌 諛고룷 ?뺤씤', '## ?묒뾽 紐⑹쟻

GitHub Pages???ㅼ젣 諛고룷???꾨줈?뺤뀡 ?ъ씠?멸? ?뺤긽 ?숈옉?섎뒗吏 理쒖쥌 ?뺤씤?쒕떎.


## Task

- [ ] GitHub Pages ?묒냽 ?뺤씤
- [ ] Home ?뺤씤
- [ ] World ?뺤씤
- [ ] Artists ?뺤씤
- [ ] Artist Detail ?뺤씤
- [ ] Project ?뺤씤
- [ ] About ?뺤씤
- [ ] Images ?뺤씤
- [ ] Videos ?뺤씤
- [ ] Navigation ?뺤씤


## Acceptance Criteria

- [ ] Production ?ъ씠?멸? ?뺤긽?곸쑝濡??대┛??
- [ ] 二쇱슂 ?섏씠吏媛 ?뺤긽?곸쑝濡??묐룞?쒕떎.


## Note

**?좏뻾 議곌굔:** ??μ냼 `Settings ??Pages ??Source ??GitHub Actions` ?ㅼ젙???꾩슂?섎떎. ??μ냼媛 諛⑷툑 ?앹꽦?섏뿀?쇰?濡??꾩쭅 Pages 諛고룷媛 ??踰덈룄 ?ㅽ뻾?????녿떎. ???URL: https://seune-h0203.github.io/cones/


---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `BACKLOG` | `2` |
', 'closed', '2026-09-10T05:47:35Z', '2026-09-12T16:21:22Z', 'seune-h0203', 'CONES ??FINAL SUBMISSION'),
(32, 'Done', 2, 11, 'https://github.com/seune-h0203/cones/issues/32', '[BE] Supabase 而ㅻ㉧??諛깆뿏???ㅽ궎留댟톀LS쨌RPC) 援ъ텞', '## ?묒뾽 紐⑹쟻

MD Collection ?대?吏瑜??섎굹???곹뭹?쇰줈 萸됰슧洹몃━吏 ?딄퀬, 4紐?횞 8醫?= 32媛쒖쓽 ?ㅼ젣 ?곹뭹???ㅼ젣 ?곗씠?곕쿋?댁뒪濡?愿由ы븯硫?二쇰Ц ?앹꽦 ???쒕쾭 痢≪뿉??媛寃??ш퀬瑜??ш퀎?고븯??諛깆뿏?쒕? 援ъ텞?쒕떎.

## 援ы쁽 ?댁슜

- Supabase(Postgres + Auth + PostgREST) ?꾨줈?앺듃 ?곕룞
- `products` / `carts` / `cart_items` / `orders` / `order_items` 5媛??뚯씠釉?+ ?몃뜳???뺤쓽
- ???뚯씠釉?Row Level Security ?곸슜 ???ъ슜?먮뒗 ?먯떊???λ컮援щ땲/二쇰Ц留??쎄퀬 ?????덉쓬
- `create_order()` SECURITY DEFINER RPC: ?λ컮援щ땲 ?댁슜???쒕쾭?먯꽌 ?ш?利??ш퀬 `FOR UPDATE` ?좉툑, 媛寃??ш퀎?? 諛곗넚鍮?怨꾩궛)????orders/order_items ?앹꽦, ?ш퀬 李④컧, ?덉젅 泥섎━, ?λ컮援щ땲 鍮꾩슦湲?
- `mock_pay_order()` RPC: `PENDING ??PAID` 紐⑹뾽 寃곗젣 ?꾪솚 (??PG ?곕룞 ???쒖뿰??
- 32媛??곹뭹 ?쒕뱶 ?곗씠??(`ON CONFLICT DO UPDATE`濡??ъ떎???덉쟾)

## 二쇱슂 蹂寃쎌궗??

- `supabase/schema.sql` ?좉퇋 (?뚯씠釉? RLS, RPC, ?쒕뱶)
- `src/lib/supabase.ts` ?좉퇋 (Supabase ?대씪?댁뼵?? `isCommerceConfigured` ?뚮옒洹?
- `src/lib/database.types.ts` ?좉퇋 (?뚯씠釉?????뺤쓽)
- `.env.example`, `.gitignore`(.env ?쒖쇅) 異붽?

## 愿???뚯씪

- `supabase/schema.sql`
- `src/lib/supabase.ts`
- `src/lib/database.types.ts`
- `.env.example`

## ?꾨즺 議곌굔

- [x] 5媛??뚯씠釉붽낵 RLS ?뺤콉???ㅼ젣 Supabase ?꾨줈?앺듃??諛고룷?쒕떎
- [x] `create_order()`媛 ?대씪?댁뼵?멸? 蹂대궦 珥앹븸???꾨땲???쒕쾭?먯꽌 ?ш퀎?고븳 湲덉븸?쇰줈 二쇰Ц???앹꽦?쒕떎
- [x] ?ш퀬媛 0???섎㈃ ?먮룞?쇰줈 SOLD_OUT 泥섎━?쒕떎
- [x] ?ㅻⅨ ?ъ슜?먯쓽 ?λ컮援щ땲/二쇰Ц??議고쉶쨌?섏젙?????녿떎 (RLS)

## ?ㅼ젣 ?꾨즺 ?щ?

**?꾨즺.** REST API濡??ㅼ젣 ?뚯썝媛?????λ컮援щ땲 ?닿린 ??`create_order()` ?몄텧 ??orders/order_items ?앹꽦 ???ш퀬 李④컧(37??5 ?? ?뺤씤 ???ㅻⅨ 怨꾩젙?쇰줈 ?묎렐 李⑤떒源뚯? ??援ш컙??吏곸젒 ?몄텧??寃利앺뻽?? 寃利??꾩쨷 `create_order()`??`where order_id = v_order_id` 援щЦ???⑥닔??OUT ?뚮씪誘명꽣紐낃낵 異⑸룎??"ambiguous column" ?ㅻ쪟媛 諛쒖깮?섎뒗 踰꾧렇瑜?諛쒓껄??`oi.order_id`濡??섏젙, ?щ같?????ш?利앷퉴吏 ?꾨즺?덈떎.

---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `5` |
', 'closed', '2026-09-12T16:20:20Z', '2026-09-12T16:20:46Z', 'seune-h0203', null),
(33, 'Done', 2, 12, 'https://github.com/seune-h0203/cones/issues/33', '[FE] Shop/Cart/Checkout/Order 而ㅻ㉧???꾨줎?몄뿏??援ы쁽', '## ?묒뾽 紐⑹쟻

?쒕뵫?섏씠吏 MD 諛곕꼫?먯꽌 ?댁뼱吏???ㅼ젣 而ㅻ㉧??UI(Shop ??Product Detail ??Cart ??Checkout ??Order Complete ??My Orders)? ?뚯썝媛??濡쒓렇???붾㈃??援ы쁽?쒕떎.

## 援ы쁽 ?댁슜

- `react-router-dom`??`BrowserRouter`瑜??щ룄?낇빐 One Page Landing(`Home`)怨?而ㅻ㉧???쇱슦?몃? ?④퍡 ?뚮뜑留?
- Shop(?꾪떚?ㅽ듃 ?꾪꽣, 32媛??곹뭹 洹몃━??, Product Detail, Cart(?섎웾 蹂寃???젣, ?뚭퀎), Checkout(二쇰Ц ?앹꽦), Order Complete(二쇰Ц ?붿빟), My Orders(二쇰Ц 紐⑸줉 + mock 寃곗젣 踰꾪듉) ?섏씠吏
- `AuthContext`(Supabase ?몄뀡/?뚯썝媛??濡쒓렇??濡쒓렇?꾩썐), `CartContext`(?λ컮援щ땲 ?곹깭, ?숆????낅뜲?댄듃, `ensureCartId`) ?좉퇋
- Navbar??CART(?섎웾 諛곗?) / LOGIN / MY ORDERS 留곹겕 異붽?, ?꾪떚?ㅽ듃 ?꾨줈??紐⑤떖??"OFFICIAL MD" 踰꾪듉???ㅼ젣 `/shop?artist=` ?λ쭅?щ줈 ?곌껐
- 濡쒓렇?명븯吏 ?딆? ?ъ슜?먭? `/cart`, `/checkout`, `/mypage/orders` ?묎렐 ??`/login`?쇰줈 由щ떎?대젆??

## 二쇱슂 蹂寃쎌궗??

- `src/App.tsx` ??BrowserRouter/Routes 異붽? (?쒕뵫?섏씠吏 ?덉뼱濡??ㅽ겕濡?援ъ“??蹂寃??놁쓬)
- `src/pages/shop/*`, `src/pages/auth/*` ?좉퇋
- `src/contexts/AuthContext.tsx`, `src/contexts/CartContext.tsx` ?좉퇋
- `src/components/Navbar.tsx`, `src/components/ArtistProfileModal.tsx`, `src/pages/Home.tsx` 而ㅻ㉧???λ쭅???곕룞
- `public/404.html` ?좉퇋 ??GitHub Pages SPA ?쇱슦??由щ떎?대젆??

## 愿???뚯씪

- `src/App.tsx`
- `src/pages/shop/Shop.tsx`, `ProductDetail.tsx`, `Cart.tsx`, `Checkout.tsx`, `OrderComplete.tsx`, `MyOrders.tsx`
- `src/pages/auth/Login.tsx`, `Signup.tsx`
- `src/contexts/AuthContext.tsx`, `src/contexts/CartContext.tsx`
- `src/components/Navbar.tsx`, `src/components/ArtistProfileModal.tsx`, `src/pages/Home.tsx`
- `public/404.html`

## ?꾨즺 議곌굔

- [x] Shop ??Product Detail ??Cart ??Checkout ??Order Complete ??My Orders ?꾩껜 ?먮쫫???ㅼ젣 濡쒓렇???몄뀡怨?DB濡??숈옉?쒕떎
- [x] ?쒕뵫?섏씠吏 泥??붾㈃(?덉뼱濡?? ???묒뾽 怨쇱젙?먯꽌 ?섏젙?섏? ?딆븯??
- [x] 濡쒓렇?명븯吏 ?딆? ?ъ슜?먮뒗 ?λ컮援щ땲/二쇰Ц ?섏씠吏?먯꽌 濡쒓렇???붾㈃?쇰줈 由щ떎?대젆?몃맂??
- [x] `npm run build`(`tsc --noEmit` + `vite build`)媛 ?듦낵?쒕떎

## ?ㅼ젣 ?꾨즺 ?щ?

**?꾨즺.** ?ㅼ젣 Supabase ?꾨줈?앺듃???곌껐???뚯썝媛????濡쒓렇?????곹뭹 議고쉶 ???λ컮援щ땲 ?닿린 ??寃곗젣 ??二쇰Ц ?꾨즺 ??My Orders 議고쉶源뚯?, ?꾨줎?몄뿏?쒓? ?몄텧?섎뒗 寃껉낵 ?숈씪???붿껌??REST API ?덈꺼濡?吏곸젒 ?ㅽ뻾??寃利앺뻽??(???묒뾽 ?섍꼍??釉뚮씪?곗? ?먮룞???꾧뎄媛 ?놁뼱 UI ?ㅽ겕由곗꺑 ???API/鍮뚮뱶 ?덈꺼濡?寃利?.

---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `5` |
', 'closed', '2026-09-12T16:20:23Z', '2026-09-12T16:20:49Z', 'seune-h0203', null),
(34, 'Done', 2, 13, 'https://github.com/seune-h0203/cones/issues/34', '[DB] order_items ?대?吏 而щ읆 異붽? 諛?二쇰Ц ?곗씠??留덉씠洹몃젅?댁뀡', '## ?묒뾽 紐⑹쟻

二쇰Ц ?곸꽭 / My Orders ?붾㈃?먯꽌 ?ㅼ젣 援щℓ?덈뜕 ?곹뭹 ?ъ쭊??蹂댁뿬以????덈룄濡? 二쇰Ц ?쒖젏???곹뭹 ?대?吏瑜?二쇰Ц ?곗씠?곗뿉 蹂꾨룄濡???ν븳??

## 援ы쁽 ?댁슜

- `order_items` ?뚯씠釉붿뿉 `image` 而щ읆 異붽? (`ALTER TABLE ... ADD COLUMN IF NOT EXISTS`濡?湲곗〈 諛고룷 ?섍꼍?먮룄 ?덉쟾?섍쾶 ?곸슜)
- `create_order()` RPC媛 二쇰Ц ?앹꽦 ???곹뭹??`image`瑜?`order_items`???④퍡 蹂듭궗?섎룄濡?媛깆떊 ??`product_name`怨?媛숈? ?댁쑀濡? ?댄썑 ?곹뭹????젣쨌蹂寃쎈뤌??怨쇨굅 二쇰Ц ?붾㈃? 洹몃?濡??좎???
- `MyOrders.tsx`?먯꽌 PostgREST embedded resource(`orders?select=*,order_items(id,product_name,image)`)濡?二쇰Ц蹂??몃꽕??議고쉶, `OrderComplete.tsx`?먯꽌 ?쇱씤 ?꾩씠?쒕퀎 ?대?吏 ?뚮뜑留?

## 二쇱슂 蹂寃쎌궗??

- `supabase/schema.sql` ??`order_items.image` 而щ읆 諛?`create_order()` INSERT 援щЦ 媛깆떊
- `src/lib/database.types.ts` ??`OrderItemRow.image` ?꾨뱶 異붽?
- `src/pages/shop/OrderComplete.tsx`, `MyOrders.tsx`, `shop.module.css` ???몃꽕???뚮뜑留?

## 愿???뚯씪

- `supabase/schema.sql`
- `src/lib/database.types.ts`
- `src/pages/shop/OrderComplete.tsx`
- `src/pages/shop/MyOrders.tsx`
- `src/pages/shop/shop.module.css`

## ?꾨즺 議곌굔

- [x] ?덈줈 ?앹꽦?섎뒗 二쇰Ц??`order_items.image`媛 ?ㅼ젣濡?梨꾩썙吏꾨떎
- [x] My Orders 紐⑸줉怨?二쇰Ц ?곸꽭 ?섏씠吏???곹뭹 ?대?吏媛 ?쒖떆?쒕떎
- [x] 留덉씠洹몃젅?댁뀡 ?댁쟾???앹꽦??二쇰Ц? ?먮윭 ?놁씠 鍮??먮━濡??쒖떆?쒕떎 (?섏쐞 ?명솚)

## ?ㅼ젣 ?꾨즺 ?щ?

**?꾨즺.** ?ㅼ젣 Supabase ?꾨줈?앺듃??`ALTER TABLE`怨?媛깆떊??RPC瑜?諛고룷???? ?좉퇋 二쇰Ц(SERINA KEYRING) ?앹꽦 ??`order_items.image`??`images/md/products/rina-keyring.jpg`媛 ?뺤긽?곸쑝濡?梨꾩썙吏??寃껉낵 embedded 荑쇰━ 寃곌낵源뚯? REST API濡?吏곸젒 ?뺤씤?덈떎.

---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `2` |
', 'closed', '2026-09-12T16:20:25Z', '2026-09-12T16:20:51Z', 'seune-h0203', null),
(35, 'Done', 2, 14, 'https://github.com/seune-h0203/cones/issues/35', '[FIX] ?쇱슦???쒕툕?⑥뒪 諛??대?吏 寃쎈줈 踰꾧렇 ?섏젙', '## ?묒뾽 紐⑹쟻

GitHub Pages ?쒕툕?⑥뒪(`/cones/`) 諛고룷 ?섍꼍?먯꽌 諛쒓껄????媛吏 ?ㅼ궗??踰꾧렇 ???ㅻ퉬寃뚯씠?섏씠 ?꾨찓??猷⑦듃濡??댄깉?섎뒗 臾몄젣? ?곹뭹 ?곸꽭 ?섏씠吏 ?ъ쭊??源⑥???臾몄젣 ??瑜??섏젙?쒕떎.

## 援ы쁽 ?댁슜

- **Navbar ?쒕툕?⑥뒪 ?댄깉**: `Navbar.tsx`???뱀뀡 留곹겕媛 `href={"/" + item.path}`濡??꾨찓??猷⑦듃 湲곗? ?덈?寃쎈줈瑜??섎뱶肄붾뵫?섍퀬 ?덉뼱, `/cones/` ?섏쐞??諛고룷???ъ씠?몄뿉??ORIGINS/ARTISTS ?깆쓣 ?꾨Ⅴ硫?`/cones/`媛 鍮좎쭊 `https://seune-h0203.github.io/#artists`濡??대룞?섎뜕 踰꾧렇瑜??섏젙. `BrowserRouter`??`basename`怨??숈씪???고???媛먯?媛?`window.__CONES_BASE__`)???ъ슜?섎룄濡?蹂寃?
- **?곹뭹 ?대?吏 源⑥쭚**: `utils/asset.ts`媛 Vite 鍮뚮뱶????곷? 寃쎈줈(`import.meta.env.BASE_URL`, 媛믪? `"./"`)瑜?洹몃?濡??⑥꽌, `/shop/product/:slug`泥섎읆 ?쇱슦?멸? 3?④퀎 源딆뼱吏硫?釉뚮씪?곗????곷?寃쎈줈 ?댁꽍 洹쒖튃??諛고룷 猷⑦듃媛 ?꾨땲???곸쐞 寃쎈줈 ???④퀎留?踰쀪꺼吏??섎せ??URL??留뚮뱾?댁졇 ?대?吏媛 404 ?섎뜕 踰꾧렇瑜??섏젙. ?숈씪?섍쾶 `window.__CONES_BASE__` 湲곗? ?덈?寃쎈줈濡?蹂寃?
- **MD ?곹뭹 ?대?吏 ?붿쭏**: ?먮낯 MD ?ъ뒪??1536횞1024)?먯꽌 ?곹뭹 ?섎굹媛 李⑥??섎뒗 ?곸뿭????250~290px濡??묒븘, Shop 4??怨좎젙 洹몃━??移대뱶??~300~390px)? Product Detail 480px 而щ읆???대? 理쒕? ~2諛곕줈 ?뺣? ?쒖떆???먮┸?섍쾶 蹂댁씠??臾몄젣瑜? 洹몃━??而щ읆??`auto-fill, minmax(240px, 1fr)`濡??곹뭹 ?먮낯 ?댁긽?꾩뿉 媛源앷쾶, Detail 而щ읆??320px濡?以꾩뿬 ?꾪솕.

## 二쇱슂 蹂寃쎌궗??

- `src/components/Navbar.tsx`
- `src/utils/asset.ts`
- `src/pages/shop/shop.module.css`

## 愿???뚯씪

- `src/components/Navbar.tsx`
- `src/utils/asset.ts`
- `src/pages/shop/shop.module.css`

## ?꾨즺 議곌굔

- [x] `https://seune-h0203.github.io/cones/`?먯꽌 ?ㅻ퉬寃뚯씠?섏씠 `/cones/` ?섏쐞?먯꽌留??대룞?쒕떎
- [x] `/shop/product/:slug` ?섏씠吏???곹뭹 ?ъ쭊???뺤긽 濡쒕뱶?쒕떎
- [x] Shop / Detail ?대?吏 ?뺣? 諛곗쑉???꾪솕?쒕떎

## ?ㅼ젣 ?꾨즺 ?щ?

**?꾨즺.** ??諛고룷 ?ъ씠??`https://seune-h0203.github.io/cones/`)??媛??섏젙???쒖꽌?濡?諛고룷???? `curl`濡??대?吏 URL 200 ?묐떟怨?GitHub Actions 鍮뚮뱶 ?깃났??吏곸젒 ?뺤씤?덈떎.

---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `3` |
', 'closed', '2026-09-12T16:20:28Z', '2026-09-12T16:20:54Z', 'seune-h0203', null),
(36, 'Done', 2, 15, 'https://github.com/seune-h0203/cones/issues/36', '[DEVOPS] GitHub Actions 諛고룷 ?뚰겕?뚮줈 Supabase ?섍꼍蹂???곕룞', '## ?묒뾽 紐⑹쟻

GitHub Pages 諛고룷 鍮뚮뱶媛 Supabase ?묒냽 ?뺣낫 ?놁씠 ?ㅽ뻾?섏뼱, ?ㅼ젣 諛고룷???ъ씠?몄뿉?쒕뒗 而ㅻ㉧?ㅺ? ??긽 鍮꾪솢???곹깭濡??섏삤??臾몄젣瑜??닿껐?쒕떎.

## 援ы쁽 ?댁슜

- `.github/workflows/deploy.yml`??鍮뚮뱶 ?ㅽ뀦??`VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY` ?섍꼍蹂??異붽?
- anon(publishable) key???대씪?댁뼵?몄뿉 怨듦컻?섎룄濡??ㅺ퀎???ㅼ씠硫??ㅼ젣 ?곗씠??蹂댄샇??RLS媛 ?대떦?섎?濡? ??μ냼???됰Ц?쇰줈 ?덉뼱???덈줈??蹂댁븞 ?꾪뿕???놁쓬???뺤씤?섍퀬 梨꾪깮 (?쒕쾭 ?꾩슜 `service_role` ?ㅻ뒗 ?대뵒?먮룄 ?ъ슜?섏? ?딆쓬)

## 二쇱슂 蹂寃쎌궗??

- `.github/workflows/deploy.yml`

## 愿???뚯씪

- `.github/workflows/deploy.yml`

## ?꾨즺 議곌굔

- [x] `main` push ??GitHub Actions 鍮뚮뱶媛 ?깃났?쒕떎
- [x] 諛고룷???ъ씠?몄쓽 JS 踰덈뱾???ㅼ젣 Supabase ?꾨줈?앺듃 URL???ы븿?섍퀬 placeholder 媛믪? ?쒓굅?쒕떎
- [x] `service_role` ?ㅻ뒗 ?대뵒?먮룄 ?ъ슜?섏? ?딅뒗??

## ?ㅼ젣 ?꾨즺 ?щ?

**?꾨즺.** GitHub Actions ?ㅽ뻾 寃곌낵(success)?, 諛고룷??踰덈뱾 ?덉뿉 ?ㅼ젣 ?꾨줈?앺듃 李몄“(`ljkfoiiefhszjufxjbep`)媛 ?ы븿?섍퀬 placeholder 臾몄옄?댁? ?쒓굅??寃껋쓣 吏곸젒 ?뺤씤?덈떎.

---

| ?대떦 | Kanban Status | Story Point |
|---|---|---|
| **HAM BOM** | `DONE` | `1` |
', 'closed', '2026-09-12T16:20:31Z', '2026-09-12T16:20:56Z', 'seune-h0203', null),
(37, 'Done', 2, 16, 'https://github.com/seune-h0203/cones/issues/37', '[DOCS] README 援ъ“ 媛쒗렪 諛?硫ㅻ쾭 ?곗씠???뺥빀???섏젙', '## ?묒뾽 紐⑹쟻

README??紐⑹감媛 10?μ쑝濡??섏뼱?섎ŉ 媛?낆꽦???⑥뼱吏怨? ?紐??댁썝 ?ㅻ챸???щ윭 ?μ뿉??諛섎났?섎ŉ, 硫ㅻ쾭 ?λ젰 ?쒗솚 紐낆묶(THINK/BUILD vs LEARN/DESIGN)???λ쭏???ㅻⅤ寃??곗씠怨? 硫ㅻ쾭 ?곗씠???щ뜡쨌?앹씪)媛 ?쇰?留?梨꾩썙???덈뜕 臾몄젣瑜??뺣━?쒕떎.

## 援ы쁽 ?댁슜

- 紐⑹감瑜?10????7?μ쑝濡?異뺤냼 (媛쒖슂 / 硫ㅻ쾭 / ?멸퀎愿 / ?꾨줈?앺듃 / 湲곗닠 / ?묒뾽怨?湲곕줉 / ?щ떞), ??UNIT ?ы솕 梨뺥꽣쨌GitHub/Daily Snapshot/?쒕룞/湲곕줉 梨뺥꽣瑜??곸쐞 梨뺥꽣濡??듯빀
- 洹몃９紐??댁썝(CON + ONES) ?ㅻ챸??1?μ뿉留??먭퀬 ?ㅻⅨ ?μ뿉?쒕뒗 李몄“留??섎룄濡??뺣━
- ?λ젰 ?쒗솚 紐낆묶??肄붾뱶? ?쇱튂?섎뒗 `LEARN ??PREDICT ??DESIGN ??EXECUTE`濡???臾몄꽌 ?듭씪, ?쒖궗?⑹쑝濡쒕쭔 ?곗씠??THINK/BUILD 紐낆묶 ?쒓굅
- ?좉퇋 而ㅻ㉧??湲곕뒫???ㅻ챸?섎뒗 "4.4. OFFICIAL MD" ??異붽?
- Tech Stack / ?꾨줈?앺듃 援ъ“ / 諛고룷 ?ㅻ챸???ㅼ젣 理쒖떊 肄붾뱶(?쇱슦?? Supabase, contexts/lib ?대뜑 ?? 湲곗??쇰줈 媛깆떊 ??"react-router-dom 誘몄궗?? ?????댁긽 ?ъ떎???꾨땶 ?쒖닠 ?섏젙
- `src/data/artists.ts`: BAESAN쨌HYUN JIZEL???щ뜡(媛곴컖 "?먯븘"/"?쇳꽣", 媛숈? ?좊떅 ?뚰듃?덉? ?숈씪)??異붽?????硫ㅻ쾭 紐⑤몢 ?щ뜡 ??ぉ??媛뽯룄濡??듭씪, HAM BOM??`age: "25"` ?꾩떆媛믪쓣 ?ㅼ젣 ?앹씪(`2002.09.06`)濡?援먯껜, SERINA???꾩떆 ?몄뒪?洹몃옩 怨꾩젙 ?쒓굅

## 二쇱슂 蹂寃쎌궗??

- `README.md` ?꾨㈃ 媛쒗렪
- `src/data/artists.ts` 硫ㅻ쾭 ?곗씠???섏젙

## 愿???뚯씪

- `README.md`
- `src/data/artists.ts`

## ?꾨즺 議곌굔

- [x] 紐⑹감媛 7??援ъ“濡??뺣━?쒕떎
- [x] ?λ젰 ?쒗솚 紐낆묶??臾몄꽌 ?꾩껜?먯꽌 ?섎굹濡??듭씪?쒕떎
- [x] ??硫ㅻ쾭 紐⑤몢 ?숈씪????ぉ(?앹씪/?щ뜡)??媛吏꾨떎
- [x] `tsc --noEmit`???듦낵?쒕떎 (?곗씠?????蹂寃?寃利?

## ?ㅼ젣 ?꾨즺 ?щ?

**?꾨즺.**

---

| ?대떦 | Kanban Status | Story Point |
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
