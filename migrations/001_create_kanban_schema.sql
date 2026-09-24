create extension if not exists pgcrypto;

create table public.kanban_team (
  team_id uuid primary key default gen_random_uuid(),
  team_name text not null unique,
  repository_url text not null,
  created_at timestamptz not null default now()
);

create table public.kanban_member (
  member_id uuid primary key default gen_random_uuid(),
  team_id uuid not null references public.kanban_team(team_id) on delete cascade,
  member_name text not null,
  github_username text,
  department text,
  student_number text,
  created_at timestamptz not null default now(),
  unique (team_id, member_name),
  unique (team_id, github_username)
);

create table public.kanban_board (
  board_id uuid primary key default gen_random_uuid(),
  team_id uuid not null references public.kanban_team(team_id) on delete cascade,
  board_name text not null,
  github_project_url text not null unique,
  created_at timestamptz not null default now(),
  unique (team_id, board_name)
);

create table public.kanban_column (
  column_id uuid primary key default gen_random_uuid(),
  board_id uuid not null references public.kanban_board(board_id) on delete cascade,
  column_name text not null,
  position integer not null check (position >= 0),
  unique (board_id, column_name),
  unique (board_id, position)
);

create table public.kanban_card (
  card_id uuid primary key default gen_random_uuid(),
  board_id uuid not null references public.kanban_board(board_id) on delete cascade,
  column_id uuid not null references public.kanban_column(column_id) on delete restrict,
  title text not null,
  issue_url text not null unique,
  priority text,
  estimate numeric(10,2) check (estimate is null or estimate >= 0),
  size text,
  position integer not null default 0 check (position >= 0)
);

create table public.kanban_card_assignee (
  card_id uuid not null references public.kanban_card(card_id) on delete cascade,
  member_id uuid not null references public.kanban_member(member_id) on delete cascade,
  primary key (card_id, member_id)
);

insert into public.kanban_team (team_name, repository_url)
values ('6조', 'https://github.com/g202235438/ot');

insert into public.kanban_board (team_id, board_name, github_project_url)
select team_id, 'Tri-Motion + Fishing 개발 보드',
       'https://github.com/users/g202235438/projects/1'
from public.kanban_team where team_name = '6조';

insert into public.kanban_column (board_id, column_name, position)
select board_id, column_name, position
from public.kanban_board
cross join (values
  ('Backlog', 0), ('Ready', 1), ('In progress', 2), ('Done', 3)
) as columns(column_name, position);

insert into public.kanban_member (team_id, member_name, github_username, department, student_number)
select team_id, member_name, github_username, department, student_number
from public.kanban_team
cross join (values
  ('김기획', 'g202235438', '컴퓨터공학과', '20220001'),
  ('이개발', 'developer6', '소프트웨어학과', '20220002'),
  ('박디자인', 'designer6', '디지털콘텐츠학과', '20220003')
) as members(member_name, github_username, department, student_number)
where team_name = '6조';

insert into public.kanban_card (board_id, column_id, title, issue_url, priority, estimate, size, position)
select b.board_id, c.column_id, cards.title, cards.issue_url,
       cards.priority, cards.estimate, cards.size, cards.position
from public.kanban_board b
join public.kanban_column c on c.board_id = b.board_id
join (values
  ('Running Scene 구현', 'https://github.com/g202235438/ot/issues/1', 'Backlog', '낮음', 2, 'S', 0),
  ('Scene Transition 연결', 'https://github.com/g202235438/ot/issues/2', 'Backlog', '높음', 5, 'L', 1),
  ('캐릭터 크기 및 카메라 구도 QA', 'https://github.com/g202235438/ot/issues/3', 'Backlog', '중간', 3, 'M', 2),
  ('반응형 및 성능 최적화', 'https://github.com/g202235438/ot/issues/4', 'Backlog', '중간', 5, 'L', 3),
  ('최종 QA 및 제출 링크 정리', 'https://github.com/g202235438/ot/issues/5', 'Backlog', '높음', 3, 'M', 4),
  ('Swimming Scene 구현', 'https://github.com/g202235438/ot/issues/6', 'Ready', '낮음', 2, 'S', 0),
  ('Cycling Scene 구현', 'https://github.com/g202235438/ot/issues/7', 'Ready', '낮음', 2, 'S', 1),
  ('Fishing Scene 구현', 'https://github.com/g202235438/ot/issues/8', 'Ready', '낮음', 2, 'S', 2),
  ('Landing Page 기본 구조 및 콘텐츠 연결', 'https://github.com/g202235438/ot/issues/9', 'In progress', '낮음', 2, 'S', 0),
  ('README 프로젝트 개요 정리', 'https://github.com/g202235438/ot/issues/10', 'Done', '낮음', 2, 'S', 0)
) as cards(title, issue_url, column_name, priority, estimate, size, position)
  on c.column_name = cards.column_name
where b.github_project_url = 'https://github.com/users/g202235438/projects/1';

insert into public.kanban_card_assignee (card_id, member_id)
select c.card_id, m.member_id
from public.kanban_card c
join public.kanban_member m on m.github_username = case
  when c.title in ('README 프로젝트 개요 정리', 'Landing Page 기본 구조 및 콘텐츠 연결') then 'g202235438'
  when c.title in ('Swimming Scene 구현', 'Running Scene 구현', 'Scene Transition 연결') then 'developer6'
  else 'designer6'
end
where c.issue_url like 'https://github.com/g202235438/ot/issues/%';
