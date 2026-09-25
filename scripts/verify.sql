-- Verification queries for the CONES schema.

select 'projects' as table_name, count(*) as row_count from public.projects
union all select 'users', count(*) from public.users
union all select 'statuses', count(*) from public.statuses
union all select 'milestones', count(*) from public.milestones
union all select 'tasks', count(*) from public.tasks
union all select 'task_assignees', count(*) from public.task_assignees
order by table_name;

select github_issue_number, title
from public.tasks
where status_id is null
order by github_issue_number;

select ta.task_id, ta.user_id
from public.task_assignees ta
left join public.tasks t on t.task_id = ta.task_id
left join public.users u on u.user_id = ta.user_id
where t.task_id is null or u.user_id is null;

select project_id, github_issue_number, count(*) as duplicate_count
from public.tasks
group by project_id, github_issue_number
having count(*) > 1;

select s.status_name, count(t.task_id) as task_count
from public.statuses s
left join public.tasks t on t.status_id = s.status_id
group by s.status_id, s.status_name, s.position
order by s.position;

select
  s.status_name,
  count(t.task_id) as task_count
from public.statuses s
left join public.tasks t on t.status_id = s.status_id
where s.project_id = (select project_id from public.projects where github_repo_full_name = 'seune-h0203/cones')
group by s.status_id, s.status_name, s.position
order by s.position;

select count(*) as total_board_tasks
from public.tasks t
join public.projects p on p.project_id = t.project_id
where p.github_repo_full_name = 'seune-h0203/cones';

select count(*) as one_row_per_task_join
from (
  select t.task_id
  from public.tasks t
  join public.projects p on p.project_id = t.project_id
  left join public.task_assignees ta on ta.task_id = t.task_id
  where p.github_repo_full_name = 'seune-h0203/cones'
  group by t.task_id
) board_rows;

select count(*) as board_assignment_rows
from public.task_assignees ta
join public.tasks t on t.task_id = ta.task_id
join public.projects p on p.project_id = t.project_id
where p.github_repo_full_name = 'seune-h0203/cones';

select
  t.github_issue_number,
  t.title,
  t.issue_state,
  s.status_name as board_status,
  string_agg(u.github_username, ', ' order by u.github_username) as assignees,
  m.title as milestone
from public.tasks t
left join public.statuses s on s.status_id = t.status_id
left join public.task_assignees ta on ta.task_id = t.task_id
left join public.users u on u.user_id = ta.user_id
left join public.milestones m on m.milestone_id = t.milestone_id
group by t.task_id, s.status_name, m.title
order by s.position, t.github_issue_number;
