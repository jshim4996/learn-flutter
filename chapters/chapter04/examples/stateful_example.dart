// STEP 4-7 ~ 4-9: StatefulWidget 예제

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
        appBar: AppBar(title: const Text('StatefulWidget Examples')),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CounterWidget(),
              SizedBox(height: 24),
              ToggleWidget(),
              SizedBox(height: 24),
              TextInputWidget(),
              SizedBox(height: 24),
              ListManagerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================
// 기본 카운터
// ========================================

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Counter', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              '$_count',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                ),
                IconButton(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 토글 스위치
// ========================================

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({super.key});

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Toggle Switch', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isOn ? 'ON' : 'OFF',
                  style: TextStyle(
                    fontSize: 24,
                    color: _isOn ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Switch(
                  value: _isOn,
                  onChanged: (value) {
                    setState(() {
                      _isOn = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 텍스트 입력
// ========================================

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  void dispose() {
    _controller.dispose();  // 메모리 정리
    super.dispose();
  }

  void _updateText() {
    setState(() {
      _displayText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Text Input', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _displayText = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              'You typed: $_displayText',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 리스트 관리
// ========================================

class ListManagerWidget extends StatefulWidget {
  const ListManagerWidget({super.key});

  @override
  State<ListManagerWidget> createState() => _ListManagerWidgetState();
}

class _ListManagerWidgetState extends State<ListManagerWidget> {
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  int _counter = 3;

  void _addItem() {
    setState(() {
      _counter++;
      _items.add('Item $_counter');
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('List Manager', style: TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return ListTile(
                title: Text(item),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeItem(index),
                ),
              );
            }),
            if (_items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No items'),
              ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// 생명주기 예제
// ========================================

class LifecycleWidget extends StatefulWidget {
  const LifecycleWidget({super.key});

  @override
  State<LifecycleWidget> createState() => _LifecycleWidgetState();
}

class _LifecycleWidgetState extends State<LifecycleWidget> {
  String _status = 'initialized';

  @override
  void initState() {
    super.initState();
    print('initState called');
    // 초기 데이터 로드
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies called');
  }

  @override
  void didUpdateWidget(LifecycleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget called');
  }

  @override
  void dispose() {
    print('dispose called');
    // 리소스 정리
    super.dispose();
  }

  Future<void> _loadData() async {
    // 비동기 데이터 로드 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    // mounted 체크 - 위젯이 여전히 트리에 있는지 확인
    if (mounted) {
      setState(() {
        _status = 'data loaded';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build called');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Lifecycle', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Status: $_status'),
          ],
        ),
      ),
    );
  }
}
