# Kanban DB Schema Specification

## `kanban_team`

| Column | Type | Constraint |
| --- | --- | --- |
| `team_id` | UUID | PK, default `gen_random_uuid()` |
| `team_name` | TEXT | NOT NULL, UNIQUE |
| `repository_url` | TEXT | NOT NULL |
| `created_at` | TIMESTAMPTZ | NOT NULL |

## `kanban_member`

팀원은 여러 카드를 맡을 수 있으므로 카드와 직접 반복 저장하지 않습니다.

| Column | Type | Constraint |
| --- | --- | --- |
| `member_id` | UUID | PK |
| `team_id` | UUID | FK → `kanban_team`, CASCADE |
| `member_name` | TEXT | NOT NULL |
| `github_username` | TEXT | Nullable |
| `department` | TEXT | Nullable |
| `student_number` | TEXT | Nullable |

`UNIQUE(team_id, member_name)`으로 팀 내 이름 중복을 방지합니다.

## `kanban_board`

| Column | Type | Constraint |
| --- | --- | --- |
| `board_id` | UUID | PK |
| `team_id` | UUID | FK → `kanban_team`, CASCADE |
| `board_name` | TEXT | NOT NULL |
| `github_project_url` | TEXT | NOT NULL, UNIQUE |

## `kanban_column`

`position`은 보드에서 왼쪽부터 표시되는 순서입니다.

| Column | Type | Constraint |
| --- | --- | --- |
| `column_id` | UUID | PK |
| `board_id` | UUID | FK → `kanban_board`, CASCADE |
| `column_name` | TEXT | NOT NULL |
| `position` | INTEGER | NOT NULL, `>= 0` |

`UNIQUE(board_id, column_name)`, `UNIQUE(board_id, position)`을 적용합니다.

## `kanban_card`

| Column | Type | Constraint |
| --- | --- | --- |
| `card_id` | UUID | PK |
| `board_id` | UUID | FK → `kanban_board`, CASCADE |
| `column_id` | UUID | FK → `kanban_column`, RESTRICT |
| `title` | TEXT | NOT NULL |
| `issue_url` | TEXT | NOT NULL, UNIQUE |
| `github_issue_number` | INTEGER | Nullable, unique per board |
| `issue_state` | TEXT | NOT NULL, `open` or `closed` |
| `description` | TEXT | Nullable |
| `linked_pull_requests` | TEXT[] | Nullable |
| `sub_issues_completed` | INTEGER | Nullable, `>= 0` |
| `sub_issues_total` | INTEGER | Nullable, `>= 0` |
| `priority` | TEXT | Nullable |
| `estimate` | NUMERIC(10,2) | `>= 0` |
| `size` | TEXT | Nullable |
| `position` | INTEGER | NOT NULL, `>= 0` |
| `created_at` | TIMESTAMPTZ | NOT NULL |
| `closed_at` | TIMESTAMPTZ | Nullable, not before `created_at` |

보드의 컬럼은 작업 화면상의 위치이고 `issue_state`는 GitHub Issue의 열림/닫힘 상태입니다. 두 값을 분리해 저장합니다.

## `kanban_card_assignee`

카드와 담당자의 N:M 관계를 표현하는 연결 테이블입니다.

| Column | Type | Constraint |
| --- | --- | --- |
| `card_id` | UUID | PK, FK → `kanban_card`, CASCADE |
| `member_id` | UUID | PK, FK → `kanban_member`, CASCADE |
