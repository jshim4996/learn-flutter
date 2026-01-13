// STEP 2-11: Mixin 활용

void main() {
  // ========================================
  // 기본 Mixin 사용
  // ========================================

  print('=== 기본 Mixin ===');

  var duck = Duck('Donald');
  duck.speak();
  duck.swim();
  duck.fly();
  duck.walk();

  print('');

  var penguin = Penguin('Pingu');
  penguin.speak();
  penguin.swim();
  penguin.walk();
  // penguin.fly();  // 펭귄은 Flyer mixin이 없음

  print('');

  var fish = Fish('Nemo');
  fish.speak();
  fish.swim();

  // ========================================
  // on 키워드 - 특정 클래스에만 적용
  // ========================================

  print('\n=== on 키워드 ===');

  var parrot = Parrot('Polly');
  parrot.speak();
  parrot.sing();  // Musical mixin

  // ========================================
  // 실무 예제: 로깅과 유효성 검사
  // ========================================

  print('\n=== 실무 예제 ===');

  var userService = UserService();
  userService.createUser('Kim', 30);
  userService.updateUser('Kim', 31);

  print('');

  var productService = ProductService();
  productService.createProduct('Phone', 1000);

  // ========================================
  // Mixin 순서와 super 호출
  // ========================================

  print('\n=== Mixin 순서 ===');

  var example = MixinOrderExample();
  example.action();  // 호출 순서 확인

  // ========================================
  // Flutter 스타일 Mixin (예시)
  // ========================================

  print('\n=== Flutter 스타일 Mixin ===');

  var widget = MyAnimatedWidget();
  widget.initState();
  widget.startAnimation();
  widget.dispose();
}

// ========================================
// 기본 클래스와 Mixin 정의
// ========================================

class Animal {
  String name;

  Animal(this.name);

  void speak() {
    print('$name makes a sound');
  }
}

// Mixin 정의 - mixin 키워드 사용
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

// ========================================
// Mixin을 사용하는 클래스들
// ========================================

// 오리: 수영, 비행, 걷기 모두 가능
class Duck extends Animal with Swimmer, Flyer, Walker {
  Duck(String name) : super(name);

  @override
  void speak() {
    print('$name says: Quack!');
  }
}

// 펭귄: 수영, 걷기만 가능 (날 수 없음)
class Penguin extends Animal with Swimmer, Walker {
  Penguin(String name) : super(name);

  @override
  void speak() {
    print('$name says: Squawk!');
  }
}

// 물고기: 수영만 가능
class Fish extends Animal with Swimmer {
  Fish(String name) : super(name);

  @override
  void speak() {
    print('$name says: Blub blub!');
  }
}

// ========================================
// on 키워드 - 특정 클래스 제한
// ========================================

// Animal 클래스에만 적용 가능한 Mixin
mixin Musical on Animal {
  void sing() {
    print('$name is singing beautifully!');  // Animal의 name 접근 가능
  }
}

class Parrot extends Animal with Musical {
  Parrot(String name) : super(name);

  @override
  void speak() {
    print('$name says: Hello!');
  }
}

// ========================================
// 실무 예제: 로깅 Mixin
// ========================================

mixin Loggable {
  void log(String message) {
    print('[LOG ${DateTime.now().toIso8601String()}] $message');
  }
}

mixin Validatable {
  void validate(Map<String, dynamic> data) {
    for (var entry in data.entries) {
      if (entry.value == null) {
        throw ArgumentError('${entry.key} cannot be null');
      }
    }
    print('Validation passed');
  }
}

// 서비스 클래스에서 Mixin 사용
class UserService with Loggable, Validatable {
  void createUser(String name, int age) {
    validate({'name': name, 'age': age});
    log('Creating user: $name');
    // 실제 생성 로직...
    log('User created successfully');
  }

  void updateUser(String name, int age) {
    log('Updating user: $name');
    // 실제 업데이트 로직...
    log('User updated successfully');
  }
}

class ProductService with Loggable, Validatable {
  void createProduct(String name, double price) {
    validate({'name': name, 'price': price});
    log('Creating product: $name, price: $price');
    // 실제 생성 로직...
    log('Product created successfully');
  }
}

// ========================================
// Mixin 순서와 super
// ========================================

class Base {
  void action() {
    print('Base.action');
  }
}

mixin MixinA on Base {
  @override
  void action() {
    print('MixinA.action before super');
    super.action();
    print('MixinA.action after super');
  }
}

mixin MixinB on Base {
  @override
  void action() {
    print('MixinB.action before super');
    super.action();
    print('MixinB.action after super');
  }
}

// Mixin 순서: MixinA -> MixinB (오른쪽이 더 나중에 적용됨)
class MixinOrderExample extends Base with MixinA, MixinB {
  @override
  void action() {
    print('MixinOrderExample.action before super');
    super.action();
    print('MixinOrderExample.action after super');
  }
}

// ========================================
// Flutter 스타일 예제 (시뮬레이션)
// ========================================

// State 클래스 시뮬레이션
abstract class State {
  void initState() {
    print('State.initState');
  }

  void dispose() {
    print('State.dispose');
  }
}

// Flutter의 SingleTickerProviderStateMixin과 유사
mixin AnimationMixin on State {
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    print('AnimationMixin: Animation controller initialized');
  }

  void startAnimation() {
    _isAnimating = true;
    print('Animation started');
  }

  void stopAnimation() {
    _isAnimating = false;
    print('Animation stopped');
  }

  @override
  void dispose() {
    if (_isAnimating) {
      stopAnimation();
    }
    print('AnimationMixin: Animation controller disposed');
    super.dispose();
  }
}

class MyAnimatedWidget extends State with AnimationMixin {
  @override
  void initState() {
    super.initState();
    print('MyAnimatedWidget.initState');
  }

  @override
  void dispose() {
    print('MyAnimatedWidget.dispose');
    super.dispose();
  }
}
