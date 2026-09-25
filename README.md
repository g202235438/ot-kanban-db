# CONES Kanban DB

CONES GitHub Issues와 GitHub Projects 칸반 보드를 관계형 데이터베이스로
표현하는 Supabase PostgreSQL 설계입니다. CONES 앱의 기존 커머스 테이블
(`products`, `orders` 등)은 수정하지 않습니다.

## 원본

- Repository: <https://github.com/seune-h0203/cones>
- Project: <https://github.com/users/seune-h0203/projects/3>
- 로컬 Issue 원본: [`data/raw/cones-issues.json`](data/raw/cones-issues.json)

참고 저장소의 사용자·작업 데이터를 CONES 데이터와 섞지 않았습니다.
참고 자료는 정규화, 다대다 담당자, Issue state와 Project status 분리 방법만
검토하는 데 사용했습니다.

## 확인된 데이터

| 항목 | 확인값 |
| --- | ---: |
| Repository Issues | 39 |
| Issue state | closed 34 / open 5 |
| Issue assignee 계정 | 4 |
| Assignee 관계 행 | 26 |
| 2명 이상 담당 Issue | 있음 |
| `CONES — FINAL SUBMISSION` Milestone | 31 Issues |
| Milestone 없는 Issue | 8 |

이 값은 공개 GitHub repository API에서 가져온 Issue snapshot 기준입니다.

### View 1 보드 snapshot

첨부된 [`CONES_board_status_view1_2026-09-25.txt`](data/raw/CONES_board_status_view1_2026-09-25.txt)는
2026-09-25에 공개 View 1 화면에서 확인한 목록입니다. GitHub CSV export나
전체 API 응답이 아닙니다.

| Status | status_position | 카드 수 |
| --- | ---: | ---: |
| Todo | 0 | 0 |
| In Progress | 1 | 3 |
| Done | 2 | 16 |

확인된 보드 Task는 Issue `#9, #13, #39`와 `#3, #1, #2, #4, #5, #6, #7,
#10, #11, #12, #32, #33, #34, #35, #36, #37`의 총 19건입니다.
`card_position`은 첨부 목록의 열 내부 표시 순서를 저장합니다.
Project item ID는 확인되지 않아 NULL입니다.

## 확인되지 않은 데이터

현재 허용된 GitHub Project 접근에서는 Project 페이지가
`You can’t perform that action at this time`을 반환했습니다. 따라서 다음은
아직 DB에 추측으로 넣지 않았습니다.

- 실제 Project 카드 19건의 정확한 포함 Issue 번호
- 카드별 Project item ID
- 카드별 Todo / In Progress / Done 상태
- 같은 상태 안에서의 카드 표시 순서

`discrepancy-report.md`에 참고 JSON의 `tasks: []`, orphan assignment,
Project 번호 `1` 대 URL `/projects/3` 차이와 후속 확인 방법을 기록했습니다.

## 스키마

| 테이블 | 역할 |
| --- | --- |
| `projects` | Repository와 Project 식별자 |
| `users` | GitHub 사용자 |
| `statuses` | Project 칸과 표시 순서 |
| `milestones` | GitHub Milestone |
| `tasks` | Issue 원본과 Project 카드 정보 |
| `task_assignees` | Task–User 다대다 관계, 복합 PK |

`tasks.issue_state`는 GitHub Issue의 `open`/`closed`이고,
`tasks.status_id`는 칸반 열입니다. 두 값을 하나의 상태 문자열로 합치지
않았습니다. Project 데이터를 읽지 못한 동안에는 `status_id`와
`github_project_item_id`를 NULL로 보존합니다.

개념 ERD는 [`docs/kanban-erd.md`](docs/kanban-erd.md)에 있습니다.

## 실행 순서

1. Supabase SQL Editor에서 [`schema.sql`](schema.sql)을 실행합니다.
2. [`seed.sql`](seed.sql)을 실행합니다. Issue, 담당자, Milestone snapshot은
   재실행해도 중복되지 않도록 작성했습니다.
3. [`scripts/verify.sql`](scripts/verify.sql)을 실행합니다.
4. Project item export를 확보한 후 카드별 `status_id`,
   `github_project_item_id`, 순서를 추가합니다.
5. [`scripts/reproduce-board.sql`](scripts/reproduce-board.sql)을 실행해
   상태별 카드와 담당자를 조회합니다.

현재 seed는 첨부된 View 1의 19개 카드와 저장소 Issue 메타데이터를
재현합니다. 상태별 검증 결과는 Todo 0건, In Progress 3건, Done 16건,
총 19건입니다. 이 결과는 첨부된 오늘의 화면 관찰과 대조한 것이며,
GitHub Projects CSV export나 전체 API payload를 의미하지 않습니다.

## 실제 적용 상태

- 설계 파일: 작성 완료
- 로컬 원본 분석: 완료
- Supabase 실제 적용: schema와 project/user/status/milestone 기준행 적용 완료
- Supabase Issue/task seed: Project 카드 검증 전이라 미적용
- RLS: 인증 정책을 검증하지 않아 미적용
- Project 카드 Status/순서 대조: 2026-09-25 View 1 첨부 목록 기준 확인
- 실제 Supabase Table Editor / 원본 보드 캡처: 발표용으로 필요

비밀키, service role key, PAT는 저장소와 문서에 넣지 않습니다.
