-- 원본 칸반 보드 화면과 같은 형태로 Task를 다시 조회합니다.
-- Board → Status → Task → Assignee를 JOIN합니다.

select
  b.board_name,
  s.status_name,
  s.position as status_position,
  t.position as task_position,
  t.github_issue_number,
  t.title,
  t.issue_state,
  t.priority,
  t.estimate,
  t.size,
  coalesce(string_agg(m.member_name, ', ' order by m.member_name), '담당자 미지정') as assignees
from public.kanban_board b
join public.kanban_status s on s.board_id = b.board_id
left join public.kanban_task t on t.status_id = s.status_id
left join public.kanban_task_assignee ta on ta.task_id = t.task_id
left join public.kanban_member m on m.member_id = ta.member_id
where b.github_project_url = 'https://github.com/users/g202235438/projects/1'
group by b.board_id, b.board_name, s.status_id, s.status_name, s.position,
         t.task_id, t.position, t.github_issue_number, t.title,
         t.issue_state, t.priority, t.estimate, t.size
order by s.position, t.position, t.github_issue_number;
