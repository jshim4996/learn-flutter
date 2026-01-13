# STEP 2. Dart 객체지향

> JavaScript/TypeScript 클래스 경험자를 위한 Dart OOP - 익숙하지만 더 강력한 기능들

---

## 학습 목표
- Dart 클래스 선언과 생성자 이해
- 상속, 인터페이스, 믹스인 활용
- 접근 제어자와 캡슐화

---

## 2-1. 클래스 선언

### 핵심 개념

```dart
class Person {
  String name;
  int age;

  // 생성자
  Person(this.name, this.age);

  // 메서드
  void introduce() {
    print('저는 $name이고, $age살입니다.');
  }
}

// 사용
var person = Person('Kim', 30);
person.introduce();
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `class Person { }` | `class Person { }` |
| `constructor(name)` | `Person(this.name)` |
| `this.name = name` | `this.name` (축약) |

---

## 2-2. 생성자

### 핵심 개념

```dart
class User {
  String name;
  int age;

  // 기본 생성자 (축약 문법)
  User(this.name, this.age);

  // 생성자 본문이 필요한 경우
  User.withValidation(this.name, this.age) {
    if (age < 0) throw ArgumentError('Age cannot be negative');
  }
}
```

### 초기화 리스트
```dart
class Point {
  final double x;
  final double y;
  final double distance;

  // 초기화 리스트 - 생성자 본문 전에 실행
  Point(this.x, this.y) : distance = sqrt(x * x + y * y);
}
```

---

## 2-3. Named 생성자

### 핵심 개념

여러 방식으로 객체를 생성할 때 사용:

```dart
class User {
  String name;
  int age;

  User(this.name, this.age);

  // Named 생성자
  User.guest() : name = 'Guest', age = 0;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];
}

// 사용
var user1 = User('Kim', 30);
var user2 = User.guest();
var user3 = User.fromJson({'name': 'Lee', 'age': 25});
```

### 실무 포인트
> `fromJson`, `fromMap` 같은 Named 생성자는 API 응답 파싱에 필수

---

## 2-4. Factory 생성자

### 핵심 개념

캐싱, 싱글톤, 조건부 객체 생성 시 사용:

```dart
class Logger {
  static final Logger _instance = Logger._internal();

  // private 생성자
  Logger._internal();

  // factory 생성자 - 싱글톤 패턴
  factory Logger() {
    return _instance;
  }

  void log(String message) => print('[LOG] $message');
}

// 사용 - 항상 같은 인스턴스 반환
var logger1 = Logger();
var logger2 = Logger();
print(logger1 == logger2);  // true
```

### 조건부 객체 생성
```dart
abstract class Shape {
  factory Shape(String type) {
    switch (type) {
      case 'circle':
        return Circle();
      case 'square':
        return Square();
      default:
        throw ArgumentError('Unknown shape: $type');
    }
  }
}
```

---

## 2-5. 필드와 메서드

### 핵심 개념

```dart
class Counter {
  // 인스턴스 필드
  int count = 0;

  // static 필드 (클래스 레벨)
  static int totalCounters = 0;

  Counter() {
    totalCounters++;
  }

  // 인스턴스 메서드
  void increment() {
    count++;
  }

  // static 메서드
  static void resetAll() {
    totalCounters = 0;
  }
}
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `static count = 0` | `static int count = 0` |
| `static method()` | `static void method()` |

---

## 2-6. Getter / Setter

### 핵심 개념

```dart
class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  // Getter
  double get area => width * height;

  // Setter
  set area(double value) {
    // 비율 유지하며 면적 조정
    var ratio = sqrt(value / area);
    width *= ratio;
    height *= ratio;
  }

  // 읽기 전용 (Getter만)
  double get perimeter => 2 * (width + height);
}

// 사용
var rect = Rectangle(10, 20);
print(rect.area);       // 200 - getter 호출
rect.area = 400;        // setter 호출
```

### 실무 포인트
> 계산된 값을 필드처럼 접근할 때 유용. Flutter에서 상태 파생값에 자주 사용

---

## 2-7. Private (_)

### 핵심 개념

Dart에서 `_`로 시작하면 라이브러리(파일) private:

```dart
class BankAccount {
  // private 필드 (파일 외부에서 접근 불가)
  double _balance = 0;

  // public 메서드
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
    }
  }

  // Getter로 읽기만 허용
  double get balance => _balance;
}
```

