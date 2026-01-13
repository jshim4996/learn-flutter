// STEP 4-1 ~ 4-9: 기본 앱 구조

import 'package:flutter/material.dart';

// ========================================
// 앱 진입점
// ========================================

void main() {
  runApp(const MyApp());
}

// ========================================
// MaterialApp 설정
// ========================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ========================================
// Scaffold 기본 구조
// ========================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바
      appBar: AppBar(
        title: const Text('My App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),

      // 본문
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Greeting(name: 'Developer'),
          ],
        ),
      ),

      // 플로팅 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      // 하단 네비게이션
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ========================================
// StatelessWidget 예제
// ========================================

class Greeting extends StatelessWidget {
  // Props (생성자 매개변수)
  final String name;

  // const 생성자
  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Welcome, $name!',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ========================================
// BuildContext 활용
// ========================================

class ContextExample extends StatelessWidget {
  const ContextExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme 접근
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // MediaQuery 접근
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Container(
      color: colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Theme Primary: ${colorScheme.primary}',
            style: theme.textTheme.bodyLarge,
          ),
          Text('Screen: ${screenWidth.toInt()} x ${screenHeight.toInt()}'),
        ],
      ),
    );
  }
}

// ========================================
// 여러 StatelessWidget 조합
// ========================================

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 아바타
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: avatarUrl == null ? Text(name[0]) : null,
            ),
            const SizedBox(width: 16),
            // 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            // 액션
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
