// STEP 2-1 ~ 2-7: 클래스 기본

import 'dart:math';

void main() {
  // ========================================
  // 2-1. 클래스 선언
  // ========================================

  print('=== 클래스 선언 ===');

  var person = Person('Kim', 30);
  person.introduce();

  // ========================================
  // 2-2. 생성자
  // ========================================

  print('\n=== 생성자 ===');

  var point = Point(3, 4);
  print('Point($point.x, $point.y), distance: ${point.distance}');

  var user = User('Lee', 25);
  print('User: ${user.name}, ${user.age}');

  // 초기화 리스트
  var rect = Rectangle.square(10);
  print('Square: ${rect.width} x ${rect.height}');

  // ========================================
  // 2-3. Named 생성자
  // ========================================

  print('\n=== Named 생성자 ===');

  var user1 = User('Park', 35);
  var user2 = User.guest();
  var user3 = User.fromJson({'name': 'Choi', 'age': 28});

  print('user1: ${user1.name}, ${user1.age}');
  print('user2: ${user2.name}, ${user2.age}');
  print('user3: ${user3.name}, ${user3.age}');

  // ========================================
  // 2-4. Factory 생성자
  // ========================================

  print('\n=== Factory 생성자 ===');

  // 싱글톤 패턴
  var logger1 = Logger();
  var logger2 = Logger();
  print('Same instance? ${logger1 == logger2}');  // true

  logger1.log('Hello from logger1');
  logger2.log('Hello from logger2');

  // 캐싱 패턴
  var color1 = Color.named('red');
  var color2 = Color.named('red');
  var color3 = Color.named('blue');
  print('color1 == color2? ${color1 == color2}');  // true (캐시됨)
  print('color1 == color3? ${color1 == color3}');  // false

  // ========================================
  // 2-5. 필드와 메서드
  // ========================================

  print('\n=== 필드와 메서드 ===');

  var counter1 = Counter();
  var counter2 = Counter();

  counter1.increment();
  counter1.increment();
  counter2.increment();

  print('counter1: ${counter1.count}');  // 2
  print('counter2: ${counter2.count}');  // 1
  print('totalCounters: ${Counter.totalCounters}');  // 2

  // Static 메서드 호출
  Counter.printStats();

  // ========================================
  // 2-6. Getter / Setter
  // ========================================

  print('\n=== Getter / Setter ===');

  var rectArea = RectangleArea(10, 20);
  print('Area: ${rectArea.area}');           // Getter
  print('Perimeter: ${rectArea.perimeter}'); // Getter

  rectArea.area = 400;  // Setter
  print('After area = 400:');
  print('  Width: ${rectArea.width}');
  print('  Height: ${rectArea.height}');

  // Temperature 예제
  var temp = Temperature.celsius(25);
  print('Celsius: ${temp.celsius}');
  print('Fahrenheit: ${temp.fahrenheit}');

  temp.fahrenheit = 100;
  print('After fahrenheit = 100, celsius: ${temp.celsius}');

  // ========================================
  // 2-7. Private
  // ========================================

  print('\n=== Private ===');

  var account = BankAccount('Kim');
  account.deposit(1000);
  account.withdraw(300);
  print('Balance: ${account.balance}');
  // print(account._balance);  // 같은 파일이라 접근 가능 (다른 파일에서는 불가)

  account.withdraw(800);  // 잔액 부족
  print('Balance after failed withdraw: ${account.balance}');
}

// ========================================
// 2-1. 클래스 선언
// ========================================

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('저는 $name이고, $age살입니다.');
  }
}

// ========================================
// 2-2. 생성자
// ========================================

class Point {
  final double x;
  final double y;
  final double distance;

  // 초기화 리스트
  Point(this.x, this.y) : distance = sqrt(x * x + y * y);
}

class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  // Named 생성자 + 초기화 리스트
  Rectangle.square(double size)
      : width = size,
        height = size;
}

// ========================================
// 2-3. Named 생성자
// ========================================

class User {
  String name;
  int age;

  User(this.name, this.age);

  // Named 생성자들
  User.guest()
      : name = 'Guest',
        age = 0;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? 'Unknown',
        age = json['age'] ?? 0;

  // toJson 메서드
  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
      };
}

// ========================================
// 2-4. Factory 생성자
// ========================================

// 싱글톤 패턴
class Logger {
  static final Logger _instance = Logger._internal();

  Logger._internal() {
    print('Logger instance created');
  }

  factory Logger() {
    return _instance;
  }

  void log(String message) {
    print('[LOG] $message');
  }
}

// 캐싱 패턴
class Color {
  static final Map<String, Color> _cache = {};

  final String name;

  Color._internal(this.name);

  factory Color.named(String name) {
    return _cache.putIfAbsent(name, () => Color._internal(name));
  }
}

// ========================================
// 2-5. 필드와 메서드
// ========================================

class Counter {
  // 인스턴스 필드
  int count = 0;

  // Static 필드
  static int totalCounters = 0;

  Counter() {
    totalCounters++;
  }

  // 인스턴스 메서드
  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  // Static 메서드
  static void printStats() {
    print('Total counters created: $totalCounters');
  }
}

// ========================================
// 2-6. Getter / Setter
// ========================================

class RectangleArea {
  double width;
  double height;

  RectangleArea(this.width, this.height);

  // Getter
  double get area => width * height;

  // Setter
  set area(double value) {
    var ratio = sqrt(value / area);
    width *= ratio;
    height *= ratio;
  }

  // 읽기 전용 Getter
  double get perimeter => 2 * (width + height);
}

class Temperature {
  double _celsius;

  Temperature.celsius(this._celsius);

  // Getter
  double get celsius => _celsius;
  double get fahrenheit => _celsius * 9 / 5 + 32;

  // Setter
  set celsius(double value) => _celsius = value;
  set fahrenheit(double value) => _celsius = (value - 32) * 5 / 9;
}

// ========================================
// 2-7. Private
// ========================================

class BankAccount {
  final String owner;
  double _balance = 0;  // private

  BankAccount(this.owner);

  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited: $amount');
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Withdrawn: $amount');
    } else {
      print('Insufficient balance');
    }
  }

  // Getter - 읽기만 허용
  double get balance => _balance;
}
