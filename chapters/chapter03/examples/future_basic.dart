// STEP 3-1 ~ 3-4: Future 기본, async/await

void main() async {
  // ========================================
  // 3-1. Future 개념
  // ========================================

  print('=== Future 개념 ===');

  // 기본 Future 생성
  print('Creating future...');

  Future<String> simpleFuture = Future(() {
    print('Future is running...');
    return 'Future completed!';
  });

  print('Future created, waiting...');

  String result = await simpleFuture;
  print('Result: $result');

  // Future.delayed - 지연 실행
  print('\nDelayed future:');
  String delayed = await Future.delayed(
    Duration(seconds: 1),
    () => 'Delayed result',
  );
  print('Delayed: $delayed');

  // Future.value - 즉시 완료되는 Future
  String immediate = await Future.value('Immediate');
  print('Immediate: $immediate');

  // Future.error - 에러 Future
  try {
    await Future.error('Something went wrong');
  } catch (e) {
    print('Caught error: $e');
  }

  // ========================================
  // 3-2. async / await
  // ========================================

  print('\n=== async / await ===');

  // 순차 실행
  print('Sequential execution:');
  var user = await fetchUser();
  print('Fetched user: $user');

  var posts = await fetchPosts(user);
  print('Fetched posts: $posts');

  // 함수에서 사용
  print('\nCalling async function:');
  var data = await processUserData();
  print('Processed data: $data');

  // ========================================
  // 3-3. then / catchError
  // ========================================

  print('\n=== then / catchError ===');

  // 체이닝 방식
  print('Chaining with then:');
  await fetchUser()
      .then((user) {
        print('then: Got user $user');
        return fetchPosts(user);
      })
      .then((posts) {
        print('then: Got posts $posts');
      })
      .catchError((error) {
        print('catchError: $error');
      })
      .whenComplete(() {
        print('whenComplete: Done!');
      });

  // 에러 처리
  print('\nError handling:');
  try {
    await fetchWithError();
  } catch (e) {
    print('Caught: $e');
  }

  // then/catchError 방식
  await fetchWithError()
      .then((value) => print('Success: $value'))
      .catchError((error) => print('Error: $error'));

  // ========================================
  // 3-4. Future.wait
  // ========================================

  print('\n=== Future.wait ===');

  // 순차 실행 (느림)
  print('Sequential (slow):');
  var start = DateTime.now();

  var result1 = await slowOperation('A', 1);
  var result2 = await slowOperation('B', 1);
  var result3 = await slowOperation('C', 1);

  print('Results: $result1, $result2, $result3');
  print('Time: ${DateTime.now().difference(start).inSeconds}s');

  // 병렬 실행 (빠름)
  print('\nParallel (fast):');
  start = DateTime.now();

  var results = await Future.wait([
    slowOperation('A', 1),
    slowOperation('B', 1),
    slowOperation('C', 1),
  ]);

  print('Results: ${results.join(", ")}');
  print('Time: ${DateTime.now().difference(start).inSeconds}s');

  // 병렬 실행 with 에러 처리
  print('\nParallel with error handling:');
  try {
    var results = await Future.wait(
      [
        slowOperation('A', 1),
        Future.error('Failed!'),
        slowOperation('C', 1),
      ],
      eagerError: true,  // 첫 번째 에러에서 즉시 실패
    );
    print('Results: $results');
  } catch (e) {
    print('One of the futures failed: $e');
  }

  // Future.any - 가장 먼저 완료되는 것
  print('\nFuture.any:');
  var fastest = await Future.any([
    slowOperation('Slow', 2),
    slowOperation('Fast', 1),
    slowOperation('Medium', 1),
  ]);
  print('Fastest: $fastest');

  // ========================================
  // 실무 패턴: 타임아웃
  // ========================================

  print('\n=== 실무 패턴 ===');

  // 타임아웃 설정
  try {
    var result = await slowOperation('Timeout test', 3)
        .timeout(Duration(seconds: 2));
    print('Result: $result');
  } catch (e) {
    print('Timeout! $e');
  }

  // 재시도 패턴
  print('\nRetry pattern:');
  var retryResult = await retry(() => unreliableOperation(), maxAttempts: 3);
  print('Retry result: $retryResult');
}

// ========================================
// 헬퍼 함수들
// ========================================

Future<String> fetchUser() async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'User123';
}

Future<List<String>> fetchPosts(String userId) async {
  await Future.delayed(Duration(milliseconds: 500));
  return ['Post1', 'Post2', 'Post3'];
}

Future<String> processUserData() async {
  var user = await fetchUser();
  var posts = await fetchPosts(user);
  return 'Processed: $user with ${posts.length} posts';
}

Future<String> fetchWithError() async {
  await Future.delayed(Duration(milliseconds: 100));
  throw Exception('Network error');
}

Future<String> slowOperation(String name, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return 'Result-$name';
}

int _attemptCount = 0;

Future<String> unreliableOperation() async {
  _attemptCount++;
  await Future.delayed(Duration(milliseconds: 100));

  if (_attemptCount < 3) {
    print('  Attempt $_attemptCount failed');
    throw Exception('Random failure');
  }

  print('  Attempt $_attemptCount succeeded');
  _attemptCount = 0;  // Reset for next call
  return 'Success!';
}

Future<T> retry<T>(
  Future<T> Function() operation, {
  int maxAttempts = 3,
  Duration delay = const Duration(milliseconds: 500),
}) async {
  int attempts = 0;

  while (attempts < maxAttempts) {
    try {
      return await operation();
    } catch (e) {
      attempts++;
      if (attempts >= maxAttempts) {
        rethrow;
      }
      await Future.delayed(delay);
    }
  }

  throw Exception('Max attempts reached');
}
