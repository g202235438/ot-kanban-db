# Kanban DB Schema Specification

## 설계 방향

GitHub Issue의 `open/closed` 상태와 Project 보드의 `Backlog/Ready/In progress/Done` 위치는 서로 다른 의미이므로 분리합니다.

## 테이블

| 테이블 | 역할 |
| --- | --- |
| `kanban_team` | 팀과 원본 저장소 |
| `kanban_member` | GitHub 담당자 |
| `kanban_team_member` | 팀원 소속 및 역할 N:M |
| `kanban_board` | GitHub Project 보드 |
| `kanban_status` | 보드 상태 컬럼과 표시 순서 |
| `kanban_milestone` | 여러 Task가 공유하는 목표 |
| `kanban_task` | GitHub Issue 기반 작업 카드 |
| `kanban_task_assignee` | Task와 담당자의 N:M 연결 |
| `kanban_task_status_history` | Task 상태 이동 이력 |

## 무결성 규칙

- 보드 상태는 `UNIQUE(board_id, status_name)`과 `UNIQUE(board_id, position)`으로 관리합니다.
- Issue 번호는 `UNIQUE(board_id, github_issue_number)`로 중복을 막습니다.
- `issue_state`는 `open`, `closed`만 허용합니다.
- `priority`는 `낮음`, `중간`, `높음`, `size`는 `S`, `M`, `L`만 허용합니다.
- 담당자와 Task는 복합 PK 연결 테이블로 중복 배정을 막습니다.
- 하위 이슈 완료 수는 전체 수보다 클 수 없습니다.
- 종료 시각은 생성 시각보다 빠를 수 없습니다.

## `kanban_task` 주요 컬럼

| 컬럼 | 설명 |
| --- | --- |
| `status_id` | 현재 보드 컬럼 |
| `milestone_id` | 선택적 목표 |
| `github_issue_number` | 원본 Issue 번호 |
| `issue_state` | Issue 자체의 열림/닫힘 |
| `title`, `description` | 작업 내용 |
| `priority`, `estimate`, `size` | 프로젝트 관리 속성 |
| `sub_issues_completed`, `sub_issues_total` | 하위 이슈 진행률 |
| `position` | 같은 상태 안의 카드 순서 |

## 데이터 입력 순서

`kanban_team` → `kanban_member` → `kanban_team_member` → `kanban_board` → `kanban_status`/`kanban_milestone` → `kanban_task` → `kanban_task_assignee` → `kanban_task_status_history`
