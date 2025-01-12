# 프로젝트 구조

lib/

├── main.dart      # 앱의 진입점 (runApp, MaterialApp 설정)
│
├── core/           # 앱 전반에 걸쳐 사용되는 공통 기능
│   ├── error/      # 에러 처리 관련 클래스
│   └── router/     # 라우팅 설정 (go_router 설정)
│
├── data/           # 데이터 계층
│   ├── models/     # API나 DB의 데이터를 표현하는 모델 클래스
│   └── repositories/  # repository 구현체
│
├── domain/         # 비즈니스 로직 계층
│   ├── entities/   # 비즈니스 객체 정의
│   └── repositories/  # repository 인터페이스 정의
│
└── presentation/   # UI 계층
    └── views/      # 화면 구현 (위젯)

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