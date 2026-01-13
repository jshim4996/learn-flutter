// STEP 7-3: Provider 기본 예제
// 실행 전 pubspec.yaml에 추가: provider: ^6.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Provider로 앱 감싸기
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

// ========================================
// 상태 클래스들
// ========================================

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class ThemeNotifier with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get theme => _isDark ? ThemeData.dark() : ThemeData.light();

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

// ========================================
// 앱
// ========================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // watch: 상태 변경 시 리빌드
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp(
      title: 'Provider Demo',
      theme: themeNotifier.theme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Example'),
        actions: [
          // 테마 토글
          IconButton(
            icon: Icon(
              context.watch<ThemeNotifier>().isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              // read: 리빌드 없이 메서드 호출
              context.read<ThemeNotifier>().toggle();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter 표시
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.count}',
                  style: const TextStyle(fontSize: 72),
                );
              },
            ),
            const SizedBox(height: 32),

            // 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.remove),
                  onPressed: () => context.read<Counter>().decrement(),
                ),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<Counter>().reset(),
                ),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.add),
                  onPressed: () => context.read<Counter>().increment(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
