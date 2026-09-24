# Evidence Captures

이 폴더는 실제 서비스 데이터와 Supabase 결과를 확인한 화면 캡처를 보관하는 위치입니다.

## 필요한 캡처

| 파일명 | 화면 | 캡션 |
| --- | --- | --- |
| `01-source-kanban.png` | GitHub Project 원본 보드 | 원본 보드의 4개 상태와 10개 Issue |
| `02-supabase-tables.png` | Supabase Table Editor | 생성된 `kanban_` 테이블 목록과 행 수 |
| `03-supabase-sample-data.png` | Supabase Table Editor | `kanban_task`와 관계 데이터가 적재된 화면 |
| `04-join-result.png` | Supabase SQL Editor | `scripts/reproduce-board.sql` 실행 결과 |

## 캡처 기준

- 주소창 또는 화면 제목에 대상 서비스가 드러나야 합니다.
- 개인정보, Access Token, 비밀번호, service role 키는 캡처하지 않습니다.
- SQL Editor 캡처에는 쿼리와 결과의 컬럼명이 함께 보여야 합니다.
- 결과 캡처에는 보드 상태별 Task 수가 확인되어야 합니다.

현재 저장소에는 허위 화면을 만들지 않기 위해 실제 사용자 화면을 임의로 생성하지 않았습니다. 원본 보드와 Supabase 화면을 캡처한 뒤 위 파일명으로 저장하면 README의 증빙 흐름과 연결됩니다.
