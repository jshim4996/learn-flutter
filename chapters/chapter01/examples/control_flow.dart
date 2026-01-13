// STEP 1-10 ~ 1-20: 연산자와 제어문

void main() {
  // ========================================
  // 1-10. 산술 연산자
  // ========================================

  int a = 10, b = 3;

  print('=== 산술 연산자 ===');
  print('$a + $b = ${a + b}');   // 13
  print('$a - $b = ${a - b}');   // 7
  print('$a * $b = ${a * b}');   // 30
  print('$a / $b = ${a / b}');   // 3.333... (double 반환)
  print('$a ~/ $b = ${a ~/ b}'); // 3 (정수 나눗셈, Dart 전용!)
  print('$a % $b = ${a % b}');   // 1 (나머지)

  // 복합 대입 연산자
  int x = 10;
  x += 5;   // x = x + 5
  x -= 3;   // x = x - 3
  x *= 2;   // x = x * 2
  x ~/= 4;  // x = x ~/ 4
  print('복합 대입 결과: $x');

  // ========================================
  // 1-11. 비교 연산자
  // ========================================

  print('\n=== 비교 연산자 ===');
  print('5 == 5: ${5 == 5}');    // true
  print('5 != 3: ${5 != 3}');    // true
  print('5 > 3: ${5 > 3}');      // true
  print('5 >= 5: ${5 >= 5}');    // true
  print('3 < 5: ${3 < 5}');      // true
  print('3 <= 3: ${3 <= 3}');    // true

  // Dart에서 == 는 타입까지 비교 (JS의 ===와 유사)
  print('1 == 1.0: ${1 == 1.0}');  // true (int와 double 비교)
  // print('1 == "1"');  // 컴파일 에러! 타입이 다르면 비교 불가

  // ========================================
  // 1-12. 논리 연산자
  // ========================================

  print('\n=== 논리 연산자 ===');
  bool t = true, f = false;

  print('true && false: ${t && f}');  // false (AND)
  print('true || false: ${t || f}');  // true (OR)
  print('!true: ${!t}');               // false (NOT)

  // 단락 평가 (Short-circuit evaluation)
  print('false && (expensive): ${f && _expensive()}');  // false, _expensive 호출 안됨
  print('true || (expensive): ${t || _expensive()}');   // true, _expensive 호출 안됨

  // ========================================
  // 1-13. 삼항 연산자
  // ========================================

  print('\n=== 삼항 연산자 ===');
  int age = 20;
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('Age $age: $status');

  // 중첩 사용 (가독성 주의)
  int score = 85;
  String grade = score >= 90
      ? 'A'
      : score >= 80
          ? 'B'
          : score >= 70
              ? 'C'
              : 'F';
  print('Score $score: $grade');

  // ========================================
  // 1-14. ?? 연산자 (null 병합)
  // ========================================

  print('\n=== ?? 연산자 ===');
  String? name;
  print('name ?? "Guest": ${name ?? "Guest"}');

  name = 'Flutter';
  print('name ?? "Guest": ${name ?? "Guest"}');

  // ??= 할당 연산자
  String? nickname;
  nickname ??= 'Anonymous';  // null이면 할당
  print('nickname: $nickname');

  nickname ??= 'NewName';    // 이미 값이 있으므로 할당 안됨
  print('nickname (unchanged): $nickname');

  // ========================================
  // 1-15. ?. 연산자 (null 조건)
  // ========================================

  print('\n=== ?. 연산자 ===');
  String? text;
  print('text?.length: ${text?.length}');

  text = 'Hello';
  print('text?.length: ${text?.length}');

  // ========================================
  // 1-16. if / else
  // ========================================

  print('\n=== if / else ===');
  int testScore = 85;

  if (testScore >= 90) {
    print('Excellent!');
  } else if (testScore >= 80) {
    print('Good!');
  } else if (testScore >= 70) {
    print('Not bad');
  } else {
    print('Need improvement');
  }

  // ========================================
  // 1-17. switch
  // ========================================

  print('\n=== switch ===');
  String day = 'Monday';

  switch (day) {
    case 'Monday':
    case 'Tuesday':
    case 'Wednesday':
    case 'Thursday':
    case 'Friday':
      print('Weekday');
      break;
    case 'Saturday':
    case 'Sunday':
      print('Weekend');
      break;
    default:
      print('Invalid day');
  }

  // Dart 3.0+ switch expression
  String dayType = switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
  print('$day is $dayType');

  // ========================================
  // 1-18. for / for-in
  // ========================================

  print('\n=== for / for-in ===');

  // 기본 for
  print('Basic for:');
  for (int i = 0; i < 5; i++) {
    print('  i = $i');
  }

  // for-in (JS의 for...of와 유사)
  print('for-in:');
  var fruits = ['apple', 'banana', 'cherry'];
  for (var fruit in fruits) {
    print('  $fruit');
  }

  // forEach (함수형)
  print('forEach:');
  fruits.forEach((fruit) => print('  $fruit'));

  // 인덱스가 필요한 경우
  print('with index:');
  for (var i = 0; i < fruits.length; i++) {
    print('  $i: ${fruits[i]}');
  }

  // asMap 사용
  print('asMap:');
  fruits.asMap().forEach((index, value) {
    print('  $index: $value');
  });

  // ========================================
  // 1-19. while
  // ========================================

  print('\n=== while ===');

  // while
  int count = 0;
  while (count < 3) {
    print('while count: $count');
    count++;
  }

  // do-while (최소 1번 실행)
  int n = 0;
  do {
    print('do-while n: $n');
    n++;
  } while (n < 3);

  // ========================================
  // 1-20. break / continue
  // ========================================

  print('\n=== break / continue ===');

  // break - 반복문 종료
  print('break example:');
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      print('  Breaking at $i');
      break;
    }
    print('  i = $i');
  }

  // continue - 다음 반복으로
  print('continue example:');
  for (int i = 0; i < 5; i++) {
    if (i == 2) {
      print('  Skipping $i');
      continue;
    }
    print('  i = $i');
  }

  // 레이블 사용 (중첩 반복문 탈출)
  print('labeled break:');
  outer:
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (i == 1 && j == 1) {
        print('  Breaking outer at i=$i, j=$j');
        break outer;
      }
      print('  i=$i, j=$j');
    }
  }
}

bool _expensive() {
  print('  (expensive function called)');
  return true;
}
