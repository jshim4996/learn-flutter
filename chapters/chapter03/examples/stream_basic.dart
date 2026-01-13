// STEP 3-5 ~ 3-7: Stream 기본, async*/yield

import 'dart:async';

void main() async {
  // ========================================
  // 3-5. Stream 개념
  // ========================================

  print('=== Stream 개념 ===');

  // 기본 Stream 생성
  print('Stream from iterable:');
  var stream = Stream.fromIterable([1, 2, 3, 4, 5]);
  await for (var value in stream) {
    print('  Value: $value');
  }

  // Stream.periodic - 주기적 이벤트
  print('\nStream.periodic (3 ticks):');
  var periodicStream = Stream.periodic(
    Duration(milliseconds: 500),
    (count) => count,
  ).take(3);

  await for (var count in periodicStream) {
    print('  Tick: $count');
  }

  // Stream.fromFuture
  print('\nStream.fromFuture:');
  await for (var value in Stream.fromFuture(Future.value('Hello'))) {
    print('  Value: $value');
  }

  // ========================================
  // 3-7. async* / yield
  // ========================================

  print('\n=== async* / yield ===');

  // async* generator
  print('Count stream:');
  await for (var count in countStream(5)) {
    print('  Count: $count');
  }

  // yield* - 다른 Stream 연결
  print('\nCombined stream:');
  await for (var value in combinedStream()) {
    print('  Value: $value');
  }

  // sync* - 동기 Generator (Iterable)
  print('\nSync generator:');
  for (var n in naturals(5)) {
    print('  Natural: $n');
  }

  // Fibonacci 예제
  print('\nFibonacci:');
  for (var fib in fibonacci().take(10)) {
    print('  Fib: $fib');
  }

  // ========================================
  // Stream 구독 방식
  // ========================================

  print('\n=== Stream 구독 ===');

  // listen 메서드
  print('Using listen:');
  var subscription = Stream.fromIterable([1, 2, 3]).listen(
    (value) => print('  onData: $value'),
    onError: (error) => print('  onError: $error'),
    onDone: () => print('  onDone!'),
  );

  await Future.delayed(Duration(milliseconds: 100));

  // 일시정지/재개/취소
  print('\nSubscription control:');
  var controlStream = Stream.periodic(
    Duration(milliseconds: 100),
    (i) => i,
  ).take(5);

  var sub = controlStream.listen((value) {
    print('  Value: $value');
  });

  await Future.delayed(Duration(milliseconds: 250));
  sub.pause();
  print('  Paused...');

  await Future.delayed(Duration(milliseconds: 200));
  sub.resume();
  print('  Resumed...');

  await sub.asFuture();
  print('  Done!');

  // ========================================
  // Stream 변환
  // ========================================

  print('\n=== Stream 변환 ===');

  var numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  print('Transformed stream:');
  await numbers
      .where((n) => n % 2 == 0)  // 짝수만
      .map((n) => n * 2)         // 2배
      .take(3)                    // 처음 3개
      .forEach((n) => print('  $n'));

  // distinct - 중복 제거
  print('\nDistinct:');
  await Stream.fromIterable([1, 1, 2, 2, 3, 3, 2, 1])
      .distinct()
      .forEach((n) => print('  $n'));

  // expand - 하나를 여러 개로
  print('\nExpand:');
  await Stream.fromIterable([1, 2, 3])
      .expand((n) => [n, n * 10])
      .forEach((n) => print('  $n'));

  // ========================================
  // StreamController
  // ========================================

  print('\n=== StreamController ===');

  // 기본 StreamController
  var controller = StreamController<String>();

  controller.stream.listen(
    (data) => print('  Received: $data'),
    onDone: () => print('  Stream closed'),
  );

  controller.add('Hello');
  controller.add('World');
  controller.addError('Oops!');
  await controller.close();

  // Broadcast StreamController
  print('\nBroadcast stream:');
  var broadcast = StreamController<int>.broadcast();

  broadcast.stream.listen((data) => print('  Listener 1: $data'));
  broadcast.stream.listen((data) => print('  Listener 2: $data'));

  broadcast.add(1);
  broadcast.add(2);
  await broadcast.close();

  // ========================================
  // 실무 패턴: 이벤트 시뮬레이션
  // ========================================

  print('\n=== 실무 패턴 ===');

  // 채팅 메시지 시뮬레이션
  print('Chat messages:');
  await for (var message in chatMessages().take(3)) {
    print('  $message');
  }

  // 주식 가격 시뮬레이션
  print('\nStock prices:');
  await for (var price in stockPrices('AAPL').take(3)) {
    print('  AAPL: \$$price');
  }
}

// ========================================
// async* Generator 함수들
// ========================================

// 카운트 Stream
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

// yield* 사용 - 다른 Stream 연결
Stream<String> combinedStream() async* {
  yield 'Start';
  yield* Stream.fromIterable(['A', 'B', 'C']);
  yield 'Middle';
  yield* Stream.fromIterable(['X', 'Y', 'Z']);
  yield 'End';
}

// ========================================
// sync* Generator 함수들
// ========================================

// 자연수 Generator
Iterable<int> naturals(int n) sync* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}

// 피보나치 Generator
Iterable<int> fibonacci() sync* {
  int a = 0, b = 1;
  while (true) {
    yield a;
    var temp = a + b;
    a = b;
    b = temp;
  }
}

// ========================================
// 실무 시뮬레이션
// ========================================

// 채팅 메시지 시뮬레이션
Stream<String> chatMessages() async* {
  var messages = [
    'User1: Hello!',
    'User2: Hi there!',
    'User1: How are you?',
    'User2: Good, thanks!',
  ];

  for (var msg in messages) {
    await Future.delayed(Duration(milliseconds: 500));
    yield msg;
  }
}

// 주식 가격 시뮬레이션
Stream<double> stockPrices(String symbol) async* {
  var price = 150.0;
  var random = DateTime.now().millisecond;

  while (true) {
    await Future.delayed(Duration(seconds: 1));
    // 랜덤 가격 변동
    price += (random % 10 - 5) / 10;
    random = (random * 1103515245 + 12345) % (1 << 31);
    yield double.parse(price.toStringAsFixed(2));
  }
}
