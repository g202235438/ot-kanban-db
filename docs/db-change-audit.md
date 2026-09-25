# DB 변경 확인 결과

## 확인 기준

- Supabase project: `ismhrkrkbvlbsxmwhvzb`
- 기준 보드: CONES Project View 1
- 기준 카드: 19개
- Repository Issue snapshot: 39개

## 변경 전 확인

팀원 앱이 사용하던 테이블은 `projects`, `statuses`, `users`, `milestones`,
`tasks`, `task_assignees` 6개였습니다. 기존 데이터는 각각 1, 3, 4, 1, 19,
26행이었고, RLS는 6개 테이블 모두 비활성화되어 있었습니다.

`tasks`에는 Issue 제목, URL, Issue state, 현재 Project status와 담당자
연결만 있었으며 Issue 본문·댓글·Timeline·Status 변경 이력은 없었습니다.

## 현재 확인 결과

| 테이블 | 행 수 | 용도 |
| --- | ---: | --- |
| `projects` | 1 | CONES Project |
| `statuses` | 3 | Todo / In Progress / Done |
| `users` | 4 | 담당자 계정 |
| `milestones` | 1 | CONES — FINAL SUBMISSION |
| `tasks` | 19 | View 1 카드만 포함 |
| `task_assignees` | 26 | 담당자 연결 |
| `issue_details` | 19 | Issue 본문 및 원본 메타데이터 |
| `issue_comments` | 15 | GitHub API에서 확인된 댓글 |
| `issue_timeline_events` | 0 | 구조만 준비; 원본 이벤트는 raw 파일 보존 |
| `project_status_history` | 0 | 전·후 Status 값 미확인; 구조만 준비 |

RLS는 모든 public 테이블에서 활성화했고 `anon`과 `authenticated`에는
`SELECT` 정책만 남겼습니다. 브라우저의 publishable/anon 클라이언트에서
INSERT, UPDATE, DELETE 정책은 존재하지 않습니다.

## 원본 대조와 미확인 범위

19개 카드의 Issue 본문은 모두 수집했으며, 댓글은 15건을 확인해 적재했습니다.
Issue Timeline API 응답은 179건, 그중 `project_v2_item_status_changed`는
40건이었지만, 확인 가능한 응답에 카드별 연결 정보와 변경 전·후 Status 값이
일관되게 포함되지 않았습니다. 따라서 해당 이벤트를 카드별 이력으로 추정해
넣지 않고 [`data/raw/cones-view1-events.json`](../data/raw/cones-view1-events.json)에
원본만 보존했습니다.

## 로컬 앱 확인

팀원 저장소 [asps-3](C:/Users/user/AppData/Roaming/Code/User/asps-3)는
`python -m http.server 4173`로 실행했고, live Supabase에서
`19 items · 3 active · 16 done`을 확인했습니다. 카드 상세 화면에서 Issue
본문과 댓글도 조회되는 것을 확인했습니다. RLS에 맞춰 카드 이동 PATCH는
읽기 전용 안내로 변경했습니다.
