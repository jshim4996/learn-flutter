// STEP 8-1 ~ 8-5: HTTP 통신 및 JSON 파싱 예제

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// ========================================
// User 모델
// ========================================

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

// ========================================
// API 서비스
// ========================================

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET - 사용자 목록
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  // GET - 단일 사용자
  Future<User> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  // POST - 사용자 생성
  Future<User> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  // DELETE - 사용자 삭제
  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
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
      title: 'HTTP Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UsersScreen(),
    );
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _apiService.getUsers();
  }

  void _refresh() {
    setState(() {
      _usersFuture = _apiService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          // 로딩 중
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 에러
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // 데이터 표시
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user.name[0]),
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // 상세 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(userId: user.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: FutureBuilder<User>(
        future: ApiService().getUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${user.id}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
