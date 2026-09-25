-- Enforce that a task can reference only a status belonging to the same project.
-- Run the verification query first; it must return zero mismatches.

select count(*) as mismatched_task_status_projects
from public.tasks t
join public.statuses s on s.status_id = t.status_id
where t.project_id <> s.project_id;

alter table public.tasks
  drop constraint if exists tasks_project_status_fkey;

alter table public.tasks
  add constraint tasks_project_status_fkey
  foreign key (project_id, status_id)
  references public.statuses (project_id, status_id)
  on delete restrict;
