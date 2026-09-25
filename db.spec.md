# CONES DB specification

## `projects`

Project/repository boundary. `github_repo_full_name` and `github_project_url` are
unique. The source Project URL is `/projects/3`; the older reference JSON value
`1` is not used.

## `users`

One row per GitHub account. `github_username` is unique.

## `statuses`

Project-scoped Kanban columns. `(project_id, status_name)` and
`(project_id, position)` are unique. The reference column names are Todo,
In Progress, and Done, but card assignment is not considered verified until the
live Project items can be read.

## `milestones`

Project-scoped GitHub milestones. A task may have no milestone. A non-null
milestone number is unique within a project.

## `tasks`

Repository Issues and, when available, their Project card identity. The Issue
number is unique within a project. `issue_state` is independent from the
nullable `status_id`; the latter is nullable only for the current incomplete
Project snapshot.

## `task_assignees`

Many-to-many relation between tasks and users. The composite primary key
`(task_id, user_id)` prevents duplicate assignments.

## Delete behavior

Deleting a project cascades to statuses, milestones, and tasks. Deleting a task
cascades to task assignments. Deleting a user removes assignment rows and
nulls an Issue author reference.
