# STEP 4. Flutter 기초

> React 컴포넌트 경험자를 위한 Flutter 위젯 - 선언적 UI의 새로운 접근

---

## 학습 목표
- Flutter 프로젝트 구조 이해
- Widget 개념과 생명주기
- StatelessWidget vs StatefulWidget
- 기본 위젯 활용

---

## 4-1. Flutter 설치

### 핵심 개념

```bash
# macOS (Homebrew)
brew install --cask flutter

# 설치 확인
flutter doctor

# 필요한 도구 설치
flutter doctor --android-licenses
```

### 필요한 도구
- Flutter SDK
- Android Studio (Android 개발)
- Xcode (iOS 개발, macOS만)
- VS Code + Flutter 확장

---

## 4-2. 프로젝트 생성

### 핵심 개념

```bash
# 새 프로젝트 생성
flutter create my_app

# 실행
cd my_app
flutter run

# 특정 플랫폼 지정
flutter run -d chrome  # 웹
flutter run -d ios     # iOS 시뮬레이터
```

---

## 4-3. 폴더 구조 이해

### 핵심 개념

```
my_app/
├── lib/                  # Dart 소스 코드
│   └── main.dart         # 앱 진입점
├── test/                 # 테스트 코드
├── android/              # Android 네이티브 코드
├── ios/                  # iOS 네이티브 코드
├── web/                  # 웹 설정
├── pubspec.yaml          # 패키지 의존성 (package.json과 유사)
└── pubspec.lock          # 버전 잠금
```

### pubspec.yaml
```yaml
name: my_app
description: A new Flutter project.

dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0          # 외부 패키지

dev_dependencies:
  flutter_test:
    sdk: flutter
```

### React와 비교
| React | Flutter |
|-------|---------|
| `package.json` | `pubspec.yaml` |
| `npm install` | `flutter pub get` |
| `node_modules/` | `.dart_tool/` |
| `src/` | `lib/` |

---

## 4-4. main.dart / MaterialApp / Scaffold

### 핵심 개념

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Hello, Flutter!'),
      ),
    );
  }
}
```

### 구성 요소
| 요소 | 역할 |
|------|------|
| `main()` | 앱 진입점 |
| `runApp()` | 위젯 트리 시작 |
| `MaterialApp` | Material Design 앱 설정 |
| `Scaffold` | 기본 페이지 레이아웃 |

---

## 4-5. Widget 개념

### 핵심 개념

Flutter에서 모든 것은 Widget:

```dart
// UI 요소 = Widget
Text('Hello')           // 텍스트
Container()             // div와 유사
Row()                   // 가로 배치
Column()                // 세로 배치
```

### Widget 트리
```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text
    └── Body
        └── Center
            └── Text
```

### React와 비교
| React | Flutter |
|-------|---------|
| Component | Widget |
| `<div>` | `Container` |
| `<span>` | `Text` |
| Props | 생성자 매개변수 |
| `children` | `child` / `children` |

---

## 4-6. StatelessWidget

### 핵심 개념

상태가 없는 정적 위젯:

```dart
class Greeting extends StatelessWidget {
  final String name;

  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name!');
  }
}

// 사용
Greeting(name: 'Flutter')
```

### 언제 사용?
- 정적 UI (변하지 않는 화면)
- 순수 표시 컴포넌트
- 부모에서 받은 데이터만 표시

### React와 비교
```jsx
// React 함수형 컴포넌트와 유사
function Greeting({ name }) {
  return <span>Hello, {name}!</span>;
}
```

---

## 4-7. StatefulWidget

### 핵심 개념

상태가 있는 동적 위젯:

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### 언제 사용?
- 사용자 입력 처리
- 내부 상태 관리
- 애니메이션

---

## 4-8. setState()

### 핵심 개념

상태 변경을 Flutter에 알림:

```dart
// 올바른 사용
setState(() {
  _count++;
});

