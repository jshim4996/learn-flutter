# STEP 9. 실무 기능

> 앱 출시를 위한 필수 기능들 - 인증, 푸시 알림, 배포

---

## 학습 목표
- JWT 기반 인증 구현
- 푸시 알림 설정
- 앱 스토어 배포

---

## 9-1. JWT 토큰 저장

### 핵심 개념

```dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _tokenKey = 'jwt_token';
  static const _refreshTokenKey = 'refresh_token';

  // 토큰 저장
  Future<void> saveTokens(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  // 토큰 읽기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // 로그아웃
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
```

### 보안 저장 (flutter_secure_storage)
```yaml
dependencies:
  flutter_secure_storage: ^9.0.0
```

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

// 암호화 저장
await storage.write(key: 'token', value: token);
String? token = await storage.read(key: 'token');
await storage.delete(key: 'token');
```

---

## 9-2. 토큰 자동 갱신

### 핵심 개념

Dio 인터셉터 활용:

```dart
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AuthService authService;

  AuthInterceptor(this.dio, this.authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // 토큰 갱신 시도
      try {
        final newToken = await _refreshToken();
        await authService.saveTokens(newToken, refreshToken);

        // 실패한 요청 재시도
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        final response = await dio.fetch(opts);
        handler.resolve(response);
        return;
      } catch (e) {
        // 갱신 실패 - 로그아웃
        await authService.logout();
      }
    }
    handler.next(err);
  }

  Future<String> _refreshToken() async {
    final refreshToken = await authService.getRefreshToken();
    final response = await dio.post('/auth/refresh', data: {
      'refreshToken': refreshToken,
    });
    return response.data['token'];
  }
}
```

---

## 9-3. 로그인 상태 유지

### 핵심 개념

앱 시작 시 토큰 확인:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: AuthService().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }

          if (snapshot.data == true) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
```

### Provider와 함께
```dart
class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user;

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  Future<void> checkAuth() async {
    final token = await AuthService().getToken();
    if (token != null) {
      _user = await _fetchUserProfile(token);
      _isLoggedIn = true;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // 로그인 API 호출
    final response = await api.login(email, password);
    await AuthService().saveTokens(response.token, response.refreshToken);
    _user = response.user;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService().logout();
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
```

---

## 9-4. Firebase Cloud Messaging (FCM)

### 핵심 개념

```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_messaging: ^14.7.0
```

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

// 백그라운드 핸들러 (main 밖에 정의)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 백그라운드 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

// 초기화
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // 권한 요청
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // FCM 토큰 가져오기
      String? token = await _messaging.getToken();
      print('FCM Token: $token');

      // 토큰 서버로 전송
      await _sendTokenToServer(token);
    }

    // 포그라운드 메시지 수신
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
    });

    // 앱이 백그라운드에서 열렸을 때
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.data}');
    });
  }
}
```

---

## 9-5. 로컬 알림

### 핵심 개념

```yaml
dependencies:
  flutter_local_notifications: ^16.1.0
```

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

// 알림 표시
Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Channel Name',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}
```

---

## 9-6. 이미지 처리

### 핵심 개념

```yaml
dependencies:
  image_picker: ^1.0.4
  cached_network_image: ^3.3.0
```

```dart
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

// 갤러리에서 선택
Future<void> pickImage() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    // 이미지 사용
    print(image.path);
  }
}

// 카메라로 촬영
Future<void> takePhoto() async {
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
}

// 캐시된 네트워크 이미지
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

---

## 9-7. 권한 요청 (permission_handler)

### 핵심 개념

```yaml
dependencies:
  permission_handler: ^11.0.0
```

```dart
import 'package:permission_handler/permission_handler.dart';

// 카메라 권한 요청
Future<bool> requestCameraPermission() async {
  var status = await Permission.camera.status;

  if (status.isDenied) {
    status = await Permission.camera.request();
  }

  if (status.isPermanentlyDenied) {
    // 설정으로 이동
    await openAppSettings();
    return false;
  }

  return status.isGranted;
}

// 여러 권한 한번에
Future<void> requestMultiplePermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.photos,
    Permission.location,
  ].request();
}
```

---

## 9-8. 앱 배포 (Android/iOS)

### Android 배포

```bash
# 릴리즈 빌드
flutter build apk --release
flutter build appbundle --release  # Play Store 권장

# 서명 설정 (android/key.properties)
storePassword=your_password
keyPassword=your_password
keyAlias=upload
storeFile=/path/to/keystore.jks
```

### iOS 배포

```bash
# 릴리즈 빌드
flutter build ios --release

# Xcode에서 Archive
# Product > Archive > Distribute App
```

### 체크리스트
- [ ] 앱 아이콘 설정
- [ ] 스플래시 화면
- [ ] 버전 번호 업데이트
- [ ] 프로가드/난독화 설정
- [ ] 테스트 완료
- [ ] 스크린샷 준비
- [ ] 앱 설명 작성

---

## 예제 파일
- `examples/auth_example.dart` - 인증 플로우 예제

---

## 다음 단계
→ STEP 10: 실전 프로젝트 (카톨릭 기도앱)
