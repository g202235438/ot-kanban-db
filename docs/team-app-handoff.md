# 팀원 앱 변경 전달서

대상 저장소: [JooJeongwon/asps-3](https://github.com/JooJeongwon/asps-3)

## 전달할 파일

- `app.js`
  - Supabase `issue_details`, `issue_comments` 조회 추가
  - Issue 상세 화면에 본문·댓글 표시
  - `tasks.status_id` PATCH 제거
  - 카드 이동 시 읽기 전용 안내 표시
- `README.md`
  - Windows 실행 명령 추가
  - Supabase RLS가 브라우저에서 조회만 허용한다는 설명 추가

현재 두 파일은 `C:\Users\user\AppData\Roaming\Code\User\asps-3` 로컬 클론에서
수정되어 있습니다. 팀원 저장소에는 자동 push하지 않았습니다.

## 적용 방법

1. 팀원 저장소의 `app.js`와 `README.md`를 위 변경본으로 교체합니다.
2. Windows PowerShell에서 저장소 폴더로 이동합니다.
3. `python -m http.server 4173`을 실행합니다.
4. 브라우저에서 `http://localhost:4173`을 엽니다.
5. `19 items · 3 active · 16 done · live data`를 확인합니다.
6. 카드 상세 화면에서 본문과 댓글을 확인합니다.
7. 카드를 이동하려고 할 때 DB PATCH가 발생하지 않고 읽기 전용 안내가
   표시되는지 확인합니다.

`config.js`의 키는 publishable/anon 키만 사용해야 하며, `service_role` 키는
브라우저 코드에 넣지 않습니다.
