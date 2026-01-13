# Flutter 웹/앱 학습 목록

> 목표: Flutter 앱 개발 → 카톨릭 기도앱 제작

---

## AI 학습 가이드

### 역할
- AI는 이 커리큘럼으로 학습을 시켜주는 **시니어 개발자 튜터**
- 사용자는 프론트엔드 + Node.js 백엔드 6년 경험자

### 학습 진행 흐름

**1단계: 진행도 확인**
```
사용자: "오늘 어디 할 차례야"
AI: 이 파일을 읽고 체크 안 된 [ ] 첫 번째 항목을 찾음
AI: "STEP X의 'OOO' 시작합니다"
```

**2단계: 학습 내용 설명**
```
사용자: "학습 내용 보여줘"
AI: 해당 섹션의 doc 파일에서 그 항목 하나만 설명
    (섹션 전체가 아니라 해당 항목만!)
```

**3단계: 예제 코드 제공**
```
사용자: "예제 코드 보여줘"
AI: 해당 섹션의 examples/ 폴더에서 관련 코드를 보여줌
    사용자가 직접 타이핑할 수 있도록 코드 제시
```

**4단계: 완료 처리**
```
사용자: "완료" 또는 다음 항목 요청
AI: 해당 항목의 체크박스를 [x]로 업데이트
AI: 다음 항목으로 넘어감
```

### AI 행동 규칙

**해야 할 것**
- 항목 **하나씩** 진행 (step by step)
- 간단명료하게 설명
- 실행 가능한 예제 코드 제공
- 실무에서 어떻게 쓰이는지 한 줄 설명
- JavaScript/React와 비교 설명 (필요시)

**하지 말아야 할 것**
- 한 번에 여러 항목 설명
- 섹션 전체 내용을 한 번에 설명
- 너무 긴 설명
- 사용자가 요청하지 않은 내용 추가

### 파일 구조
```
chapters/
├── chapter01/
│   ├── chapter01.md      ← doc (개념 설명)
│   └── examples/         ← 예제 코드
├── chapter02/
│   ├── chapter02.md
│   └── examples/
└── ...
```

### 진행도 추적
- `[ ]` = 미완료
- `[x]` = 완료
- 체크 안 된 첫 번째 항목 = 현재 학습할 내용

---

## STEP 1. Dart 기초 문법
> **doc**: `chapters/chapter01/chapter01.md`
> **examples**: `chapters/chapter01/examples/`

### 변수와 타입
- [ ] 변수 선언 (var, final, const)
- [ ] 기본 타입 (int, double, String, bool)
- [ ] 타입 추론
- [ ] Null Safety (?. ?? !)
- [ ] late 키워드

### 컬렉션
- [ ] List
- [ ] Map
- [ ] Set
- [ ] 스프레드 연산자 (...)

### 연산자
- [ ] 산술 연산자
- [ ] 비교 연산자
- [ ] 논리 연산자
- [ ] 삼항 연산자
- [ ] ?? 연산자 (null 병합)
- [ ] ?. 연산자 (null 조건)

### 조건문과 반복문
- [ ] if / else
- [ ] switch
- [ ] for / for-in
- [ ] while
- [ ] break / continue

### 함수
- [ ] 함수 선언
- [ ] 매개변수 (required, optional, named)
- [ ] 화살표 함수 (=>)
- [ ] 익명 함수

---

## STEP 2. Dart 객체지향
> **doc**: `chapters/chapter02/chapter02.md`
> **examples**: `chapters/chapter02/examples/`

### 클래스
- [ ] 클래스 선언
- [ ] 생성자
- [ ] named 생성자
- [ ] factory 생성자
- [ ] 필드와 메소드
- [ ] Getter / Setter
- [ ] private (_)

### 상속과 인터페이스
- [ ] extends (상속)
- [ ] implements (인터페이스)
- [ ] abstract class
- [ ] mixin (with)
- [ ] @override

---

