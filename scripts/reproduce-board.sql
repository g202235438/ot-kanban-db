-- Reconstructs the 2026-09-25 public View 1 observation.
-- Project item IDs are not part of the final TSV and are intentionally absent.

select
  p.project_name,
  s.position as status_position,
  s.status_name,
  t.github_issue_number,
  t.title,
  t.issue_state,
  d.body,
  count(distinct c.comment_id) as comment_count,
  max(e.occurred_at) as latest_timeline_at,
  max(h.occurred_at) as latest_status_history_at,
  string_agg(u.github_username, ', ' order by u.github_username) as assignees,
  m.title as milestone
from public.projects p
join public.statuses s on s.project_id = p.project_id
left join public.tasks t
  on t.project_id = p.project_id
 and (t.project_id, t.status_id) = (s.project_id, s.status_id)
left join public.task_assignees ta on ta.task_id = t.task_id
left join public.users u on u.user_id = ta.user_id
left join public.milestones m on m.milestone_id = t.milestone_id
left join public.issue_details d on d.task_id = t.task_id
left join public.issue_comments c on c.task_id = t.task_id
left join public.issue_timeline_events e on e.task_id = t.task_id
left join public.project_status_history h on h.task_id = t.task_id
where p.github_repo_full_name = 'seune-h0203/cones'
group by p.project_id, p.project_name, s.status_id, s.position, s.status_name,
  t.task_id, t.github_issue_number, t.title, t.issue_state, d.body, m.title
order by s.position, t.github_issue_number;
