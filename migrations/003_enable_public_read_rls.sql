-- Public snapshot policy: anonymous/authenticated users may read the board.
-- INSERT, UPDATE, and DELETE remain unavailable to client roles.
alter table public.kanban_team enable row level security;
alter table public.kanban_member enable row level security;
alter table public.kanban_team_member enable row level security;
alter table public.kanban_board enable row level security;
alter table public.kanban_status enable row level security;
alter table public.kanban_milestone enable row level security;
alter table public.kanban_task enable row level security;
alter table public.kanban_task_assignee enable row level security;
alter table public.kanban_task_status_history enable row level security;

create policy kanban_team_public_read on public.kanban_team for select to anon, authenticated using (true);
create policy kanban_member_public_read on public.kanban_member for select to anon, authenticated using (true);
create policy kanban_team_member_public_read on public.kanban_team_member for select to anon, authenticated using (true);
create policy kanban_board_public_read on public.kanban_board for select to anon, authenticated using (true);
create policy kanban_status_public_read on public.kanban_status for select to anon, authenticated using (true);
create policy kanban_milestone_public_read on public.kanban_milestone for select to anon, authenticated using (true);
create policy kanban_task_public_read on public.kanban_task for select to anon, authenticated using (true);
create policy kanban_task_assignee_public_read on public.kanban_task_assignee for select to anon, authenticated using (true);
create policy kanban_task_status_history_public_read on public.kanban_task_status_history for select to anon, authenticated using (true);
