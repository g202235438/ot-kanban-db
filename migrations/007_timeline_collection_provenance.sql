-- Preserve the request context for every Issue timeline collection attempt.
-- Events are inserted only when event_id and source Issue provenance are present.

alter table public.issue_timeline_events
  add column if not exists requested_issue_number integer,
  add column if not exists requested_issue_url text,
  add column if not exists requested_task_id bigint references public.tasks(task_id)
    on delete cascade;

create table if not exists public.timeline_collection_requests (
  requested_issue_number integer primary key,
  requested_issue_url text not null unique,
  requested_task_id bigint not null references public.tasks(task_id)
    on delete cascade,
  events_url text not null,
  http_status integer not null,
  collected_event_count integer not null default 0,
  loaded_event_count integer not null default 0,
  failure_reason text,
  collected_at timestamptz not null default now()
);

create index if not exists issue_timeline_events_requested_task_idx
  on public.issue_timeline_events(requested_task_id, occurred_at);
