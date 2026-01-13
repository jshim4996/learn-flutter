# STEP 1. Dart 기초 문법

> JavaScript/TypeScript 경험자를 위한 Dart 기초 - 익숙한 개념을 Dart 문법으로 전환

---

## 학습 목표
- Dart의 변수 선언과 타입 시스템 이해
- Null Safety 개념 습득
- 컬렉션과 연산자 활용
- 조건문, 반복문, 함수 작성

---

## 1-1. 변수 선언 (var, final, const)

### 핵심 개념

Dart에서 변수를 선언하는 3가지 방법:

```dart
var name = 'Flutter';     // 타입 추론, 재할당 가능
final age = 30;           // 런타임에 결정, 재할당 불가
const pi = 3.14159;       // 컴파일타임 상수, 재할당 불가
```

### JavaScript와 비교
| JavaScript | Dart | 설명 |
|------------|------|------|
| `let` | `var` | 재할당 가능한 변수 |
| `const` | `final` | 재할당 불가 (런타임) |
| - | `const` | 컴파일타임 상수 |

### 실무 포인트
> `final`은 API 응답처럼 런타임에 결정되는 값에, `const`는 앱 설정값처럼 절대 변하지 않는 값에 사용

---

## 1-2. 기본 타입 (int, double, String, bool)

### 핵심 개념

```dart
int count = 10;           // 정수
double price = 99.99;     // 실수
String message = 'Hello'; // 문자열
bool isActive = true;     // 불리언
```

### String 다루기
```dart
// 문자열 보간 (Template Literal과 유사)
String name = 'Dart';
print('Hello, $name!');           // 변수
print('2 + 2 = ${2 + 2}');        // 표현식

// 멀티라인
String multiline = '''
여러 줄
문자열
''';
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `number` | `int`, `double` |
| `` `Hello ${name}` `` | `'Hello $name'` |

---

## 1-3. 타입 추론

### 핵심 개념

```dart
var name = 'Flutter';  // String으로 추론
var count = 10;        // int로 추론

// 명시적 타입 선언도 가능
String title = 'App';
int amount = 100;
```

### dynamic vs var
```dart
var a = 10;       // int로 고정됨, 나중에 String 할당 불가
dynamic b = 10;   // 어떤 타입이든 할당 가능 (TypeScript의 any와 유사)
```

### 실무 포인트
> `dynamic`은 가급적 피하고, 타입을 명시하거나 `var`를 사용. JSON 파싱 시에만 제한적으로 사용

---

## 1-4. Null Safety (?. ?? !)

### 핵심 개념

Dart 2.12부터 기본적으로 모든 변수는 null이 될 수 없음:

```dart
String name = 'Flutter';   // null 불가
String? nickname;          // null 허용 (? 붙임)

// null 체크 연산자들
print(nickname?.length);   // null이면 null 반환
print(nickname ?? 'Guest'); // null이면 기본값
print(nickname!.length);    // null 아님을 확신 (위험!)
```

### JavaScript와 비교
| JavaScript | Dart | 설명 |
|------------|------|------|
| `?.` | `?.` | Optional Chaining |
| `??` | `??` | Nullish Coalescing |
| - | `!` | Non-null Assertion |

### 실무 포인트
> `!`는 정말 확실할 때만 사용. 잘못 사용하면 런타임 에러 발생

---

## 1-5. late 키워드

### 핵심 개념

변수를 나중에 초기화할 때 사용:

```dart
late String description;

void init() {
  description = 'Loaded!';  // 나중에 초기화
}

// lazy initialization - 처음 접근할 때 초기화
late final data = fetchData();
```

### 언제 사용하나?
- `initState()`에서 초기화하는 값
- 생성자에서 바로 초기화할 수 없는 값
- 무거운 연산을 지연시키고 싶을 때

---

## 1-6. List

### 핵심 개념

```dart
// 리스트 생성
List<String> fruits = ['apple', 'banana', 'cherry'];
var numbers = [1, 2, 3];  // List<int>로 추론

// 주요 메서드
fruits.add('orange');
fruits.remove('banana');
fruits.contains('apple');  // true

