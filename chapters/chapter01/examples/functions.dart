// STEP 1-21 ~ 1-24: 함수

void main() {
  // ========================================
  // 1-21. 함수 선언
  // ========================================

  print('=== 함수 선언 ===');

  // 기본 함수 호출
  int result = add(3, 5);
  print('add(3, 5) = $result');

  // void 함수
  greet('Flutter');

  // 반환값 있는 함수
  String message = getMessage();
  print(message);

  // ========================================
  // 1-22. 매개변수
  // ========================================

  print('\n=== 매개변수 ===');

  // Required 매개변수
  print('Required: ${multiply(3, 4)}');

  // Optional positional 매개변수
  print('Optional positional:');
  sayHello('Kim');          // 안녕하세요, Kim!
  sayHello('Lee', 'Mr.');   // 안녕하세요, Mr. Lee!

  // Named 매개변수 (Flutter에서 가장 많이 사용!)
  print('Named:');
  createUser(name: 'Kim', age: 30);
  createUser(name: 'Lee');  // age는 기본값 0

  // Required named 매개변수
  sendEmail(to: 'user@example.com', subject: 'Hello');

  // 혼합 사용
  print('Mixed:');
  mixed('first', named1: 'A', named2: 'B');

  // ========================================
  // 1-23. 화살표 함수 (=>)
  // ========================================

  print('\n=== 화살표 함수 ===');

  print('arrowAdd(2, 3) = ${arrowAdd(2, 3)}');
  print('square(5) = ${square(5)}');
  print('isEven(4) = ${isEven(4)}');

  arrowGreet('Dart');

  // ========================================
  // 1-24. 익명 함수
  // ========================================

  print('\n=== 익명 함수 ===');

  // 변수에 할당
  var multiplyFunc = (int a, int b) {
    return a * b;
  };
  print('multiplyFunc(3, 4) = ${multiplyFunc(3, 4)}');

  // 화살표 형태
  var addFunc = (int a, int b) => a + b;
  print('addFunc(5, 6) = ${addFunc(5, 6)}');

  // 콜백으로 사용
  var numbers = [1, 2, 3, 4, 5];

  print('forEach with anonymous function:');
  numbers.forEach((number) {
    print('  $number');
  });

  print('forEach with arrow function:');
  numbers.forEach((n) => print('  squared: ${n * n}'));

  // map, where, reduce
  var doubled = numbers.map((n) => n * 2).toList();
  print('Doubled: $doubled');

  var evens = numbers.where((n) => n % 2 == 0).toList();
  print('Evens: $evens');

  var sum = numbers.reduce((acc, n) => acc + n);
  print('Sum: $sum');

  // 즉시 실행 함수 (IIFE)
  var result2 = (() {
    var x = 10;
    var y = 20;
    return x + y;
  })();
  print('IIFE result: $result2');

  // ========================================
  // 고급: 함수를 매개변수로 전달
  // ========================================

  print('\n=== 고차 함수 ===');

  // 함수를 인자로 받는 함수
  processNumbers([1, 2, 3, 4, 5], (n) => print('  Processed: $n'));

  // 커스텀 필터
  var filtered = customFilter([1, 2, 3, 4, 5], (n) => n > 2);
  print('Filtered (> 2): $filtered');

  // ========================================
  // 고급: 클로저
  // ========================================

  print('\n=== 클로저 ===');

  var counter = createCounter();
  print('Count: ${counter()}');  // 1
  print('Count: ${counter()}');  // 2
  print('Count: ${counter()}');  // 3

  var multiplier = createMultiplier(3);
  print('multiplier(5) = ${multiplier(5)}');  // 15
  print('multiplier(10) = ${multiplier(10)}'); // 30
}

// ========================================
// 1-21. 함수 선언 예제
// ========================================

// 기본 함수
int add(int a, int b) {
  return a + b;
}

// void 함수
void greet(String name) {
  print('Hello, $name!');
}

// 반환값 있는 함수
String getMessage() {
  return 'This is a message';
}

// ========================================
// 1-22. 매개변수 예제
// ========================================

// Required 매개변수
int multiply(int a, int b) {
  return a * b;
}

// Optional positional 매개변수 (대괄호 사용)
void sayHello(String name, [String? title]) {
  if (title != null) {
    print('안녕하세요, $title $name!');
  } else {
    print('안녕하세요, $name!');
  }
}

// Named 매개변수 (중괄호 사용)
void createUser({required String name, int age = 0}) {
  print('User: $name, Age: $age');
}

// Required named 매개변수
void sendEmail({required String to, required String subject}) {
  print('Sending email to $to with subject: $subject');
}

// 혼합 사용
void mixed(String positional, {String? named1, String? named2}) {
  print('positional: $positional, named1: $named1, named2: $named2');
}

// ========================================
// 1-23. 화살표 함수 예제
// ========================================

int arrowAdd(int a, int b) => a + b;

int square(int n) => n * n;

bool isEven(int n) => n % 2 == 0;

void arrowGreet(String name) => print('Arrow hello, $name!');

// ========================================
// 고급: 고차 함수
// ========================================

void processNumbers(List<int> numbers, void Function(int) processor) {
  for (var n in numbers) {
    processor(n);
  }
}

List<int> customFilter(List<int> numbers, bool Function(int) predicate) {
  return numbers.where(predicate).toList();
}

// ========================================
// 고급: 클로저
// ========================================

Function createCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

Function createMultiplier(int factor) {
  return (int n) => n * factor;
}