### JavaScript와 비교
| JavaScript | Dart |
|------------|------|
| `#privateField` | `_privateField` |
| 클래스 레벨 private | 파일(라이브러리) 레벨 private |

---

## 2-8. Extends (상속)

### 핵심 개념

```dart
class Animal {
  String name;

  Animal(this.name);

  void speak() {
    print('$name makes a sound');
  }
}

class Dog extends Animal {
  String breed;

  // super로 부모 생성자 호출
  Dog(String name, this.breed) : super(name);

  @override
  void speak() {
    print('$name barks!');
  }

  // 추가 메서드
  void fetch() {
    print('$name fetches the ball');
  }
}

// 사용
var dog = Dog('Max', 'Labrador');
dog.speak();  // Max barks!
dog.fetch();
```

---

## 2-9. Implements (인터페이스)

### 핵심 개념

Dart에서는 모든 클래스가 암묵적으로 인터페이스:

```dart
// 인터페이스로 사용될 클래스
class Printable {
  void printInfo() {
    print('Printable');
  }
}

class Saveable {
  void save() {
    print('Saved');
  }
}

// 다중 구현
class Document implements Printable, Saveable {
  @override
  void printInfo() {
    print('Document info');
  }

  @override
  void save() {
    print('Document saved');
  }
}
```

### extends vs implements
| `extends` | `implements` |
|-----------|--------------|
| 단일 상속만 가능 | 다중 구현 가능 |
| 부모 메서드 상속 | 모든 메서드 재정의 필수 |
| `super` 사용 가능 | 구현만 필요 |

---

## 2-10. Abstract Class

### 핵심 개념

```dart
abstract class Shape {
  // 추상 메서드 - 구현 없음
  double getArea();
  double getPerimeter();

  // 일반 메서드 - 구현 있음
  void printInfo() {
    print('Area: ${getArea()}, Perimeter: ${getPerimeter()}');
  }
}

class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double getArea() => 3.14159 * radius * radius;

  @override
  double getPerimeter() => 2 * 3.14159 * radius;
}

class Rectangle extends Shape {
  double width, height;

  Rectangle(this.width, this.height);

  @override
  double getArea() => width * height;

  @override
  double getPerimeter() => 2 * (width + height);
}
```

### 실무 포인트
> 공통 인터페이스 정의에 사용. Repository, Service 등 추상화에 필수

---

## 2-11. Mixin (with)

### 핵심 개념

다중 상속 대안, 코드 재사용:

```dart
// Mixin 정의
mixin Swimmer {
  void swim() {
    print('Swimming...');
  }
}

mixin Flyer {
  void fly() {
    print('Flying...');
  }
}

mixin Walker {
  void walk() {
    print('Walking...');
  }
}

// 여러 Mixin 사용
class Duck extends Animal with Swimmer, Flyer, Walker {
  Duck(String name) : super(name);
}

class Dog extends Animal with Swimmer, Walker {
  Dog(String name) : super(name);
}

// 사용
var duck = Duck('Donald');
duck.swim();
duck.fly();
duck.walk();
```

### on 키워드
```dart
// 특정 클래스에만 적용 가능한 Mixin
mixin Musical on Animal {
  void sing() {
    print('$name is singing');  // Animal의 name 접근 가능
  }
}
```

### 실무 포인트
> Flutter에서 `SingleTickerProviderStateMixin`, `AutomaticKeepAliveClientMixin` 등 자주 사용

---

## 2-12. @override

### 핵심 개념

```dart
class Parent {
  void greet() {
    print('Hello from Parent');
  }
}

class Child extends Parent {
  @override  // 명시적으로 재정의 표시
  void greet() {
    super.greet();  // 부모 메서드 호출 가능
    print('Hello from Child');
  }
}
```

### toString, hashCode, ==
```dart
class User {
  final String id;
  final String name;

  User(this.id, this.name);

  @override
  String toString() => 'User($id, $name)';

  @override
  bool operator ==(Object other) =>
      other is User && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
```

---

## 예제 파일
- `examples/class_basic.dart` - 클래스 기본, 생성자
- `examples/inheritance.dart` - 상속, 인터페이스, 추상 클래스
- `examples/mixin.dart` - Mixin 활용

---

## 다음 단계
→ STEP 3: Dart 비동기 (Future, Stream, async/await)