// map, where, reduce (JS와 동일한 개념)
var doubled = numbers.map((n) => n * 2).toList();
var evens = numbers.where((n) => n % 2 == 0).toList();
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `array.push()` | `list.add()` |
| `array.filter()` | `list.where()` |
| `array.find()` | `list.firstWhere()` |

---

## 1-7. Map

### 핵심 개념

```dart
// Map 생성 (JS의 Object와 유사)
Map<String, int> scores = {
  'math': 90,
  'english': 85,
};

// 접근 및 수정
print(scores['math']);     // 90
scores['science'] = 88;

// 주요 메서드
scores.keys;               // ('math', 'english', 'science')
scores.values;             // (90, 85, 88)
scores.containsKey('math'); // true
```

### JavaScript와 비교
```javascript
// JavaScript
const obj = { name: 'Flutter' };
obj.name;

// Dart
Map<String, String> map = {'name': 'Flutter'};
map['name'];
```

---

## 1-8. Set

### 핵심 개념

중복을 허용하지 않는 컬렉션:

```dart
Set<int> numbers = {1, 2, 3, 3, 3};
print(numbers);  // {1, 2, 3}

// 주요 연산
numbers.add(4);
numbers.remove(1);
numbers.contains(2);  // true

// 집합 연산
var a = {1, 2, 3};
var b = {2, 3, 4};
print(a.union(b));        // {1, 2, 3, 4}
print(a.intersection(b)); // {2, 3}
```

---

## 1-9. 스프레드 연산자 (...)

### 핵심 개념

```dart
var list1 = [1, 2, 3];
var list2 = [0, ...list1, 4];  // [0, 1, 2, 3, 4]

// null-aware 스프레드
List<int>? nullableList;
var result = [1, ...?nullableList, 2];  // [1, 2]

// 조건부 추가
var showExtra = true;
var items = [
  'item1',
  if (showExtra) 'extra',
];
```

### JavaScript와 동일
```javascript
const arr = [...arr1, ...arr2];
```

---

## 1-10. 산술 연산자

### 핵심 개념

```dart
int a = 10, b = 3;

print(a + b);   // 13
print(a - b);   // 7
print(a * b);   // 30
print(a / b);   // 3.333... (double)
print(a ~/ b);  // 3 (정수 나눗셈) ← Dart 전용!
print(a % b);   // 1 (나머지)
```

### JavaScript와 차이점
| 연산 | JavaScript | Dart |
|------|------------|------|
| 정수 나눗셈 | `Math.floor(10/3)` | `10 ~/ 3` |

---

## 1-11. 비교 연산자

### 핵심 개념

```dart
print(5 == 5);   // true
print(5 != 3);   // true
print(5 > 3);    // true
print(5 >= 5);   // true
print(3 < 5);    // true
print(3 <= 3);   // true
```

### JavaScript와 차이점
- Dart에는 `===` (엄격한 동등)이 없음
- `==`가 타입까지 비교함 (TypeScript와 유사)

---

## 1-12. 논리 연산자

### 핵심 개념

```dart
bool a = true, b = false;

print(a && b);  // false (AND)
print(a || b);  // true (OR)
print(!a);      // false (NOT)
```

### JavaScript와 동일
```javascript
a && b
a || b
!a
```

---

## 1-13. 삼항 연산자

### 핵심 개념

```dart
int age = 20;
String status = age >= 18 ? 'Adult' : 'Minor';
```

### JavaScript와 동일
```javascript
const status = age >= 18 ? 'Adult' : 'Minor';
```

---

## 1-14. ?? 연산자 (null 병합)

### 핵심 개념

```dart
String? name;
print(name ?? 'Guest');  // 'Guest'

// ??= 할당 연산자
String? nickname;
nickname ??= 'Unknown';  // null이면 할당
```

### JavaScript와 동일
```javascript
const result = value ?? 'default';
value ??= 'default';
```

---

## 1-15. ?. 연산자 (null 조건)

### 핵심 개념

```dart
String? name;
print(name?.length);      // null
print(name?.toUpperCase()); // null

// 체이닝
User? user;
print(user?.address?.city);
```

### JavaScript와 동일
```javascript
user?.address?.city
```

---

## 1-16. if / else

### 핵심 개념

