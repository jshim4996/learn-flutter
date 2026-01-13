// STEP 6-1 ~ 6-3: Navigator 기본 예제

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
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
            // 6-1. 기본 push
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(title: 'Detail'),
                  ),
                );
              },
              child: const Text('Go to Detail (push)'),
            ),
            const SizedBox(height: 16),

            // 6-3. 데이터 전달
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(
                      title: 'With Data',
                      data: {'id': 123, 'content': 'Hello'},
                    ),
                  ),
                );
              },
              child: const Text('Go with Data'),
            ),
            const SizedBox(height: 16),

            // 결과 받기
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionPage(),
                  ),
                );

                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $result')),
                  );
                }
              },
              child: const Text('Select and Return'),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 상세 페이지
// ========================================

class DetailPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic>? data;

  const DetailPage({
    super.key,
    required this.title,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: $title', style: const TextStyle(fontSize: 24)),
            if (data != null) ...[
              const SizedBox(height: 16),
              Text('Data: $data'),
            ],
            const SizedBox(height: 32),

            // 6-1. pop으로 돌아가기
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
// 선택 페이지 (결과 반환)
// ========================================

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Option')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Option A'),
            onTap: () => Navigator.pop(context, 'Option A'),
          ),
          ListTile(
            title: const Text('Option B'),
            onTap: () => Navigator.pop(context, 'Option B'),
          ),
          ListTile(
            title: const Text('Option C'),
            onTap: () => Navigator.pop(context, 'Option C'),
          ),
          ListTile(
            title: const Text('Cancel'),
            onTap: () => Navigator.pop(context),  // null 반환
          ),
        ],
      ),
    );
  }
}
