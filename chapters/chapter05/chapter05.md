# STEP 5. Flutter 레이아웃

> 리스트, 그리드, 폼 - 실제 앱에서 가장 많이 사용하는 UI 패턴

---

## 학습 목표
- 스크롤 가능한 리스트/그리드 구현
- 사용자 입력 폼 처리
- 다양한 입력 위젯 활용

---

## 5-1. ListView

### 핵심 개념

```dart
// 기본 ListView (적은 항목)
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)

// ListView.builder (많은 항목 - 권장)
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index]),
    );
  },
)

// ListView.separated (구분선 포함)
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  separatorBuilder: (context, index) => Divider(),
)
```

### 실무 포인트
> `ListView.builder`는 화면에 보이는 항목만 렌더링하여 성능 최적화. 많은 데이터에 필수

---

## 5-2. GridView

### 핵심 개념

```dart
// 고정 열 수
GridView.count(
  crossAxisCount: 2,
  children: [
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ],
)

// 동적 크기
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Container(color: Colors.blue.shade100);
  },
)

// 최대 너비 기반
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150,  // 최대 너비
    childAspectRatio: 1.0,    // 가로세로 비율
  ),
  itemCount: 20,
  itemBuilder: (context, index) => Container(color: Colors.green),
)
```

---

## 5-3. SingleChildScrollView

### 핵심 개념

단일 자식을 스크롤 가능하게:

```dart
SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      // 많은 위젯들...
      Container(height: 200, color: Colors.red),
      Container(height: 200, color: Colors.green),
      Container(height: 200, color: Colors.blue),
    ],
  ),
)
```

### 주의사항
```dart
// Column에서 ListView 사용 시
SingleChildScrollView(
  child: Column(
    children: [
      // 이렇게 하면 안됨 - 무한 높이 오류
      // ListView(...)

      // 대신 shrinkWrap 사용
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) => Text('Item $index'),
      ),
    ],
  ),
)
```

---

## 5-4. CustomScrollView / Sliver

### 핵심 개념

```dart
CustomScrollView(
  slivers: [
    // 접히는 앱바
    SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('My App'),
        background: Image.network('...', fit: BoxFit.cover),
      ),
    ),

    // 리스트
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item $index')),
        childCount: 20,
      ),
    ),

    // 그리드
    SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(color: Colors.blue),
        childCount: 10,
      ),
    ),
  ],
)
```

### 실무 포인트
> 복잡한 스크롤 레이아웃(고정 헤더, 혼합 리스트/그리드)에 사용

---

## 5-5. TextField

### 핵심 개념

```dart
// 기본 TextField
TextField(
  decoration: InputDecoration(
    labelText: 'Username',
    hintText: 'Enter your username',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
)

// Controller 사용
final _controller = TextEditingController();

TextField(
  controller: _controller,
  onChanged: (value) {
    print('Current: $value');
  },
  onSubmitted: (value) {
    print('Submitted: $value');
  },
)

// 값 읽기
print(_controller.text);

// 반드시 dispose
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## 5-6. Button

### 핵심 개념

```dart
// ElevatedButton (채워진 버튼)
ElevatedButton(
  onPressed: () {},
  child: Text('Click Me'),
)

// TextButton (텍스트만)
TextButton(
  onPressed: () {},
  child: Text('Text Button'),
)

// OutlinedButton (테두리)
OutlinedButton(
  onPressed: () {},
  child: Text('Outlined'),
)

// IconButton
IconButton(
  icon: Icon(Icons.favorite),
  onPressed: () {},
)

// 스타일링
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  ),
  onPressed: () {},
  child: Text('Styled'),
)
```

---

## 5-7. Checkbox / Radio / Switch

### 핵심 개념

```dart
// Checkbox
Checkbox(
  value: _isChecked,
  onChanged: (bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  },
)

// Radio
Radio<String>(
  value: 'option1',
  groupValue: _selectedOption,
  onChanged: (String? value) {
    setState(() {
      _selectedOption = value;
    });
  },
)

// Switch
Switch(
  value: _isEnabled,
  onChanged: (bool value) {
    setState(() {
      _isEnabled = value;
    });
  },
)
```

---

## 5-8. Form / TextFormField / Validation

### 핵심 개념

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email';
          }
          if (!value.contains('@')) {
            return 'Please enter valid email';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          if (value == null || value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // 폼 유효성 통과
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Processing...')),
            );
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
)
```

---

## 5-9. Image

### 핵심 개념

```dart
// 네트워크 이미지
Image.network(
  'https://example.com/image.jpg',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator();
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);
  },
)

// 로컬 이미지 (assets)
Image.asset('assets/images/logo.png')

// 파일 이미지
Image.file(File('path/to/image.jpg'))
```

### pubspec.yaml
```yaml
flutter:
  assets:
    - assets/images/
```

---

## 5-10. Icon

### 핵심 개념

```dart
// 기본 아이콘
Icon(Icons.home)

// 스타일
Icon(
  Icons.favorite,
  color: Colors.red,
  size: 48,
)

// Material Icons: https://fonts.google.com/icons
```

---

## 5-11. Card

### 핵심 개념

```dart
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text('Card Title'),
        Text('Card content goes here'),
      ],
    ),
  ),
)
```

---

## 5-12. ListTile

### 핵심 개념

```dart
ListTile(
  leading: CircleAvatar(child: Text('A')),
  title: Text('Title'),
  subtitle: Text('Subtitle'),
  trailing: Icon(Icons.arrow_forward_ios),
  onTap: () {},
)
```

---

## 5-13. AppBar

### 핵심 개념

```dart
AppBar(
  leading: IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
  ),
  title: Text('My App'),
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
  bottom: TabBar(
    tabs: [
      Tab(text: 'Tab 1'),
      Tab(text: 'Tab 2'),
    ],
  ),
)
```

---

## 5-14. BottomNavigationBar

### 핵심 개념

```dart
class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

---

## 5-15. Drawer

### 핵심 개념

```dart
Scaffold(
  appBar: AppBar(title: Text('App')),
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text('Menu', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);  // Drawer 닫기
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {},
        ),
      ],
    ),
  ),
  body: Center(child: Text('Content')),
)
```

---

## 예제 파일
- `examples/list_grid.dart` - ListView, GridView 예제
- `examples/forms.dart` - 폼, 입력 위젯 예제
- `examples/navigation_widgets.dart` - AppBar, BottomNav, Drawer 예제

---

## 다음 단계
→ STEP 6: Flutter 네비게이션 (화면 이동, 라우팅)
