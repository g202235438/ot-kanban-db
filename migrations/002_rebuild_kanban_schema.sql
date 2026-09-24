-- Final Kanban schema and sample data migration.
drop table if exists public.kanban_card_assignee cascade;
drop table if exists public.kanban_task_status_history cascade;
drop table if exists public.kanban_task_assignee cascade;
drop table if exists public.kanban_card cascade;
drop table if exists public.kanban_task cascade;
drop table if exists public.kanban_column cascade;
drop table if exists public.kanban_status cascade;
drop table if exists public.kanban_milestone cascade;
drop table if exists public.kanban_board cascade;
drop table if exists public.kanban_team_member cascade;
drop table if exists public.kanban_member cascade;
drop table if exists public.kanban_team cascade;

create table public.kanban_team (
  team_id uuid primary key default gen_random_uuid(),
  team_name text not null unique,
  repository_url text not null,
  created_at timestamptz not null default now()
);
create table public.kanban_member (
  member_id uuid primary key default gen_random_uuid(),
  member_name text not null,
  github_username text not null unique,
  department text,
  student_number text,
  created_at timestamptz not null default now()
);
create table public.kanban_team_member (
  team_id uuid not null references public.kanban_team(team_id) on delete cascade,
  member_id uuid not null references public.kanban_member(member_id) on delete cascade,
  role text not null default '팀원',
  joined_at timestamptz not null default now(),
  primary key (team_id, member_id)
);
create table public.kanban_board (
  board_id uuid primary key default gen_random_uuid(),
  team_id uuid not null references public.kanban_team(team_id) on delete cascade,
  board_name text not null,
  github_project_url text not null unique,
  created_at timestamptz not null default now(),
  unique (team_id, board_name)
);
create table public.kanban_status (
  status_id uuid primary key default gen_random_uuid(),
  board_id uuid not null references public.kanban_board(board_id) on delete cascade,
  status_name text not null,
  position integer not null check (position >= 0),
  is_done boolean not null default false,
  unique (board_id, status_name),
  unique (board_id, position)
);
create table public.kanban_milestone (
  milestone_id uuid primary key default gen_random_uuid(),
  board_id uuid not null references public.kanban_board(board_id) on delete cascade,
  title text not null,
  state text not null default 'open' check (state in ('open', 'closed')),
  due_date date,
  unique (board_id, title)
);
create table public.kanban_task (
  task_id uuid primary key default gen_random_uuid(),
  board_id uuid not null references public.kanban_board(board_id) on delete cascade,
  status_id uuid not null references public.kanban_status(status_id) on delete restrict,
  milestone_id uuid references public.kanban_milestone(milestone_id) on delete set null,
  github_issue_number integer not null,
  issue_url text not null unique,
  title text not null,
  description text,
  issue_state text not null default 'open' check (issue_state in ('open', 'closed')),
  priority text check (priority is null or priority in ('낮음', '중간', '높음')),
  estimate numeric(10,2) check (estimate is null or estimate >= 0),
  size text check (size is null or size in ('S', 'M', 'L')),
  linked_pull_requests text[],
  sub_issues_completed integer check (sub_issues_completed is null or sub_issues_completed >= 0),
  sub_issues_total integer check (sub_issues_total is null or sub_issues_total >= 0),
  position integer not null default 0 check (position >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  closed_at timestamptz,
  unique (board_id, github_issue_number),
  check (sub_issues_completed is null or sub_issues_total is null or sub_issues_completed <= sub_issues_total),
  check (closed_at is null or closed_at >= created_at)
);
create table public.kanban_task_assignee (
  task_id uuid not null references public.kanban_task(task_id) on delete cascade,
  member_id uuid not null references public.kanban_member(member_id) on delete cascade,
  assigned_at timestamptz not null default now(),
  primary key (task_id, member_id)
);
create table public.kanban_task_status_history (
  history_id uuid primary key default gen_random_uuid(),
  task_id uuid not null references public.kanban_task(task_id) on delete cascade,
  from_status_id uuid references public.kanban_status(status_id) on delete set null,
  to_status_id uuid not null references public.kanban_status(status_id) on delete restrict,
  changed_by_member_id uuid references public.kanban_member(member_id) on delete set null,
  changed_at timestamptz not null default now()
);

create index kanban_task_status_idx on public.kanban_task (status_id, position);
create index kanban_task_milestone_idx on public.kanban_task (milestone_id);
create index kanban_history_task_idx on public.kanban_task_status_history (task_id, changed_at desc);

insert into public.kanban_team (team_name, repository_url)
values ('6조', 'https://github.com/g202235438/ot');
insert into public.kanban_member (member_name, github_username, department, student_number)
values
  ('김기획', 'g202235438', '컴퓨터공학과', '20220001'),
  ('이개발', 'developer6', '소프트웨어학과', '20220002'),
  ('박디자인', 'designer6', '디지털콘텐츠학과', '20220003');
insert into public.kanban_team_member (team_id, member_id, role)
select t.team_id, m.member_id,
  case m.github_username when 'g202235438' then '기획'
    when 'developer6' then '개발' else '디자인·QA' end
from public.kanban_team t cross join public.kanban_member m
where t.team_name = '6조';
insert into public.kanban_board (team_id, board_name, github_project_url)
select team_id, 'Tri-Motion + Fishing 개발 보드',
  'https://github.com/users/g202235438/projects/1'
from public.kanban_team where team_name = '6조';
insert into public.kanban_status (board_id, status_name, position, is_done)
select board_id, v.status_name, v.position, v.is_done
from public.kanban_board
cross join (values
  ('Backlog', 0, false), ('Ready', 1, false),
  ('In progress', 2, false), ('Done', 3, true)
) v(status_name, position, is_done);
insert into public.kanban_milestone (board_id, title, state)
select board_id, 'TRI-MOTION + FISHING 개발 완료', 'open'
from public.kanban_board;

insert into public.kanban_task
  (board_id, status_id, milestone_id, github_issue_number, issue_url,
   title, description, issue_state, priority, estimate, size, position,
   sub_issues_completed, sub_issues_total)
select b.board_id, s.status_id, m.milestone_id, v.issue_number, v.issue_url,
  v.title, v.description, v.issue_state, v.priority, v.estimate, v.size,
  case v.status_name when 'Backlog' then v.issue_number - 1
    when 'Ready' then v.issue_number - 6 else 0 end,
  v.sub_done, v.sub_total
from public.kanban_board b
join public.kanban_status s on s.board_id = b.board_id
join public.kanban_milestone m on m.board_id = b.board_id
cross join (values
  (1, 'https://github.com/g202235438/ot/issues/1', 'Running Scene 구현', '달리기 장면과 캐릭터 동작 구현', 'open', '낮음', 2, 'S', 'Backlog', 0, 0),
  (2, 'https://github.com/g202235438/ot/issues/2', 'Scene Transition 연결', '수영·사이클·달리기·낚시 장면 전환 연결', 'open', '높음', 5, 'L', 'Backlog', 0, 0),
  (3, 'https://github.com/g202235438/ot/issues/3', '캐릭터 크기 및 카메라 구도 QA', '캐릭터 크기와 화면 구도 검수', 'open', '중간', 3, 'M', 'Backlog', 0, 0),
  (4, 'https://github.com/g202235438/ot/issues/4', '반응형 및 성능 최적화', '반응형 화면과 애니메이션 성능 개선', 'open', '중간', 5, 'L', 'Backlog', 0, 0),
  (5, 'https://github.com/g202235438/ot/issues/5', '최종 QA 및 제출 링크 정리', '최종 검수와 제출 링크 정리', 'open', '높음', 3, 'M', 'Backlog', 0, 0),
  (6, 'https://github.com/g202235438/ot/issues/6', 'Swimming Scene 구현', '수영 장면과 물 효과 구현', 'open', '낮음', 2, 'S', 'Ready', 0, 0),
  (7, 'https://github.com/g202235438/ot/issues/7', 'Cycling Scene 구현', '자전거 장면과 속도감 구현', 'open', '낮음', 2, 'S', 'Ready', 0, 0),
  (8, 'https://github.com/g202235438/ot/issues/8', 'Fishing Scene 구현', '낚시 장면과 물고기 연출 구현', 'open', '낮음', 2, 'S', 'Ready', 0, 0),
  (9, 'https://github.com/g202235438/ot/issues/9', 'Landing Page 기본 구조 및 콘텐츠 연결', '랜딩페이지 기본 구조와 콘텐츠 연결', 'open', '낮음', 2, 'S', 'In progress', 0, 0),
  (10, 'https://github.com/g202235438/ot/issues/10', 'README 프로젝트 개요 정리', '프로젝트 개요와 실행 방법 문서화', 'closed', '낮음', 2, 'S', 'Done', 3, 3)
) v(issue_number, issue_url, title, description, issue_state, priority, estimate, size, status_name, sub_done, sub_total)
where b.github_project_url = 'https://github.com/users/g202235438/projects/1'
  and s.status_name = v.status_name;

insert into public.kanban_task_assignee (task_id, member_id)
select t.task_id, m.member_id
from public.kanban_task t
join public.kanban_member m on m.github_username =
  case when t.github_issue_number in (9, 10) then 'g202235438'
    when t.github_issue_number in (1, 2, 6) then 'developer6'
    else 'designer6' end;
insert into public.kanban_task_status_history
  (task_id, from_status_id, to_status_id, changed_by_member_id)
select t.task_id, null, s.status_id, m.member_id
from public.kanban_task t
join public.kanban_status s on s.status_id = t.status_id
join public.kanban_member m on m.github_username = 'g202235438';
