# CONES Kanban conceptual ERD

```mermaid
erDiagram
    PROJECTS ||--o{ STATUSES : defines
    PROJECTS ||--o{ MILESTONES : groups
    PROJECTS ||--o{ TASKS : contains
    STATUSES o|--o{ TASKS : places
    MILESTONES o|--o{ TASKS : groups
    USERS ||--o{ TASK_ASSIGNEES : receives
    TASKS ||--o{ TASK_ASSIGNEES : has
```

`TASKS.status_id` is nullable only while the live Projects item export is unavailable.
After Project item membership and status are verified, every board card receives a
status. `TASKS.issue_state` remains separate from the Kanban status because GitHub
Issue open/closed state and Project column are different concepts.
