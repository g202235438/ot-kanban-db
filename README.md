# OT Kanban DB Design

GitHub Projects의 `g202235438/ot` 보드를 분석하여 Supabase PostgreSQL 관계형 데이터베이스로 설계한 과제 제출물입니다.

## 원본 프로젝트

- 저장소: https://github.com/g202235438/ot
- GitHub Project: https://github.com/users/g202235438/projects/1
- 팀: 6조
- 주제: TRI-MOTION + FISHING 랜딩페이지

## 설계 목표

GitHub Project의 보드, 상태 컬럼, 작업 카드, 담당자를 반복 없이 분리하고 관계형 제약조건으로 연결했습니다.

| 원본 개념 | 테이블 | 설명 |
| --- | --- | --- |
| 팀 | `kanban_team` | 프로젝트 팀과 저장소 |
| 팀원 | `kanban_member` | 카드 담당자 |
| 프로젝트 보드 | `kanban_board` | GitHub Project |
| 상태 컬럼 | `kanban_column` | Backlog, Ready, In progress, Done |
| 작업 카드 | `kanban_card` | GitHub Issue 기반 작업과 보드 위치 |
| 카드-담당자 | `kanban_card_assignee` | 다대다 연결 |

## 샘플 데이터

원본 TSV에서 확인한 카드 10개와 상태 컬럼 4개를 사용했습니다.

| 상태 | 카드 수 |
| --- | ---: |
| Backlog | 5 |
| Ready | 3 |
| In progress | 1 |
| Done | 1 |

원본 담당자 필드가 비어 있어 발표용 한글 샘플 담당자 3명을 추가하고 카드에 역할별로 연결했습니다. TSV에 있던 Issue URL, 우선순위, 예상치, 크기, 하위 이슈 진행률 필드도 카드에 저장합니다.

`kanban_column`의 값은 보드에서의 위치이고, `kanban_card.issue_state`는 GitHub Issue의 열림/닫힘 상태입니다. 두 상태를 분리해 카드 이동과 Issue 상태 변경을 독립적으로 관리합니다.

## 실행

1. Supabase SQL Editor에서 [`migrations/001_create_kanban_schema.sql`](migrations/001_create_kanban_schema.sql)을 실행합니다.
2. 또는 이미 적용된 Supabase 프로젝트의 `kanban_` 테이블을 조회합니다.
3. [`docs/kanban-erd.md`](docs/kanban-erd.md)의 Conceptual ERD를 발표자료에 포함합니다.

## 보안

실제 Supabase 키, 비밀번호, `.env` 파일은 저장소에 포함하지 않습니다. 공개 서비스로 연결할 때는 공개 조회 정책을 먼저 정의한 뒤 RLS를 활성화해야 합니다.

## 발표용 요약

> GitHub 칸반 화면의 보드·상태·작업·담당자 정보를 Board–Column–Card 구조로 정규화하고, 보드 위치와 Issue 상태를 분리했으며 카드와 담당자의 다대다 관계를 별도 테이블로 분리하여 Supabase에서 조회 가능한 DB로 구현했습니다.
