# Source Data Analysis

## 1. 원본 보드

- GitHub repository: https://github.com/g202235438/ot
- GitHub Project: https://github.com/users/g202235438/projects/1
- 보드 이름: Tri-Motion + Fishing 개발 보드
- 원본 파일: `data/sample-kanban-data.tsv`

## 2. 실제로 확인한 데이터 요약

| 항목 | 개수 | 설명 |
| --- | ---: | --- |
| Board | 1 | 6조 개발 보드 |
| Status | 4 | Backlog, Ready, In progress, Done |
| Issue/Task | 10 | GitHub Issue #1~#10 |
| Milestone | 1 | TRI-MOTION + FISHING 개발 완료 |
| Assignee 원본 값 | 0 | 원본 TSV의 Assignees 열이 비어 있음 |
| 샘플 Member | 3 | 관계 검증을 위한 한글 샘플 담당자 |
| Linked Pull Request | 0 | 원본 TSV의 값이 비어 있음 |

## 3. 상태별 Task 수

| 보드 상태 | Task 수 |
| --- | ---: |
| Backlog | 5 |
| Ready | 3 |
| In progress | 1 |
| Done | 1 |

## 4. 원본 데이터에서 발생하는 문제

### 반복되는 정보

카드마다 보드 이름과 상태 이름을 문자열로 저장하면 오타가 발생하고, 보드나 상태 이름을 변경할 때 여러 행을 수정해야 합니다.

### 담당자 여러 명

한 카드에 여러 담당자를 문자열이나 쉼표로 저장하면 담당자별 검색과 집계가 어렵습니다. `kanban_task_assignee` 연결 테이블로 분리했습니다.

### Issue State와 Kanban Status의 차이

GitHub Issue의 `open/closed`와 보드의 `Backlog/Ready/In progress/Done`은 서로 다른 상태입니다. `kanban_task.issue_state`와 `kanban_task.status_id`에 각각 저장합니다.

### 원본의 빈 값

원본 TSV의 담당자, 연결 Pull Request, 하위 이슈 진행률 등 일부 값은 비어 있습니다. 빈 값을 임의로 원본 데이터라고 표시하지 않고, 담당자 3명과 배정 관계는 관계형 구조를 검증하기 위한 별도 샘플로 구분했습니다.

## 5. Entity 분리 결과

```text
원본 평면 데이터
  board_name | status_name | issue | assignee | milestone

정규화된 데이터
  Team → Board → Status
                 ├→ Milestone
                 └→ Task → Task Assignee → Member
                       └→ Status History
```

자세한 카디널리티와 정규화 이유는 [`database-design.md`](database-design.md)를 참고합니다.
