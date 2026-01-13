# STEP 6. Flutter 네비게이션

> React Router 경험자를 위한 Flutter 화면 이동 - Navigator와 라우팅

---

## 학습 목표
- Navigator로 화면 이동 구현
- Named Routes 설정
- 화면 간 데이터 전달

---

## 6-1. Navigator.push / pop

### 핵심 개념

```dart
// 새 화면으로 이동
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailPage()),
);

// 이전 화면으로 돌아가기
Navigator.pop(context);

// 돌아가면서 데이터 전달
Navigator.pop(context, 'result data');
```

### 결과 받기
```dart
// push하고 결과 대기
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SelectionPage()),
);

if (result != null) {
  print('Selected: $result');
}
```

### React와 비교
| React Router | Flutter |
|--------------|---------|
| `navigate('/detail')` | `Navigator.push(...)` |
| `navigate(-1)` | `Navigator.pop(context)` |

---

## 6-2. Named Routes

### 핵심 개념

MaterialApp에서 라우트 정의:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomePage(),
    '/detail': (context) => DetailPage(),
    '/settings': (context) => SettingsPage(),
  },
)
```

### 사용
```dart
// Named route로 이동
Navigator.pushNamed(context, '/detail');

// 현재 화면 교체
Navigator.pushReplacementNamed(context, '/home');

// 모든 화면 제거하고 이동
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  (route) => false,  // 모든 라우트 제거
);
```

---

## 6-3. 데이터 전달 (arguments)

### 핵심 개념

```dart
// 데이터와 함께 이동
Navigator.pushNamed(
  context,
  '/detail',
  arguments: {'id': 123, 'title': 'Post Title'},
);

// 받는 쪽에서 추출
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text(args['title'])),
      body: Text('ID: ${args['id']}'),
    );
  }
}
```

### 타입 안전하게
```dart
// 클래스로 정의
class DetailArguments {
  final int id;
  final String title;

  DetailArguments({required this.id, required this.title});
}

// 전달
Navigator.pushNamed(
  context,
  '/detail',
  arguments: DetailArguments(id: 123, title: 'Post'),
);

// 수신
final args = ModalRoute.of(context)!.settings.arguments as DetailArguments;
```

---

## 6-4. Go Router (선택)

### 핵심 개념

선언적 라우팅 라이브러리:

```yaml
# pubspec.yaml
dependencies:
  go_router: ^12.0.0
```

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return DetailPage(id: id!);
      },
    ),
  ],
);

// MaterialApp.router 사용
MaterialApp.router(
  routerConfig: router,
)

// 이동
context.go('/detail/123');
context.push('/detail/123');
```

### React Router와 비교
| React Router | Go Router |
|--------------|-----------|
| `<Route path="/user/:id">` | `GoRoute(path: '/user/:id')` |
| `useParams()` | `state.pathParameters['id']` |
| `navigate('/path')` | `context.go('/path')` |

---

## 예제 파일
- `examples/navigator_basic.dart` - push/pop 기본
- `examples/named_routes.dart` - Named Routes 예제

---

## 다음 단계
→ STEP 7: Flutter 상태 관리 (Provider, Riverpod)