```dart
int score = 85;

if (score >= 90) {
  print('A');
} else if (score >= 80) {
  print('B');
} else {
  print('C');
}
```

### JavaScript와 동일한 문법

---

## 1-17. switch

### 핵심 개념

```dart
String grade = 'A';

switch (grade) {
  case 'A':
    print('Excellent');
    break;
  case 'B':
    print('Good');
    break;
  default:
    print('Unknown');
}

// Dart 3.0+ switch expression
var message = switch (grade) {
  'A' => 'Excellent',
  'B' => 'Good',
  _ => 'Unknown',
};
```

---

## 1-18. for / for-in

### 핵심 개념

```dart
// 기본 for
for (int i = 0; i < 5; i++) {
  print(i);
}

// for-in (JS의 for...of와 유사)
var fruits = ['apple', 'banana', 'cherry'];
for (var fruit in fruits) {
  print(fruit);
}

// forEach
fruits.forEach((fruit) => print(fruit));
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `for...of` | `for...in` |
| `for...in` (키) | `map.keys` 사용 |

---

## 1-19. while

### 핵심 개념

```dart
// while
int count = 0;
while (count < 5) {
  print(count);
  count++;
}

// do-while
int n = 0;
do {
  print(n);
  n++;
} while (n < 5);
```

---

## 1-20. break / continue

### 핵심 개념

```dart
// break - 반복문 종료
for (int i = 0; i < 10; i++) {
  if (i == 5) break;
  print(i);  // 0, 1, 2, 3, 4
}

// continue - 다음 반복으로
for (int i = 0; i < 5; i++) {
  if (i == 2) continue;
  print(i);  // 0, 1, 3, 4
}
```

---

## 1-21. 함수 선언

### 핵심 개념

```dart
// 기본 함수
int add(int a, int b) {
  return a + b;
}

// 반환 타입 추론 (비권장)
add2(a, b) {
  return a + b;
}

// void 함수
void greet(String name) {
  print('Hello, $name!');
}
```

### JavaScript와 비교
```javascript
// JavaScript
function add(a, b) {
  return a + b;
}

// Dart - 타입 명시가 기본
int add(int a, int b) {
  return a + b;
}
```

---

## 1-22. 매개변수 (required, optional, named)

### 핵심 개념

```dart
// 필수 매개변수
void greet(String name) { }

// Optional positional 매개변수
void greet2(String name, [String? title]) {
  print('$title $name');
}
greet2('Kim');           // null Kim
greet2('Kim', 'Mr.');    // Mr. Kim

// Named 매개변수 (가장 많이 사용!)
void greet3({required String name, int age = 0}) {
  print('$name is $age');
}
greet3(name: 'Kim', age: 30);
greet3(name: 'Lee');  // age는 기본값 0
```

### 실무 포인트
> Flutter 위젯은 대부분 Named 매개변수 사용. 가독성이 좋고 순서 무관

---

## 1-23. 화살표 함수 (=>)

### 핵심 개념

```dart
// 한 줄 표현식일 때 사용
int add(int a, int b) => a + b;

// 일반 함수와 동일
int add2(int a, int b) {
  return a + b;
}

// void 함수도 가능
void greet(String name) => print('Hello, $name!');
```

### JavaScript와 동일
```javascript
const add = (a, b) => a + b;
```

---

## 1-24. 익명 함수

### 핵심 개념

```dart
// 콜백으로 많이 사용
var numbers = [1, 2, 3];

// 익명 함수
numbers.forEach((number) {
  print(number);
});

// 화살표 함수로 간단히
numbers.forEach((n) => print(n));

// 변수에 할당
var multiply = (int a, int b) => a * b;
print(multiply(3, 4));  // 12
```

### JavaScript와 비교
```javascript
// JavaScript
const multiply = (a, b) => a * b;
array.forEach((item) => console.log(item));
```

---

## 예제 파일
- `examples/variables.dart` - 변수 선언 예제
- `examples/null_safety.dart` - Null Safety 예제
- `examples/collections.dart` - 컬렉션 예제
- `examples/control_flow.dart` - 조건문/반복문 예제
- `examples/functions.dart` - 함수 예제

---

## 다음 단계
→ STEP 2: Dart 객체지향
