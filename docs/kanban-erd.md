# CONES Kanban conceptual ERD

```mermaid
erDiagram
    PROJECTS ||--o{ STATUSES : defines
    PROJECTS ||--o{ MILESTONES : groups
    PROJECTS ||--o{ TASKS : contains
    STATUSES ||--o{ TASKS : places
    MILESTONES o|--o{ TASKS : groups
    USERS ||--o{ TASK_ASSIGNEES : receives
    TASKS ||--o{ TASK_ASSIGNEES : has

    PROJECTS {
        bigint project_id PK
        text project_name
        text github_repo_full_name UK
        int github_project_number
    }
    STATUSES {
        bigint status_id PK
        bigint project_id FK
        text status_name
        int position
        boolean is_done
    }
    MILESTONES {
        bigint milestone_id PK
        bigint project_id FK
        int github_milestone_number
        text title
        text state
    }
    USERS {
        bigint user_id PK
        text github_username UK
        text display_name
    }
    TASKS {
        bigint task_id PK
        bigint project_id FK
        bigint status_id FK
        bigint milestone_id FK
        int github_issue_number
        text issue_state
        int status_position
        int card_position
    }
    TASK_ASSIGNEES {
        bigint task_id PK, FK
        bigint user_id PK, FK
        timestamptz assigned_at
    }
```

`TASKS.issue_state` stores the GitHub Issue `open`/`closed` value, while
`TASKS.status_id` stores the Kanban column from the final View 1 TSV. They are
intentionally separate. `github_project_item_id` is not shown as a populated
attribute because the TSV did not provide Project item IDs; the database column
exists and is NULL for all 19 imported cards.