// 잘못된 사용 - UI 업데이트 안됨!
_count++;
```

### 주의사항
```dart
// 비동기 작업에서 주의
void _loadData() async {
  final data = await fetchData();

  // 위젯이 여전히 마운트되어 있는지 확인
  if (mounted) {
    setState(() {
      _data = data;
    });
  }
}
```

### React와 비교
| React | Flutter |
|-------|---------|
| `setState({ count: 1 })` | `setState(() { _count = 1; })` |
| `useState` | `StatefulWidget` + `_state` |

---

## 4-9. BuildContext

### 핵심 개념

위젯 트리에서의 위치 정보:

```dart
@override
Widget build(BuildContext context) {
  // 테마 접근
  final theme = Theme.of(context);

  // MediaQuery 접근
  final size = MediaQuery.of(context).size;

  // Navigator 접근
  Navigator.of(context).push(...);

  // SnackBar 표시
  ScaffoldMessenger.of(context).showSnackBar(...);

  return Container();
}
```

### 실무 포인트
> `of(context)` 패턴으로 상위 위젯의 데이터에 접근. React의 Context와 유사

---

## 4-10. Text

### 핵심 개념

```dart
// 기본 텍스트
Text('Hello, Flutter!')

// 스타일 적용
Text(
  'Styled Text',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)

// 테마 스타일 사용
Text(
  'Theme Style',
  style: Theme.of(context).textTheme.headlineMedium,
)

// 여러 줄 처리
Text(
  'Long text...',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

---

## 4-11. Container

### 핵심 개념

HTML의 `<div>`와 유사한 범용 컨테이너:

```dart
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Text('Content'),
)
```

---

## 4-12. Row / Column

### 핵심 개념

```dart
// 가로 배치
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text('Left'),
    Text('Center'),
    Text('Right'),
  ],
)

// 세로 배치
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text('Top'),
    Text('Middle'),
    Text('Bottom'),
  ],
)
```

### CSS Flexbox와 비교
| CSS | Flutter |
|-----|---------|
| `flex-direction: row` | `Row` |
| `flex-direction: column` | `Column` |
| `justify-content` | `mainAxisAlignment` |
| `align-items` | `crossAxisAlignment` |

---

## 4-13. Stack

### 핵심 개념

위젯을 겹쳐서 배치:

```dart
Stack(
  children: [
    // 배경 (가장 아래)
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    // 전경 (위에 겹침)
    Positioned(
      top: 10,
      right: 10,
      child: Icon(Icons.star, color: Colors.white),
    ),
  ],
)
```

### CSS와 비교
| CSS | Flutter |
|-----|---------|
| `position: absolute` | `Positioned` |
| `z-index` | children 순서 |

---

## 4-14. Expanded / Flexible

### 핵심 개념

```dart
Row(
  children: [
    // 고정 크기
    Container(width: 100, color: Colors.red),

    // 남은 공간 채움
    Expanded(
      child: Container(color: Colors.green),
    ),

    // 비율로 공간 분배
    Flexible(
      flex: 2,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

### Expanded vs Flexible
| Expanded | Flexible |
|----------|----------|
| 남은 공간 전부 | 필요한 만큼만 |
| `flex: 1` 기본 | `flex` 비율 지정 |

---

## 4-15. SizedBox

### 핵심 개념

고정 크기 또는 간격:

```dart
// 고정 크기 박스
SizedBox(
  width: 100,
  height: 50,
  child: Container(color: Colors.blue),
)

// 간격으로 사용
Column(
  children: [
    Text('First'),
    SizedBox(height: 16),  // 16픽셀 간격
    Text('Second'),
  ],
)

// 무한 확장
SizedBox.expand(
  child: Container(color: Colors.blue),
)
```

---

## 4-16. Padding / Margin

### 핵심 개념

```dart
// Padding 위젯
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Padded'),
)

// Container에서 padding/margin
Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  margin: EdgeInsets.only(top: 20),
  child: Text('Content'),
)

// EdgeInsets 종류
EdgeInsets.all(16)                    // 모든 방향
EdgeInsets.symmetric(horizontal: 16)  // 좌우
EdgeInsets.only(left: 8, top: 16)    // 특정 방향
EdgeInsets.fromLTRB(8, 16, 8, 16)    // 각각 지정
```

---

## 예제 파일
- `examples/basic_app.dart` - 기본 앱 구조
- `examples/stateful_example.dart` - StatefulWidget 예제
- `examples/layout_widgets.dart` - 레이아웃 위젯 예제

---

## 다음 단계
→ STEP 5: Flutter 레이아웃 (ListView, GridView, Form)
