# CONES source discrepancy report

## Sources read

- Project URL: <https://github.com/users/seune-h0203/projects/3>
- Issue source: <https://github.com/seune-h0203/cones>
- Local raw Issue snapshot: `reference/source/cones-issues.json`
- Design reference: `reference/source/cones-db-design/`
- Separate design reference: `reference/source/asps-3/`
- View 1 observation: `data/raw/CONES_board_status_view1_2026-09-25.txt`

## Confirmed repository Issue snapshot

The public repository API returned 39 Issues and no pull requests in the fetched
pages. There are 34 closed and 5 open Issues. Four assigned accounts were found:
`Hamchaelim`, `seune-h0203`, `ohoobae`, and `qkrtpfls03`. The milestone
`CONES — FINAL SUBMISSION` occurs on 31 Issues; 8 Issues have no milestone.

The fetched Issue numbers are 1–39. Assignee rows total 26, and the snapshot
contains multiple-assignee Issues such as #1, #3, #4, #6, and #7.

## View 1 observation

The attached text file records a point-in-time visual observation of the public
View 1 on 2026-09-25. It is not a GitHub Projects CSV export or complete API
payload. It identifies 19 board cards: Todo 0, In Progress 3, and Done 16.
The seed uses those 19 Issue numbers, their observed status positions, and their
within-column card positions. Project item IDs remain NULL because they were not
observed.

## Conflicts

| Item | Reference claim | Current evidence | Decision |
| --- | --- | --- | --- |
| Project number | `database-data.json` says `1` | Requested source URL is `/projects/3` | Seed uses `3`; JSON value is stale |
| Tasks | README claims 19 cards; JSON has `tasks: []` | Repository API has 39 Issues; Project cards could not be read | Do not treat JSON as task seed |
| Assignments | JSON has 26 rows pointing to task IDs 1–19 | JSON has no corresponding task rows | Do not import those orphan rows |
| Project statuses | Reference says Todo / In Progress / Done | View 1 observation confirms Todo 0, In Progress 3, Done 16 | Seed uses the attached observation, not API inference |
| Board membership | Reference says 19 cards | View 1 observation lists 19 Issue numbers | Seed is limited to these 19 cards |

## Required follow-up

Project item IDs and any later board changes still require a future Project
export/API response. The current JOIN is a reproduction of the attached
2026-09-25 View 1 observation, not a claim about unobserved historical or
future board states.
