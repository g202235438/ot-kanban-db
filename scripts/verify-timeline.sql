-- Timeline provenance audit for the CONES View 1 scope.
-- The raw file was collected per Issue request, but the saved event objects
-- do not contain the request Issue number. Their URL is /issues/events/:id,
-- so an exact Task match cannot be reconstructed without guessing.

select
  179 as raw_timeline_event_count,
  179 as excluded_without_issue_provenance,
  0 as safely_matched_view1_events,
  (select count(*) from public.issue_timeline_events) as loaded_timeline_events,
  0 as expected_status_history_rows,
  (select count(*) from public.project_status_history) as loaded_status_history_rows;

select
  'missing_source_issue_number_or_url' as exclusion_reason,
  179 as event_count,
  'The stored event payload has event URL, actor, and occurred_at, but no source Issue number. The URL format /issues/events/:id is not reversible.' as detail
union all
select
  'status_before_after_unavailable',
  40,
  'project_v2_item_status_changed was observed in the raw collection, but before/after Project Status values were not present; no project_status_history rows were inferred.';

select
  e.event_id,
  e.source_url,
  e.event_type,
  e.occurred_at,
  e.actor_login
from public.issue_timeline_events e
order by e.occurred_at, e.event_id;
