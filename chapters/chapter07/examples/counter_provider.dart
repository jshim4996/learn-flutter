// STEP 7-3: Provider 실전 패턴 예제

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

// ========================================
// Todo 모델
// ========================================

class Todo {
  final String id;
  final String title;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}

// ========================================
// Todo Provider
// ========================================

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  List<Todo> get completedTodos => _todos.where((t) => t.isCompleted).toList();
  List<Todo> get pendingTodos => _todos.where((t) => !t.isCompleted).toList();

  int get totalCount => _todos.length;
  int get completedCount => completedTodos.length;

  void add(String title) {
    _todos.add(Todo(
      id: DateTime.now().toString(),
      title: title,
    ));
    notifyListeners();
  }

  void remove(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggle(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
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
    return MaterialApp(
      title: 'Todo with Provider',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          // Selector: 특정 값만 구독
          Selector<TodoProvider, int>(
            selector: (_, provider) => provider.completedCount,
            builder: (context, count, _) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text('Done: $count'),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.todos.isEmpty) {
            return const Center(child: Text('No todos yet'));
          }

          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return ListTile(
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => todoProvider.toggle(todo.id),
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => todoProvider.remove(todo.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter todo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<TodoProvider>().add(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
