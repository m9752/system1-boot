# system1
- Spring Boot 기반, 테스트 용도의 토이 프로젝트.
    - `Spring Boot 2.9.3`
    - `Spring Security` 적용
    - `bootstrap4` 기반 UI 적용
    - free-jqgrid 사용

### 관련 오픈소스
- carbon : Bootstrap 4 Admin Template
    - <https://github.com/seguce92/carbon>
- chart.js : Open source HTML5 Charts
    - <https://www.chartjs.org/>
- prism.js : syntax highlighter
    - <https://prismjs.com/>
- free-jqgrid 4.15.4
    - <https://free-jqgrid.github.io/jqGrid/>

### TODO
1. maven -> gradle 변경
1. JSP -> thymeleaf 변경
1. SSO 처리 (JWT)
1. Oracle DB -> postgreSQL 변경
1. 불필요한 스프링 내용 삭제
    - Spring에서 Spring Boot로 변경하여 불필요한 설정들이 있음
1. 로그인 처리 로직 추가
    - 입력 5회 틀렸을 경우 처리, 패스워드 복잡도 등
1. 회원 가입 페이지 추가
1. 파일 다운로드 및 엑셀 다운로드 기능 추가
1. 공통코드 관리 화면 추가
1. 메뉴 관리 화면 추가
    - 사이드바 메뉴에 자동으로 추가되도록
    - 유저 권한으로 메뉴 표시되도록
1. 그리드 변경
    - toast UI …?
1. 그 외 여러가지..
