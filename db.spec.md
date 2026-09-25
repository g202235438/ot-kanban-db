# CONES DB specification

## Source scope

The final source is `data/raw/cones-project-view1.tsv`. Its 19 rows define the
board cards. Issue state, author, body, timestamps, assignees, and Milestone are
joined from `data/raw/cones-issues.json`. The other repository Issues are not
inserted into `tasks`.

## Tables

- `projects`: Repository and GitHub Project identity.
- `users`: One row per GitHub account; `github_username` is unique.
- `statuses`: Project-scoped Kanban columns. `status_name` and `position` are
  unique within a project. Todo is retained even when its card count is zero.
- `milestones`: Project-scoped GitHub Milestones. A task may have no Milestone.
- `tasks`: The 19 View 1 Issue cards. `github_issue_number` is unique within a
  project. `issue_state` is separate from `status_id`.
- `task_assignees`: Task–User many-to-many relation with composite primary key
  `(task_id, user_id)`.

## Integrity rules

- `status_id` and `milestone_id` use project-scoped composite foreign keys.
- `tasks.issue_state` is restricted to `open` or `closed`.
- `closed_at` cannot precede `created_at`.
- `status_position >= 0` and `card_position >= 1`.
- Deleting a project cascades to its statuses, milestones, and tasks.
- Deleting a task cascades to assignments.
- Deleting a user removes assignment rows and nulls an Issue author reference.

## Applied snapshot

- Board cards: 19
- Todo / In Progress / Done: 0 / 3 / 16
- Task-assignee rows: 26
- Project item IDs: NULL because they are absent from the final TSV
- RLS: not applied; no authenticated access policy was claimed or tested
