-- Browser clients may read public board data, but may not write it.
revoke insert, update, delete on table public.projects from anon, authenticated;
revoke insert, update, delete on table public.users from anon, authenticated;
revoke insert, update, delete on table public.statuses from anon, authenticated;
revoke insert, update, delete on table public.milestones from anon, authenticated;
revoke insert, update, delete on table public.tasks from anon, authenticated;
revoke insert, update, delete on table public.task_assignees from anon, authenticated;
revoke insert, update, delete on table public.issue_details from anon, authenticated;
revoke insert, update, delete on table public.issue_comments from anon, authenticated;
revoke insert, update, delete on table public.issue_timeline_events from anon, authenticated;
revoke insert, update, delete on table public.project_status_history from anon, authenticated;
