// STEP 2-8 ~ 2-10, 2-12: 상속, 인터페이스, 추상 클래스, Override

void main() {
  // ========================================
  // 2-8. Extends (상속)
  // ========================================

  print('=== Extends (상속) ===');

  var dog = Dog('Max', 'Labrador');
  dog.speak();    // Override된 메서드
  dog.fetch();    // Dog만의 메서드

  var cat = Cat('Whiskers');
  cat.speak();    // Override된 메서드
  cat.scratch();  // Cat만의 메서드

  // 다형성
  Animal animal = Dog('Buddy', 'Beagle');
  animal.speak();  // Dog의 speak() 호출

  print('\nAll animals:');
  List<Animal> animals = [
    Dog('Max', 'Labrador'),
    Cat('Whiskers'),
    Dog('Buddy', 'Beagle'),
  ];
  for (var a in animals) {
    a.speak();
  }

  // ========================================
  // 2-9. Implements (인터페이스)
  // ========================================

  print('\n=== Implements (인터페이스) ===');

  var doc = Document('Report', 'This is the content');
  doc.printInfo();
  doc.save();

  // 인터페이스 타입으로 사용
  Printable printable = doc;
  printable.printInfo();

  Saveable saveable = doc;
  saveable.save();

  // 다중 인터페이스 구현
  var photo = Photo('vacation.jpg', 1024);
  photo.printInfo();
  photo.save();
  photo.share();

  // ========================================
  // 2-10. Abstract Class
  // ========================================

  print('\n=== Abstract Class ===');

  // var shape = Shape();  // 에러! 추상 클래스는 인스턴스화 불가

  Shape circle = Circle(5);
  circle.printInfo();

  Shape rectangle = Rectangle(10, 20);
  rectangle.printInfo();

  // 다형성 활용
  List<Shape> shapes = [
    Circle(3),
    Rectangle(4, 5),
    Circle(7),
  ];

  print('\nAll shapes:');
  double totalArea = 0;
  for (var shape in shapes) {
    shape.printInfo();
    totalArea += shape.getArea();
  }
  print('Total area: $totalArea');

  // ========================================
  // 2-12. @override
  // ========================================

  print('\n=== @override ===');

  var user1 = User('1', 'Kim');
  var user2 = User('1', 'Lee');
  var user3 = User('2', 'Park');

  print('user1: $user1');
  print('user1 == user2: ${user1 == user2}');  // true (같은 id)
  print('user1 == user3: ${user1 == user3}');  // false (다른 id)

  // Set에서 동등성 확인
  var users = <User>{user1, user2, user3};
  print('Unique users: ${users.length}');  // 2 (user1과 user2는 같은 id)
}

// ========================================
// 2-8. Extends (상속)
// ========================================

class Animal {
  String name;

  Animal(this.name);

  void speak() {
    print('$name makes a sound');
  }

  void eat() {
    print('$name is eating');
  }
}

class Dog extends Animal {
  String breed;

  Dog(String name, this.breed) : super(name);

  @override
  void speak() {
    print('$name (${breed}) barks: Woof!');
  }

  void fetch() {
    print('$name fetches the ball');
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void speak() {
    print('$name meows: Meow!');
  }

  void scratch() {
    print('$name scratches');
  }
}

// ========================================
// 2-9. Implements (인터페이스)
// ========================================

// 인터페이스로 사용될 클래스들
class Printable {
  void printInfo() {
    print('Printable info');
  }
}

class Saveable {
  void save() {
    print('Saved');
  }
}

class Shareable {
  void share() {
    print('Shared');
  }
}

// 다중 인터페이스 구현
class Document implements Printable, Saveable {
  String title;
  String content;

  Document(this.title, this.content);

  @override
  void printInfo() {
    print('Document: $title');
    print('Content: $content');
  }

  @override
  void save() {
    print('Document "$title" saved to disk');
  }
}

// 3개 인터페이스 구현
class Photo implements Printable, Saveable, Shareable {
  String filename;
  int size;

  Photo(this.filename, this.size);

  @override
  void printInfo() {
    print('Photo: $filename ($size KB)');
  }

  @override
  void save() {
    print('Photo $filename saved');
  }

  @override
  void share() {
    print('Photo $filename shared');
  }
}

// ========================================
// 2-10. Abstract Class
// ========================================

abstract class Shape {
  // 추상 메서드 - 구현 없음, 자식 클래스에서 필수 구현
  double getArea();
  double getPerimeter();

  // 일반 메서드 - 구현 있음, 상속됨
  void printInfo() {
    print('${runtimeType}: Area=${getArea().toStringAsFixed(2)}, '
        'Perimeter=${getPerimeter().toStringAsFixed(2)}');
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
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double getArea() => width * height;

  @override
  double getPerimeter() => 2 * (width + height);
}

// ========================================
// 2-12. @override - toString, ==, hashCode
// ========================================

class User {
  final String id;
  final String name;

  User(this.id, this.name);

  @override
  String toString() => 'User(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
