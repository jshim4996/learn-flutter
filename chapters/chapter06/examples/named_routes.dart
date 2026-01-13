// STEP 6-2 ~ 6-3: Named Routes 예제

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ========================================
// Arguments 클래스 정의
// ========================================

class DetailArguments {
  final int id;
  final String title;

  DetailArguments({required this.id, required this.title});
}

// ========================================
// 앱 설정 - Named Routes
// ========================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      theme: ThemeData(primarySwatch: Colors.blue),

      // 초기 라우트
      initialRoute: '/',

      // 라우트 정의
      routes: {
        '/': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(),
        '/settings': (context) => const SettingsPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

// ========================================
// 홈 페이지
// ========================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // pushNamed
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: const Text('Go to Detail'),
            ),
            const SizedBox(height: 16),

            // Arguments와 함께
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: DetailArguments(id: 123, title: 'My Post'),
                );
              },
              child: const Text('Go to Detail with Args'),
            ),
            const SizedBox(height: 16),

            // Settings
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 상세 페이지 (arguments 수신)
// ========================================

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Arguments 추출
    final args = ModalRoute.of(context)?.settings.arguments;

    String displayText = 'No arguments';
    if (args is DetailArguments) {
      displayText = 'ID: ${args.id}, Title: ${args.title}';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(displayText, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 설정 페이지
// ========================================

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // 모든 화면 제거하고 홈으로
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ========================================
// 프로필 페이지
// ========================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text('John Doe', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 32),

            // pushReplacementNamed - 현재 화면 교체
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
              child: const Text('Replace with Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
