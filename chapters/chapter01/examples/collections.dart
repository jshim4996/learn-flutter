// STEP 1-6 ~ 1-9: 컬렉션 (List, Map, Set, Spread)

void main() {
  // ========================================
  // 1-6. List
  // ========================================

  // 리스트 생성
  List<String> fruits = ['apple', 'banana', 'cherry'];
  var numbers = [1, 2, 3, 4, 5];  // List<int>로 추론
  List<int> empty = [];           // 빈 리스트

  print('fruits: $fruits');
  print('numbers: $numbers');

  // 요소 접근
  print('First fruit: ${fruits[0]}');
  print('Last fruit: ${fruits[fruits.length - 1]}');
  print('Last (better): ${fruits.last}');

  // 추가/삭제
  fruits.add('orange');
  print('After add: $fruits');

  fruits.remove('banana');
  print('After remove: $fruits');

  fruits.insert(1, 'grape');
  print('After insert: $fruits');

  fruits.removeAt(0);
  print('After removeAt: $fruits');

  // 검색
  print('Contains cherry: ${fruits.contains("cherry")}');
  print('Index of cherry: ${fruits.indexOf("cherry")}');

  // 함수형 메서드 (JS와 유사)
  var doubled = numbers.map((n) => n * 2).toList();
  print('Doubled: $doubled');

  var evens = numbers.where((n) => n % 2 == 0).toList();
  print('Evens: $evens');

  var sum = numbers.reduce((a, b) => a + b);
  print('Sum: $sum');

  var found = numbers.firstWhere((n) => n > 3);
  print('First > 3: $found');

  // any, every
  print('Any > 4: ${numbers.any((n) => n > 4)}');
  print('Every > 0: ${numbers.every((n) => n > 0)}');

  // ========================================
  // 1-7. Map
  // ========================================

  // Map 생성 (JS의 Object와 유사)
  Map<String, int> scores = {
    'math': 90,
    'english': 85,
    'science': 88,
  };

  var person = <String, dynamic>{
    'name': 'Kim',
    'age': 30,
    'isStudent': false,
  };

  print('scores: $scores');
  print('person: $person');

  // 접근
  print('Math score: ${scores["math"]}');
  print('Name: ${person["name"]}');

  // 수정/추가
  scores['history'] = 92;
  scores['math'] = 95;
  print('Updated scores: $scores');

  // 삭제
  scores.remove('history');
  print('After remove: $scores');

  // 키/값 접근
  print('Keys: ${scores.keys}');
  print('Values: ${scores.values}');
  print('Entries: ${scores.entries}');

  // 검색
  print('Has math: ${scores.containsKey("math")}');
  print('Has 90: ${scores.containsValue(90)}');

  // 순회
  scores.forEach((key, value) {
    print('$key: $value');
  });

  // Map 변환
  var uppercaseKeys = scores.map((k, v) => MapEntry(k.toUpperCase(), v));
  print('Uppercase keys: $uppercaseKeys');

  // ========================================
  // 1-8. Set
  // ========================================

  // Set 생성 (중복 제거)
  Set<int> numbersSet = {1, 2, 3, 3, 3};
  print('Set (no duplicates): $numbersSet');

  var colors = <String>{'red', 'green', 'blue'};
  print('Colors: $colors');

  // 추가/삭제
  colors.add('yellow');
  colors.add('red');  // 이미 있으므로 무시됨
  print('After adds: $colors');

  colors.remove('green');
  print('After remove: $colors');

  // 검색
  print('Contains blue: ${colors.contains("blue")}');

  // 집합 연산
  var setA = {1, 2, 3, 4};
  var setB = {3, 4, 5, 6};

  print('A: $setA, B: $setB');
  print('Union (합집합): ${setA.union(setB)}');
  print('Intersection (교집합): ${setA.intersection(setB)}');
  print('Difference (차집합): ${setA.difference(setB)}');

  // List에서 중복 제거
  var listWithDuplicates = [1, 2, 2, 3, 3, 3, 4];
  var uniqueList = listWithDuplicates.toSet().toList();
  print('Unique: $uniqueList');

  // ========================================
  // 1-9. 스프레드 연산자 (...)
  // ========================================

  // List 스프레드
  var list1 = [1, 2, 3];
  var list2 = [0, ...list1, 4, 5];
  print('Spread list: $list2');

  // 두 리스트 병합
  var combined = [...list1, ...[4, 5, 6]];
  print('Combined: $combined');

  // null-aware spread (...?)
  List<int>? nullableList;
  var safeSpread = [1, 2, ...?nullableList, 3];
  print('Safe spread: $safeSpread');

  nullableList = [4, 5];
  var withValues = [1, 2, ...?nullableList, 6];
  print('With values: $withValues');

  // 조건부 추가 (collection if)
  var showAdmin = true;
  var menuItems = [
    'Home',
    'Profile',
    if (showAdmin) 'Admin',
  ];
  print('Menu: $menuItems');

  // 반복 추가 (collection for)
  var indices = [for (var i = 0; i < 5; i++) 'item_$i'];
  print('Generated: $indices');

  // 복합 사용
  var isLoggedIn = true;
  var baseMenu = ['Home', 'About'];
  var userMenu = [
    ...baseMenu,
    if (isLoggedIn) ...[
      'Profile',
      'Settings',
      'Logout',
    ],
  ];
  print('User menu: $userMenu');

  // Map 스프레드
  var map1 = {'a': 1, 'b': 2};
  var map2 = {'c': 3, ...map1};
  print('Spread map: $map2');
}
