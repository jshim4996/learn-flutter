// STEP 5-5 ~ 5-8: 입력 위젯과 폼 예제

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
        appBar: AppBar(title: const Text('Forms & Input')),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldExample(),
              SizedBox(height: 24),
              ButtonsExample(),
              SizedBox(height: 24),
              ToggleWidgetsExample(),
              SizedBox(height: 24),
              FormExample(),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================
// 5-5. TextField 예제
// ========================================

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  final _controller = TextEditingController();
  String _inputValue = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== TextField ===',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // 기본 TextField
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Username',
            hintText: 'Enter your username',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _inputValue = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Text('You typed: $_inputValue'),

        const SizedBox(height: 16),

        // 비밀번호 필드
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.visibility),
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 16),

        // 멀티라인
        const TextField(
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

// ========================================
// 5-6. Buttons 예제
// ========================================

class ButtonsExample extends StatelessWidget {
  const ButtonsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Buttons ===',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // 버튼 타입들
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // 스타일 버튼
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {},
          child: const Text('Styled Button'),
        ),

        const SizedBox(height: 8),

        // 아이콘 포함 버튼
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
        ),

        const SizedBox(height: 8),

        // 비활성화 버튼
        ElevatedButton(
          onPressed: null,  // null이면 비활성화
          child: const Text('Disabled'),
        ),
      ],
    );
  }
}

// ========================================
// 5-7. Toggle Widgets 예제
// ========================================

class ToggleWidgetsExample extends StatefulWidget {
  const ToggleWidgetsExample({super.key});

  @override
  State<ToggleWidgetsExample> createState() => _ToggleWidgetsExampleState();
}

class _ToggleWidgetsExampleState extends State<ToggleWidgetsExample> {
  bool _isChecked = false;
  bool _isSwitch = false;
  String? _selectedOption = 'option1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Toggle Widgets ===',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Checkbox
        CheckboxListTile(
          title: const Text('Checkbox Option'),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
        ),

        // Switch
        SwitchListTile(
          title: const Text('Switch Option'),
          value: _isSwitch,
          onChanged: (value) {
            setState(() {
              _isSwitch = value;
            });
          },
        ),

        const SizedBox(height: 8),

        // Radio
        const Text('Radio Options:'),
        RadioListTile<String>(
          title: const Text('Option 1'),
          value: 'option1',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Option 2'),
          value: 'option2',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value;
            });
          },
        ),

        Text('Selected: $_selectedOption'),
      ],
    );
  }
}

// ========================================
// 5-8. Form & Validation 예제
// ========================================

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processing: $_email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('=== Form & Validation ===',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        Form(
          key: _formKey,
          child: Column(
            children: [
              // Email 필드
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),

              const SizedBox(height: 16),

              // Password 필드
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),

              const SizedBox(height: 24),

              // Submit 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Submit'),
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
