-- Per-card timeline collection and loading verification.

select
  requested_issue_number,
  requested_issue_url,
  requested_task_id,
  http_status,
  collected_event_count,
  loaded_event_count,
  failure_reason
from public.timeline_collection_requests
order by requested_issue_number;

select
  count(*) as requested_cards,
  count(*) filter (where http_status = 200) as successful_requests,
  count(*) filter (where http_status <> 200) as failed_requests,
  coalesce(sum(collected_event_count), 0) as collected_events,
  coalesce(sum(loaded_event_count), 0) as loaded_events
from public.timeline_collection_requests;

select
  179 as legacy_source_unknown_events,
  0 as legacy_events_linked,
  (select count(*) from public.timeline_collection_requests) as requested_cards,
  (select count(*) from public.timeline_collection_requests where http_status = 200) as successful_requests,
  (select count(*) from public.timeline_collection_requests where http_status <> 200) as failed_requests,
  (select coalesce(sum(collected_event_count), 0) from public.timeline_collection_requests) as newly_collected_events,
  (select coalesce(sum(loaded_event_count), 0) from public.timeline_collection_requests) as recorded_loaded_events,
  (select count(*) from public.issue_timeline_events) as loaded_timeline_events,
  (select count(*) from public.project_status_history) as loaded_status_history;

select
  count(*) as status_events_with_verified_before_after
from public.project_status_history
where verification_status = 'verified'
  and from_status_id is not null
  and to_status_id is not null;

select
  requested_issue_number,
  collected_event_count,
  loaded_event_count,
  (select count(*)
     from public.issue_timeline_events e
    where e.requested_issue_number = r.requested_issue_number) as actual_loaded_rows,
  collected_event_count -
  (select count(*)
     from public.issue_timeline_events e
    where e.requested_issue_number = r.requested_issue_number) as remaining_to_load
from public.timeline_collection_requests r
order by requested_issue_number;

select
  count(*) as orphan_task_links
from public.issue_timeline_events e
left join public.tasks t on t.task_id = e.task_id
where t.task_id is null;

select
  count(*) as mismatched_requested_task_links
from public.issue_timeline_events e
join public.tasks t on t.task_id = e.task_id
where e.requested_task_id is distinct from e.task_id;

select
  count(*) as duplicate_event_ids
from (
  select event_id
  from public.issue_timeline_events
  group by event_id
  having count(*) > 1
) duplicates;
