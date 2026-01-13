// STEP 8-6 ~ 8-8: 로컬 저장소 예제
// 실행 전 pubspec.yaml에 추가: shared_preferences: ^2.2.0

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StorageScreen(),
    );
  }
}

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final _controller = TextEditingController();
  String _savedValue = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 데이터 불러오기
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedValue = prefs.getString('username') ?? '';
      _controller.text = _savedValue;
      _isLoading = false;
    });
  }

  // 데이터 저장
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controller.text);

    setState(() {
      _savedValue = _controller.text;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved!')),
      );
    }
  }

  // 데이터 삭제
  Future<void> _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');

    setState(() {
      _savedValue = '';
      _controller.clear();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cleared!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('SharedPreferences')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveData,
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clearData,
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stored Data:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _savedValue.isEmpty ? '(empty)' : _savedValue,
                      style: TextStyle(
                        color: _savedValue.isEmpty ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
