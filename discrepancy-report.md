# CONES source discrepancy report

## Sources read

- Project URL: <https://github.com/users/seune-h0203/projects/3>
- Issue source: <https://github.com/seune-h0203/cones>
- Local raw Issue snapshot: `reference/source/cones-issues.json`
- Design reference: `reference/source/cones-db-design/`
- Separate design reference: `reference/source/asps-3/`
- Final View 1 TSV: `data/raw/cones-project-view1.tsv`

## Confirmed repository Issue snapshot

The public repository API returned 39 Issues and no pull requests in the fetched
pages. There are 34 closed and 5 open Issues. Four assigned accounts were found:
`Hamchaelim`, `seune-h0203`, `ohoobae`, and `qkrtpfls03`. The milestone
`CONES — FINAL SUBMISSION` occurs on 31 Issues; 8 Issues have no milestone.

The fetched Issue numbers are 1–39. Assignee rows total 26, and the snapshot
contains multiple-assignee Issues such as #1, #3, #4, #6, and #7.

## View 1 final source

The supplied `cones-project-view1.tsv` is the authoritative 19-row source for
this assignment's View 1 board. Its `URL` values identify the Issue numbers and
its `Status` values identify the Kanban columns. It contains Todo 0,
In Progress 3, and Done 16. The seed uses those 19 Issue numbers, status
positions, and within-column card positions. Project item IDs remain NULL
because the TSV does not contain them.

## Conflicts

| Item | Reference claim | Current evidence | Decision |
| --- | --- | --- | --- |
| Project number | `database-data.json` says `1` | Requested source URL is `/projects/3` | Seed uses `3`; JSON value is stale |
| Tasks | README claims 19 cards; JSON has `tasks: []` | Repository API has 39 Issues; Project cards could not be read | Do not treat JSON as task seed |
| Assignments | JSON has 26 rows pointing to task IDs 1–19 | JSON has no corresponding task rows | Do not import those orphan rows |
| Project statuses | Reference says Todo / In Progress / Done | Final TSV confirms Todo 0, In Progress 3, Done 16 | Seed uses TSV Status values |
| Board membership | Reference says 19 cards | Final TSV lists 19 Issue URLs | Seed is limited to these 19 cards |

## Required follow-up

Project item IDs are not available in the TSV and remain NULL. The current JOIN
reproduces the final supplied TSV scope, not the repository's other 20 Issues.
