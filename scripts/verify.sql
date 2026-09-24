-- Supabase SQL Editor에서 실행하는 검증 쿼리
select 'kanban_team' as table_name, count(*) as row_count from public.kanban_team
union all select 'kanban_member', count(*) from public.kanban_member
union all select 'kanban_team_member', count(*) from public.kanban_team_member
union all select 'kanban_board', count(*) from public.kanban_board
union all select 'kanban_status', count(*) from public.kanban_status
union all select 'kanban_milestone', count(*) from public.kanban_milestone
union all select 'kanban_task', count(*) from public.kanban_task
union all select 'kanban_task_assignee', count(*) from public.kanban_task_assignee
union all select 'kanban_task_status_history', count(*) from public.kanban_task_status_history
order by table_name;

select s.status_name, count(t.task_id) as task_count
from public.kanban_status s
left join public.kanban_task t on t.status_id = s.status_id
group by s.status_id, s.status_name, s.position
order by s.position;

select t.github_issue_number, t.title, s.status_name, t.issue_state,
       count(ta.member_id) as assignee_count
from public.kanban_task t
join public.kanban_status s on s.status_id = t.status_id
left join public.kanban_task_assignee ta on ta.task_id = t.task_id
group by t.task_id, t.github_issue_number, t.title, s.status_name, t.issue_state
order by s.position, t.position;
