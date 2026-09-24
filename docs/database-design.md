# Database Design

## 1. 서비스에서 관리하는 Entity

| Entity | 의미 |
| --- | --- |
| Team | 보드와 구성원을 소유하는 팀 |
| Member | 작업을 담당하는 사용자 |
| Board | GitHub Project에 해당하는 작업 공간 |
| Status | Board 안의 칸반 상태 |
| Milestone | 여러 작업이 공유하는 목표 |
| Task | GitHub Issue에서 가져온 작업 카드 |
| Status History | Task가 상태를 이동한 기록 |

## 2. 관계와 카디널리티

| 관계 | 카디널리티 | 구현 |
| --- | --- | --- |
| Team–Board | 1:N | `kanban_board.team_id` |
| Board–Status | 1:N | `kanban_status.board_id` |
| Board–Milestone | 1:N | `kanban_milestone.board_id` |
| Board–Task | 1:N | `kanban_task.board_id` |
| Status–Task | 1:N | `kanban_task.status_id` |
| Milestone–Task | 1:N | `kanban_task.milestone_id` |
| Team–Member | N:M | `kanban_team_member` |
| Task–Member | N:M | `kanban_task_assignee` |
| Task–Status History | 1:N | `kanban_task_status_history.task_id` |

## 3. 정규화 이유

카드마다 팀 이름, 상태 이름, 담당자 이름을 반복해서 저장하는 평면 구조 대신 반복되는 대상을 별도 Entity로 분리했습니다.

- 상태 이름과 표시 순서는 `kanban_status`에 한 번만 저장합니다.
- 한 Task에 여러 담당자를 저장할 수 있도록 `kanban_task_assignee`를 둡니다.
- 한 Member가 여러 Task를 맡을 수 있도록 담당자 관계를 연결 테이블로 표현합니다.
- Milestone은 여러 Task가 공유하므로 Task에 문자열로 반복하지 않습니다.
- 현재 상태와 과거 상태 변경 기록을 분리해 현재 조회와 이력 분석을 모두 지원합니다.

## 4. 상태의 분리

두 상태는 서로 다른 의미를 가집니다.

| 상태 | 예시 | 컬럼 |
| --- | --- | --- |
| 칸반 보드 위치 | Backlog, Ready, In progress, Done | `kanban_task.status_id` |
| GitHub Issue 생명주기 | open, closed | `kanban_task.issue_state` |

따라서 카드를 `Done` 칸으로 옮기는 것과 GitHub Issue를 `closed`로 닫는 것을 독립적으로 처리할 수 있습니다.

## 5. 무결성

- 모든 Entity는 기본키를 가집니다.
- 외래키로 존재하지 않는 Team, Board, Status, Member를 참조할 수 없게 했습니다.
- 같은 Board에서 상태 순서와 Issue 번호가 중복되지 않게 했습니다.
- `position`은 음수가 될 수 없습니다.
- `priority`, `size`, `issue_state`는 허용된 값만 저장합니다.
- 하위 이슈 완료 수는 전체 수를 초과할 수 없습니다.
- Task와 Member의 같은 조합은 한 번만 배정됩니다.

## 6. 데이터 조회 예시

```sql
select
  t.title,
  s.status_name,
  t.issue_state,
  string_agg(m.member_name, ', ' order by m.member_name) as assignees
from public.kanban_task t
join public.kanban_status s on s.status_id = t.status_id
left join public.kanban_task_assignee ta on ta.task_id = t.task_id
left join public.kanban_member m on m.member_id = ta.member_id
group by t.task_id, t.title, s.status_name, t.issue_state, s.position, t.position
order by s.position, t.position;
```
