# STEP 8. API 통신

> Node.js/Express 경험자를 위한 Flutter HTTP 통신과 데이터 저장

---

## 학습 목표
- HTTP 요청 (GET, POST, PUT, DELETE)
- JSON 파싱과 모델 클래스
- 로컬 데이터 저장

---

## 8-1. http 패키지

### 핵심 개념

```yaml
dependencies:
  http: ^1.1.0
```

```dart
import 'package:http/http.dart' as http;

// GET 요청
Future<void> fetchData() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/data'),
    headers: {'Authorization': 'Bearer token'},
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed: ${response.statusCode}');
  }
}
```

---

## 8-2. dio 패키지

### 핵심 개념

더 강력한 HTTP 클라이언트:

```yaml
dependencies:
  dio: ^5.3.0
```

```dart
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: Duration(seconds: 5),
  headers: {'Authorization': 'Bearer token'},
));

// GET
final response = await dio.get('/users');

// 인터셉터 (Axios와 유사)
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    print('Request: ${options.path}');
    handler.next(options);
  },
  onError: (error, handler) {
    print('Error: ${error.message}');
    handler.next(error);
  },
));
```

---

## 8-3. GET / POST / PUT / DELETE

### 핵심 개념

```dart
// GET
final response = await dio.get('/users');

// POST
final response = await dio.post('/users', data: {
  'name': 'John',
  'email': 'john@example.com',
});

// PUT
final response = await dio.put('/users/1', data: {
  'name': 'John Updated',
});

// DELETE
final response = await dio.delete('/users/1');
```

### Node.js/Axios와 비교
```javascript
// Axios (Node.js)
const response = await axios.post('/users', { name: 'John' });

// Dart (dio)
final response = await dio.post('/users', data: {'name': 'John'});
```

---

## 8-4. JSON 파싱

### 핵심 개념

```dart
import 'dart:convert';

// JSON 문자열 → Map
String jsonString = '{"name": "John", "age": 30}';
Map<String, dynamic> data = jsonDecode(jsonString);

// Map → JSON 문자열
String json = jsonEncode({'name': 'John', 'age': 30});

// API 응답 파싱
final response = await dio.get('/users');
List<dynamic> users = response.data;  // dio는 자동 파싱
```

---

## 8-5. 모델 클래스 생성

### 핵심 개념

```dart
class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  // JSON → 객체
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

// 사용
final response = await dio.get('/users');
final users = (response.data as List)
    .map((json) => User.fromJson(json))
    .toList();
```

### 자동 생성 (json_serializable)
```yaml
dependencies:
  json_annotation: ^4.8.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
```

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// 실행: flutter pub run build_runner build
```

---

## 8-6. SharedPreferences

### 핵심 개념

간단한 키-값 저장:

```yaml
dependencies:
  shared_preferences: ^2.2.0
```

```dart
import 'package:shared_preferences/shared_preferences.dart';

// 저장
final prefs = await SharedPreferences.getInstance();
await prefs.setString('username', 'John');
await prefs.setInt('userId', 123);
await prefs.setBool('isLoggedIn', true);

// 읽기
String? username = prefs.getString('username');
int? userId = prefs.getInt('userId');
bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

// 삭제
await prefs.remove('username');
await prefs.clear();  // 전체 삭제
```

### 용도
- 로그인 토큰 저장
- 사용자 설정
- 간단한 캐시

---

## 8-7. SQLite (sqflite)

### 핵심 개념

로컬 데이터베이스:

```yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.0
```

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// 데이터베이스 열기
final database = await openDatabase(
  join(await getDatabasesPath(), 'app.db'),
  onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT)',
    );
  },
  version: 1,
);

// INSERT
await database.insert('users', {'name': 'John', 'email': 'john@email.com'});

// SELECT
final List<Map> users = await database.query('users');

// UPDATE
await database.update('users', {'name': 'John Updated'},
    where: 'id = ?', whereArgs: [1]);

// DELETE
await database.delete('users', where: 'id = ?', whereArgs: [1]);
```

---

## 8-8. Hive

### 핵심 개념

빠른 NoSQL 저장소:

```yaml
dependencies:
  hive: ^2.2.0
  hive_flutter: ^1.1.0
```

```dart
import 'package:hive_flutter/hive_flutter.dart';

// 초기화
await Hive.initFlutter();
var box = await Hive.openBox('myBox');

// 저장
box.put('name', 'John');
box.put('user', {'id': 1, 'name': 'John'});

// 읽기
String name = box.get('name');
var user = box.get('user');

// 삭제
box.delete('name');
```

---

## 저장소 비교

| 저장소 | 용도 | 특징 |
|-------|------|------|
| SharedPreferences | 설정, 토큰 | 간단한 키-값 |
| SQLite | 복잡한 데이터 | 관계형, SQL 쿼리 |
| Hive | 빠른 캐시 | NoSQL, 빠름 |

---

## 예제 파일
- `examples/http_example.dart` - HTTP 통신 예제
- `examples/storage_example.dart` - 로컬 저장소 예제

---

## 다음 단계
→ STEP 9: 실무 기능 (인증, 푸시 알림, 배포)
