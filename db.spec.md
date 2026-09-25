# CONES DB specification

## Source scope

The final source is `data/raw/cones-project-view1.tsv`. Its 19 rows define the
board cards. Issue state, assignees, and optional Milestone are joined from
`data/raw/cones-issues.json`. The other repository Issues are not inserted into
`tasks`; the full payload is preserved only as a raw source file.

## Tables

- `projects`: Repository and GitHub Project identity.
- `users`: One row per GitHub account; `github_username` is unique.
- `statuses`: Project-scoped Kanban columns. `status_name` and `position` are
  unique within a project. Todo is retained even when its card count is zero.
- `milestones`: Project-scoped GitHub Milestones. A task may have no Milestone.
- `tasks`: The 19 View 1 Issue cards. It keeps only its internal PK, project FK,
  Issue number/title/URL, Issue state, status FK, and optional Milestone FK.
  `github_issue_number` is unique within a project.
- `task_assignees`: Task–User many-to-many relation with composite primary key
  `(task_id, user_id)`.
- `issue_details`: One-to-one Issue body and source metadata for each View 1 task.
- `issue_comments`: Verified Issue comments connected to a task.
- `issue_timeline_events`: Timeline event structure with source URL and raw metadata.
- `project_status_history`: Separate Project status history structure. Before/after
  values remain nullable and unconfirmed unless the source explicitly provides them.

## Integrity rules

- `status_id` and `milestone_id` use project-scoped composite foreign keys.
- `tasks.issue_state` is restricted to `open` or `closed`.
- Deleting a project cascades to its statuses, milestones, and tasks.
- Deleting a task cascades to assignments.
- Deleting a user cascades to assignment rows.
- Browser roles receive SELECT policies only. No anon/authenticated write policy
  exists on any public table.

## Applied snapshot

- Board cards: 19
- Todo / In Progress / Done: 0 / 3 / 16
- Task-assignee rows: 26
- Project item IDs and node IDs: not stored because they are absent from the final TSV
- RLS: not applied; no authenticated access policy was claimed or tested
