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
    (1, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (2, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (3, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (4, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (5, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (6, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (7, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (9, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (10, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (11, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (12, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (13, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (32, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (33, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (34, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (35, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (36, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (37, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded'),
    (39, 403, 0, 0, 'GitHub API unauthenticated rate limit exceeded')
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
