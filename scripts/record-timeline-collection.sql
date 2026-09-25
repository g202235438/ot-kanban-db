-- Record one provenance-preserving collection attempt for each View 1 card.
-- Replace http_status, counts, and failure_reason with the authenticated
-- collector result before loading any events.

insert into public.timeline_collection_requests (
  requested_issue_number,
  requested_issue_url,
  requested_task_id,
  events_url,
  http_status,
  collected_event_count,
  loaded_event_count,
  failure_reason
)
select
  v.issue_number,
  v.issue_url,
  t.task_id,
  v.events_url,
  v.http_status,
  v.collected_event_count,
  v.loaded_event_count,
  v.failure_reason
from (
  values
    (1, 200, 0, 0, null),
    (2, 200, 0, 0, null),
    (3, 200, 0, 0, null),
    (4, 200, 0, 0, null),
    (5, 200, 0, 0, null),
    (6, 200, 0, 0, null),
    (7, 200, 0, 0, null),
    (9, 200, 0, 0, null),
    (10, 200, 0, 0, null),
    (11, 200, 0, 0, null),
    (12, 200, 0, 0, null),
    (13, 200, 0, 0, null),
    (32, 200, 0, 0, null),
    (33, 200, 0, 0, null),
    (34, 200, 0, 0, null),
    (35, 200, 0, 0, null),
    (36, 200, 0, 0, null),
    (37, 200, 0, 0, null),
    (39, 200, 0, 0, null)
) v(issue_number, http_status, collected_event_count, loaded_event_count, failure_reason)
cross join lateral (
  values (
    'https://github.com/seune-h0203/cones/issues/' || v.issue_number,
    'https://api.github.com/repos/seune-h0203/cones/issues/' || v.issue_number || '/events'
  )
) urls(issue_url, events_url)
join public.tasks t on t.github_issue_number = v.issue_number
on conflict (requested_issue_number) do update
set http_status = excluded.http_status,
    collected_event_count = excluded.collected_event_count,
    loaded_event_count = excluded.loaded_event_count,
    failure_reason = excluded.failure_reason,
    collected_at = now();
