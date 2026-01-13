// STEP 4-10 ~ 4-16: 레이아웃 위젯 예제

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Layout Widgets')),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextExamples(),
              SizedBox(height: 24),
              ContainerExamples(),
              SizedBox(height: 24),
              RowColumnExamples(),
              SizedBox(height: 24),
              StackExamples(),
              SizedBox(height: 24),
              ExpandedFlexibleExamples(),
              SizedBox(height: 24),
              SpacingExamples(),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================
// 4-10. Text 예제
// ========================================

class TextExamples extends StatelessWidget {
  const TextExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Text Examples ===',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // 기본 텍스트
        const Text('Basic Text'),

        // 스타일 적용
        const Text(
          'Styled Text',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            letterSpacing: 2,
          ),
        ),

        // 테마 스타일
        Text(
          'Theme Headline',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        // 긴 텍스트 처리
        const Text(
          'This is a very long text that might overflow. We can use maxLines and overflow to handle this gracefully.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        // 텍스트 정렬
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Center Aligned',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ========================================
// 4-11. Container 예제
// ========================================

class ContainerExamples extends StatelessWidget {
  const ContainerExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Container Examples ===',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // 기본 컨테이너
        Container(
          width: 100,
          height: 50,
          color: Colors.blue,
          child: const Center(child: Text('Basic')),
        ),
        const SizedBox(height: 8),

        // BoxDecoration
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: const Center(child: Text('Decorated')),
        ),
        const SizedBox(height: 8),

        // 그림자
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(child: Text('Shadow')),
        ),
        const SizedBox(height: 8),

        // 그라데이션
        Container(
          width: 200,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('Gradient', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

// ========================================
// 4-12. Row / Column 예제
// ========================================

class RowColumnExamples extends StatelessWidget {
  const RowColumnExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Row / Column Examples ===',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Row - 기본
        const Text('Row (default):'),
        Row(
          children: [
            _box(Colors.red, 'A'),
            _box(Colors.green, 'B'),
            _box(Colors.blue, 'C'),
          ],
        ),
        const SizedBox(height: 8),

        // Row - spaceBetween
        const Text('Row (spaceBetween):'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _box(Colors.red, 'A'),
            _box(Colors.green, 'B'),
            _box(Colors.blue, 'C'),
          ],
        ),
        const SizedBox(height: 8),

        // Row - spaceEvenly
        const Text('Row (spaceEvenly):'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _box(Colors.red, 'A'),
            _box(Colors.green, 'B'),
            _box(Colors.blue, 'C'),
          ],
        ),
        const SizedBox(height: 8),

        // Column 예제
        const Text('Column (center):'),
        SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _box(Colors.red, '1'),
              _box(Colors.green, '2'),
              _box(Colors.blue, '3'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _box(Color color, String text) {
    return Container(
      width: 50,
      height: 40,
      color: color,
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

// ========================================
// 4-13. Stack 예제
// ========================================

class StackExamples extends StatelessWidget {
  const StackExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Stack Examples ===',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // 기본 Stack
        Stack(
          children: [
            Container(width: 200, height: 100, color: Colors.blue),
            Container(width: 150, height: 75, color: Colors.green),
            Container(width: 100, height: 50, color: Colors.red),
          ],
        ),
        const SizedBox(height: 16),

        // Positioned 사용
        SizedBox(
          width: 200,
          height: 100,
          child: Stack(
            children: [
              Container(color: Colors.grey.shade300),
              const Positioned(
                top: 10,
                left: 10,
                child: Icon(Icons.star, color: Colors.amber),
              ),
              const Positioned(
                bottom: 10,
                right: 10,
                child: Icon(Icons.favorite, color: Colors.red),
              ),
              const Center(
                child: Text('Centered'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 프로필 카드 예제
        SizedBox(
          width: 200,
          height: 120,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Center(child: Text('John Doe')),
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: Text('JD', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ========================================
// 4-14. Expanded / Flexible 예제
// ========================================

class ExpandedFlexibleExamples extends StatelessWidget {
  const ExpandedFlexibleExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Expanded / Flexible ===',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Expanded
        const Text('Expanded (fills remaining):'),
        Row(
          children: [
            Container(width: 50, height: 40, color: Colors.red),
            Expanded(
              child: Container(height: 40, color: Colors.green),
            ),
            Container(width: 50, height: 40, color: Colors.blue),
          ],
        ),
        const SizedBox(height: 8),

        // Expanded with flex
        const Text('Expanded with flex (1:2:1):'),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(height: 40, color: Colors.red),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 40, color: Colors.green),
            ),
            Expanded(
              flex: 1,
              child: Container(height: 40, color: Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Flexible
        const Text('Flexible (takes only needed space):'),
        Row(
          children: [
            Flexible(
              child: Container(
                height: 40,
                color: Colors.orange,
                child: const Text('Short'),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                height: 40,
                color: Colors.purple,
                child: const Text('Longer text here'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ========================================
// 4-15, 4-16. Spacing 예제
// ========================================

class SpacingExamples extends StatelessWidget {
  const SpacingExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== SizedBox / Padding ===',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // SizedBox as spacer
        Row(
          children: [
            Container(width: 50, height: 40, color: Colors.red),
            const SizedBox(width: 16),  // 간격
            Container(width: 50, height: 40, color: Colors.green),
            const SizedBox(width: 32),  // 더 큰 간격
            Container(width: 50, height: 40, color: Colors.blue),
          ],
        ),
        const SizedBox(height: 16),

        // Padding widget
        const Text('Padding widget:'),
        Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              color: Colors.blue,
              child: const Text('Padded content'),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // EdgeInsets variations
        const Text('EdgeInsets variations:'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _paddingDemo('all(8)', const EdgeInsets.all(8)),
            _paddingDemo('symmetric(h:16)', const EdgeInsets.symmetric(horizontal: 16)),
            _paddingDemo('only(left:20)', const EdgeInsets.only(left: 20)),
          ],
        ),
      ],
    );
  }

  Widget _paddingDemo(String label, EdgeInsets padding) {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: padding,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(4),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ),
      ),
    );
  }
}
