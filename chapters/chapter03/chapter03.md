# STEP 3. Dart 비동기

> JavaScript Promise/async-await 경험자를 위한 Dart 비동기 - Future와 Stream

---

## 학습 목표
- Future와 async/await 패턴 이해
- Stream을 활용한 연속 데이터 처리
- 에러 핸들링과 병렬 처리

---

## 3-1. Future 개념

### 핵심 개념

Future는 나중에 완료될 비동기 작업의 결과를 나타냄:

```dart
// Future 생성
Future<String> fetchData() {
  return Future.delayed(
    Duration(seconds: 2),
    () => 'Data loaded!',
  );
}

// Future 사용
void main() {
  print('Fetching...');
  fetchData().then((data) {
    print(data);  // 2초 후: Data loaded!
  });
  print('Continuing...');  // 즉시 실행
}
```

### JavaScript Promise와 비교
| JavaScript | Dart |
|------------|------|
| `Promise<T>` | `Future<T>` |
| `new Promise((resolve, reject) => {})` | `Future(() => {})` |
| `Promise.resolve(value)` | `Future.value(value)` |
| `Promise.reject(error)` | `Future.error(error)` |

### 실무 포인트
> API 호출, 파일 읽기, 데이터베이스 쿼리 등 시간이 걸리는 작업에 사용

---

## 3-2. async / await

### 핵심 개념

비동기 코드를 동기처럼 작성:

```dart
// async 함수
Future<String> fetchUserData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'User data';
}

// await 사용
void main() async {
  print('Start');

  String data = await fetchUserData();  // 1초 대기
  print(data);

  print('End');
}
```

### 여러 비동기 작업 순차 실행
```dart
Future<void> processData() async {
  var user = await fetchUser();
  var posts = await fetchPosts(user.id);  // user 필요
  var comments = await fetchComments(posts[0].id);  // posts 필요

  print('All done!');
}
```

### JavaScript와 동일한 패턴
```javascript
// JavaScript
async function fetchData() {
  const data = await fetch('/api/data');
  return data.json();
}
```

---

## 3-3. then / catchError

### 핵심 개념

콜백 방식의 비동기 처리:

```dart
fetchData()
    .then((data) {
      print('Success: $data');
      return processData(data);  // 체이닝
    })
    .then((result) {
      print('Processed: $result');
    })
    .catchError((error) {
      print('Error: $error');
    })
    .whenComplete(() {
      print('Always runs');  // finally와 유사
    });
```

### async/await로 변환
```dart
try {
  var data = await fetchData();
  print('Success: $data');

  var result = await processData(data);
  print('Processed: $result');
} catch (error) {
  print('Error: $error');
} finally {
  print('Always runs');
}
```

### 실무 포인트
> `async/await`가 가독성이 좋아 권장됨. `then`은 간단한 체이닝에 사용

---

## 3-4. Future.wait

### 핵심 개념

여러 Future를 병렬로 실행하고 모두 완료될 때까지 대기:

```dart
Future<void> loadAllData() async {
  // 병렬 실행 - 훨씬 빠름!
  var results = await Future.wait([
    fetchUser(),
    fetchPosts(),
    fetchSettings(),
  ]);

  print('User: ${results[0]}');
  print('Posts: ${results[1]}');
  print('Settings: ${results[2]}');
}
```

### 타입 보존하기
```dart
Future<void> loadData() async {
  var (user, posts, settings) = await (
    fetchUser(),      // Future<User>
    fetchPosts(),     // Future<List<Post>>
    fetchSettings(),  // Future<Settings>
  ).wait;

  // user, posts, settings 각각 타입 유지
}
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `Promise.all([...])` | `Future.wait([...])` |
| `Promise.any([...])` | `Future.any([...])` |
| `Promise.race([...])` | - (직접 구현) |

---

## 3-5. Stream 개념

### 핵심 개념

Stream은 시간에 따라 여러 값을 방출하는 비동기 시퀀스:

```dart
// Stream 생성
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;  // 값 방출
  }
}

// Stream 구독
void main() async {
  await for (var count in countStream()) {
    print('Count: $count');  // 1초마다 출력
  }
}
```

### Future vs Stream
| Future | Stream |
|--------|--------|
| 하나의 값 | 여러 값 |
| 한 번 완료 | 계속 방출 가능 |
| API 호출 | WebSocket, 이벤트 |

### 실무 포인트
> 실시간 데이터 (채팅, 알림), 사용자 입력 이벤트, 파일 읽기 등에 사용

---

## 3-6. StreamBuilder

### 핵심 개념

Flutter에서 Stream을 UI에 연결:

```dart
StreamBuilder<int>(
  stream: countStream(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    return Text('Count: ${snapshot.data}');
  },
)
```

### snapshot 상태
```dart
snapshot.connectionState  // none, waiting, active, done
snapshot.hasData          // 데이터 있음
snapshot.hasError         // 에러 발생
snapshot.data             // 실제 데이터
snapshot.error            // 에러 객체
```

---

## 3-7. async* / yield

### 핵심 개념

Generator 함수로 Stream 생성:

```dart
// async* - 비동기 Generator (Stream 반환)
Stream<String> fetchMessages() async* {
  yield 'First message';
  await Future.delayed(Duration(seconds: 1));
  yield 'Second message';
  await Future.delayed(Duration(seconds: 1));
  yield 'Third message';
}

// yield* - 다른 Stream 연결
Stream<int> combinedStream() async* {
  yield* Stream.fromIterable([1, 2, 3]);
  yield* anotherStream();
}
```

### sync* - 동기 Generator (Iterable 반환)
```dart
Iterable<int> naturals(int n) sync* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}

void main() {
  for (var n in naturals(5)) {
    print(n);  // 0, 1, 2, 3, 4
  }
}
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `function*` | `sync*` |
| `async function*` | `async*` |
| `yield` | `yield` |
| `yield*` | `yield*` |

---

## Stream 추가 메서드

### 자주 사용하는 Stream 변환
```dart
stream
    .where((event) => event > 0)      // filter
    .map((event) => event * 2)        // transform
    .take(5)                          // 처음 5개만
    .skip(2)                          // 처음 2개 스킵
    .distinct()                       // 중복 제거
    .debounce(Duration(milliseconds: 300))  // 디바운스
    .listen((event) {                 // 구독
      print(event);
    });
```

### Stream 생성 방법들
```dart
// 리스트에서 생성
Stream.fromIterable([1, 2, 3, 4, 5]);

// Future에서 생성
Stream.fromFuture(fetchData());

// 주기적 이벤트
Stream.periodic(Duration(seconds: 1), (count) => count);

// 컨트롤러 사용
var controller = StreamController<int>();
controller.add(1);
controller.add(2);
controller.close();
```

---

## 예제 파일
- `examples/future_basic.dart` - Future 기본, async/await
- `examples/stream_basic.dart` - Stream 기본, async*/yield

---

## 다음 단계
→ STEP 4: Flutter 기초 (Widget, StatelessWidget, StatefulWidget)
