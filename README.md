# 프로젝트 구조
![mermaid-diagram-2025-01-12-143526](https://github.com/user-attachments/assets/d53e2361-b35e-43d6-986f-75bb71447afb)

# 각 계층의 주요 역할

### core/
- 앱 전체에서 공통으로 사용되는 유틸리티 기능들
- 라우팅, 에러 처리, 상수 등을 포함

### data/
- 실제 데이터 처리를 담당
- API 통신, DB 작업 등의 구현체
- domain 계층의 repository 인터페이스를 구현

### domain/
- 비즈니스 로직의 핵심
- 순수한 Dart 코드로만 구성 (Flutter 의존성 없음)
- 엔티티와 repository 인터페이스 정의

### presentation/
- UI 관련 코드
- 화면을 구성하는 위젯들
- 사용자와의 상호작용 처리
