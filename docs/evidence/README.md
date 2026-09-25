# Evidence checklist

The database and SQL results are committed, but screenshots must be captured from
the real services rather than fabricated.

## Required captures

1. **Original board**: GitHub Projects View 1 showing Todo, In Progress, and
   Done. The final TSV is the authoritative 19-row source.
2. **Supabase tables**: Table Editor showing `projects`, `statuses`, `tasks`,
   `users`, `milestones`, and `task_assignees`.
3. **JOIN result**: SQL Editor output from
   [`scripts/reproduce-board.sql`](../../scripts/reproduce-board.sql), showing
   19 task rows and aggregated assignees.
4. **Verification result**: SQL output showing Todo 0, In Progress 3, Done 16,
   total tasks 19, and assignment rows 26.

This repository records the reproducible source and queries. It does not claim
that screenshots exist when they have not been captured.
