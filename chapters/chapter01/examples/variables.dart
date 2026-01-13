// STEP 1-1 ~ 1-5: 변수와 타입

void main() {
  // ========================================
  // 1-1. 변수 선언 (var, final, const)
  // ========================================

  // var: 타입 추론, 재할당 가능
  var name = 'Flutter';
  name = 'Dart';  // OK
  print('var name: $name');

  // final: 런타임에 결정, 재할당 불가
  final currentTime = DateTime.now();
  // currentTime = DateTime.now();  // 에러!
  print('final currentTime: $currentTime');

  // const: 컴파일타임 상수
  const pi = 3.14159;
  const appName = 'My App';
  // const now = DateTime.now();  // 에러! 컴파일타임에 결정 불가
  print('const pi: $pi');

  // ========================================
  // 1-2. 기본 타입
  // ========================================

  int count = 10;
  double price = 99.99;
  String message = 'Hello, Dart!';
  bool isActive = true;

  print('int: $count, double: $price');
  print('String: $message, bool: $isActive');

  // String interpolation (JS의 Template Literal)
  String greeting = 'Hello, $name!';
  String calculation = '2 + 2 = ${2 + 2}';
  print(greeting);
  print(calculation);

  // 멀티라인 문자열
  String multiline = '''
이것은
여러 줄
문자열입니다.
''';
  print(multiline);

  // ========================================
  // 1-3. 타입 추론
  // ========================================

  var inferredString = 'Hello';  // String으로 추론
  var inferredInt = 42;          // int로 추론
  var inferredDouble = 3.14;     // double로 추론

  // 명시적 타입 선언
  String explicitString = 'World';
  int explicitInt = 100;

  // dynamic vs var
  var fixedType = 10;
  // fixedType = 'String';  // 에러! int로 고정됨

  dynamic anyType = 10;
  anyType = 'Now a String';  // OK - any 타입처럼 동작
  anyType = true;             // OK
  print('dynamic: $anyType');

  // ========================================
  // 1-4. Null Safety
  // ========================================

  // Non-nullable (null 불가)
  String nonNullable = 'Always has value';
  // nonNullable = null;  // 에러!

  // Nullable (null 허용)
  String? nullable = null;
  nullable = 'Now has value';
  nullable = null;  // OK

  // ?. (null-aware access)
  String? maybeName;
  print('Length: ${maybeName?.length}');  // null

  // ?? (null coalescing)
  String displayName = maybeName ?? 'Guest';
  print('Display: $displayName');

  // ! (non-null assertion) - 주의해서 사용!
  String? definitelyHasValue = 'I exist';
  print('Forced: ${definitelyHasValue!.toUpperCase()}');

  // ========================================
  // 1-5. late 키워드
  // ========================================

  // 나중에 초기화
  late String description;

  // 초기화 전 접근하면 에러
  // print(description);  // LateInitializationError!

  description = 'Now initialized';
  print('late: $description');

  // Lazy initialization
  late final heavyData = _loadHeavyData();
  print('lazy initialized: $heavyData');
}

String _loadHeavyData() {
  print('Loading heavy data...');
  return 'Heavy data loaded!';
}
