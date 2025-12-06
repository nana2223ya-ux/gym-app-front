import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _selectedRole;

  final String baseUrl = "http://192.168.1.105:8000/api";
  // IP جهازك

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final role = _selectedRole ?? 'User';

    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      print('🔹 Response status: ${response.statusCode}');
      print('🔹 Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم التسجيل بنجاح')));
        Navigator.pushReplacementNamed(context, '/Home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('فشل التسجيل')));
      }
    } catch (e) {
      print('🔹 Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('فشل الاتصال بالخادم')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final orange = Colors.orangeAccent.shade700;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("إنشاء حساب جديد"),
        backgroundColor: orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "سجل حسابك الآن 👋",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "الاسم الكامل"),
                validator: (value) => value == null || value.isEmpty
                    ? "الرجاء إدخال الاسم"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "البريد الإلكتروني",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "الرجاء إدخال البريد الإلكتروني";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                    return "البريد الإلكتروني غير صالح";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "كلمة المرور"),
                validator: (value) => value != null && value.length < 6
                    ? "كلمة المرور قصيرة جدًا"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "تأكيد كلمة المرور",
                ),
                validator: (value) => value != _passwordController.text
                    ? "كلمة المرور غير متطابقة"
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "نوع الحساب"),
                items: const [
                  DropdownMenuItem(value: "User", child: Text("مستخدم")),
                  DropdownMenuItem(value: "coach", child: Text("مدرب")),
                ],
                value: _selectedRole,
                onChanged: (value) => setState(() => _selectedRole = value),
                validator: (value) =>
                    value == null ? "الرجاء اختيار نوع الحساب" : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                child: const Text("إنشاء الحساب"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