## STEP 3. Dart 비동기
> **doc**: `chapters/chapter03/chapter03.md`
> **examples**: `chapters/chapter03/examples/`

### Future
- [ ] Future 개념
- [ ] async / await
- [ ] then / catchError
- [ ] Future.wait

### Stream
- [ ] Stream 개념
- [ ] StreamBuilder
- [ ] async* / yield

---

## STEP 4. Flutter 기초
> **doc**: `chapters/chapter04/chapter04.md`
> **examples**: `chapters/chapter04/examples/`

### 프로젝트 구조
- [ ] Flutter 설치
- [ ] 프로젝트 생성
- [ ] 폴더 구조 이해
- [ ] main.dart / MaterialApp / Scaffold

### Widget 기초
- [ ] Widget 개념
- [ ] StatelessWidget
- [ ] StatefulWidget
- [ ] setState()
- [ ] BuildContext

### 기본 Widget
- [ ] Text
- [ ] Container
- [ ] Row / Column
- [ ] Stack
- [ ] Expanded / Flexible
- [ ] SizedBox
- [ ] Padding / Margin

---

## STEP 5. Flutter 레이아웃
> **doc**: `chapters/chapter05/chapter05.md`
> **examples**: `chapters/chapter05/examples/`

### 레이아웃 Widget
- [ ] ListView
- [ ] GridView
- [ ] SingleChildScrollView
- [ ] CustomScrollView / Sliver

### 입력 Widget
- [ ] TextField
- [ ] Button (ElevatedButton, TextButton, IconButton)
- [ ] Checkbox / Radio / Switch
- [ ] Form / TextFormField / validation

### 표시 Widget
- [ ] Image
- [ ] Icon
- [ ] Card
- [ ] ListTile
- [ ] AppBar
- [ ] BottomNavigationBar
- [ ] Drawer

---

## STEP 6. Flutter 네비게이션
> **doc**: `chapters/chapter06/chapter06.md`
> **examples**: `chapters/chapter06/examples/`

### 화면 이동
- [ ] Navigator.push / pop
- [ ] Named Routes
- [ ] 데이터 전달 (arguments)
- [ ] Go Router (선택)

---

## STEP 7. Flutter 상태 관리
> **doc**: `chapters/chapter07/chapter07.md`
> **examples**: `chapters/chapter07/examples/`

### 기본
- [ ] setState
- [ ] InheritedWidget

### 상태 관리 라이브러리 (택 1)
- [ ] Provider
- [ ] Riverpod
- [ ] GetX
- [ ] Bloc

---

## STEP 8. API 통신
> **doc**: `chapters/chapter08/chapter08.md`
> **examples**: `chapters/chapter08/examples/`

### HTTP 통신
- [ ] http 패키지
- [ ] dio 패키지
- [ ] GET / POST / PUT / DELETE
- [ ] JSON 파싱
- [ ] 모델 클래스 생성

### 로컬 저장
- [ ] SharedPreferences
- [ ] SQLite (sqflite)
- [ ] Hive

---

## STEP 9. 실무 기능
> **doc**: `chapters/chapter09/chapter09.md`
> **examples**: `chapters/chapter09/examples/`

### 인증
- [ ] JWT 토큰 저장
- [ ] 토큰 자동 갱신
- [ ] 로그인 상태 유지

### 푸시 알림
- [ ] Firebase Cloud Messaging (FCM)
- [ ] 로컬 알림

### 기타
- [ ] 이미지 처리
- [ ] 권한 요청 (permission_handler)
- [ ] 앱 배포 (Android/iOS)

---

## STEP 10. 실전 프로젝트

> 카톨릭 기도앱

---

## 나중에 필요할 때

| 주제 | 언제 |
|------|------|
| 애니메이션 | UI 효과 필요할 때 |
| Custom Painter | 커스텀 그래픽 필요할 때 |
| Platform Channel | 네이티브 기능 연동할 때 |
| WebSocket | 실시간 기능 만들 때 |
| 테스트 | 앱 안정화할 때 |
