// STEP 1-4, 1-5: Null Safety 심화 예제

void main() {
  // ========================================
  // Null Safety 기본
  // ========================================

  // Non-nullable vs Nullable
  String nonNull = 'Hello';
  String? nullable = null;

  // 타입 체크
  print('nonNull is String: ${nonNull is String}');
  print('nullable is String?: ${nullable is String?}');

  // ========================================
  // ?. (Null-aware access operator)
  // ========================================

  String? name;

  // 안전한 접근
  print(name?.length);        // null
  print(name?.toUpperCase()); // null

  name = 'Flutter';
  print(name?.length);        // 7
  print(name?.toUpperCase()); // FLUTTER

  // 체이닝
  User? user;
  print(user?.address?.city);  // null

  user = User(address: Address(city: 'Seoul'));
  print(user?.address?.city);  // Seoul

  // ========================================
  // ?? (Null coalescing operator)
  // ========================================

  String? nickname;

  // 기본값 제공
  String displayName = nickname ?? 'Guest';
  print('Welcome, $displayName');

  // 연속 사용
  String? first;
  String? second;
  String third = 'Default';

  String result = first ?? second ?? third;
  print('Result: $result');  // Default

  // ========================================
  // ??= (Null-aware assignment)
  // ========================================

  String? username;
  print('Before: $username');

  username ??= 'Anonymous';  // null이면 할당
  print('After first ??=: $username');

  username ??= 'NewName';    // 이미 값이 있으므로 할당 안됨
  print('After second ??=: $username');

  // ========================================
  // ! (Non-null assertion)
  // ========================================

  String? maybeNull = 'I exist';

  // ! 사용 - null이 아님을 확신할 때만!
  String definitelyNotNull = maybeNull!;
  print(definitelyNotNull.toUpperCase());

  // 위험한 사용 예시 (런타임 에러 발생 가능)
  // String? danger;
  // print(danger!);  // Runtime error: Null check operator used on a null value

  // ========================================
  // late 키워드
  // ========================================

  // 나중에 초기화되는 변수
  late String lateVar;

  // 조건에 따라 초기화
  bool condition = true;
  if (condition) {
    lateVar = 'Initialized in if';
  } else {
    lateVar = 'Initialized in else';
  }
  print('lateVar: $lateVar');

  // Lazy initialization (처음 접근할 때 초기화)
  late final expensiveData = _computeExpensiveData();

  print('Before accessing expensiveData');
  print('expensiveData: $expensiveData');  // 여기서 초기화됨
  print('expensiveData again: $expensiveData');  // 이미 초기화됨

  // ========================================
  // Null 체크 패턴
  // ========================================

  String? input = getUserInput();

  // 방법 1: if null 체크
  if (input != null) {
    print('Input length: ${input.length}');  // 자동으로 non-null로 promotion
  }

  // 방법 2: ?? 사용
  String safeInput = input ?? '';
  print('Safe input: "$safeInput"');

  // 방법 3: 조기 반환 패턴
  processInput(input);
}

// 헬퍼 클래스
class User {
  final Address? address;
  User({this.address});
}

class Address {
  final String? city;
  Address({this.city});
}

String _computeExpensiveData() {
  print('Computing expensive data...');
  return 'Expensive result';
}

String? getUserInput() {
  return 'User typed this';
}

void processInput(String? input) {
  // 조기 반환 패턴
  if (input == null) {
    print('No input provided');
    return;
  }

  // 여기서부터 input은 non-null
  print('Processing: ${input.toUpperCase()}');
}
