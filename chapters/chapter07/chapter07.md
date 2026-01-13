# STEP 7. Flutter 상태 관리

> React의 Redux/Context 경험자를 위한 Flutter 상태 관리

---

## 학습 목표
- setState의 한계 이해
- InheritedWidget 개념
- 상태 관리 라이브러리 활용 (Provider 중심)

---

## 7-1. setState

### 핵심 개념

지역 상태 관리:

```dart
class Counter extends StatefulWidget {
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
    return Text('Count: $_count');
  }
}
```

### 한계
- 위젯 간 상태 공유 어려움
- prop drilling 발생
- 큰 앱에서 관리 복잡

---

## 7-2. InheritedWidget

### 핵심 개념

위젯 트리를 통한 데이터 전파:

```dart
class ThemeProvider extends InheritedWidget {
  final Color color;

  const ThemeProvider({
    required this.color,
    required Widget child,
  }) : super(child: child);

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return color != oldWidget.color;
  }
}

// 사용
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    return Container(color: theme.color);
  }
}
```

### 실무 포인트
> InheritedWidget은 Provider/Riverpod의 기반. 직접 사용보다 라이브러리 활용 권장

---

## 7-3. Provider

### 핵심 개념

가장 많이 사용되는 상태 관리:

```yaml
dependencies:
  provider: ^6.0.0
```

```dart
// 상태 클래스
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();  // UI 업데이트
  }
}

// 제공
ChangeNotifierProvider(
  create: (context) => Counter(),
  child: MyApp(),
)

// 사용
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<Counter>();

    return Column(
      children: [
        Text('Count: ${counter.count}'),
        ElevatedButton(
          onPressed: () => context.read<Counter>().increment(),
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

### watch vs read
| `context.watch<T>()` | `context.read<T>()` |
|----------------------|---------------------|
| 상태 변경 시 리빌드 | 리빌드 안함 |
| UI에서 값 표시할 때 | 메서드 호출할 때 |

---

## 7-4. Riverpod

### 핵심 개념

Provider의 진화된 버전:

```yaml
dependencies:
  flutter_riverpod: ^2.0.0
```

```dart
// Provider 정의 (전역)
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
}

// 앱 감싸기
ProviderScope(
  child: MyApp(),
)

// 사용 (ConsumerWidget)
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

---

## 7-5. GetX

### 핵심 개념

간단한 반응형 상태 관리:

```yaml
dependencies:
  get: ^4.6.0
```

```dart
// 컨트롤러
class CounterController extends GetxController {
  var count = 0.obs;  // .obs로 반응형

  void increment() => count++;
}

// 사용
class MyWidget extends StatelessWidget {
  final controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('Count: ${controller.count}'));
  }
}
```

---

## 7-6. Bloc

### 핵심 개념

이벤트 기반 상태 관리:

```yaml
dependencies:
  flutter_bloc: ^8.0.0
```

```dart
// Events
abstract class CounterEvent {}
class IncrementEvent extends CounterEvent {}

// Bloc
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) {
      emit(state + 1);
    });
  }
}

// 사용
BlocBuilder<CounterBloc, int>(
  builder: (context, count) {
    return Text('Count: $count');
  },
)
```

---

## 라이브러리 비교

| 라이브러리 | 복잡도 | 특징 |
|-----------|-------|------|
| Provider | 낮음 | 쉬운 학습곡선, 범용적 |
| Riverpod | 중간 | 컴파일 안전, 테스트 용이 |
| GetX | 낮음 | 간단, 라우팅 포함 |
| Bloc | 높음 | 엔터프라이즈급, 예측 가능 |

### 추천
- 입문: **Provider**
- 중급+: **Riverpod**
- 대규모: **Bloc**

---

## 예제 파일
- `examples/provider_example.dart` - Provider 기본
- `examples/counter_provider.dart` - 카운터 예제

---

## 다음 단계
→ STEP 8: API 통신 (HTTP, JSON 파싱)
