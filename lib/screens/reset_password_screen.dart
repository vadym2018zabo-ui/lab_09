// lib/screens/reset_password_screen.dart
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginCtrl = TextEditingController();

  @override
  void dispose() {
    _loginCtrl.dispose();
    super.dispose();
  }

  bool _isEmail(String value) {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    return emailRegex.hasMatch(value);
  }

  void _reset() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Лист для відновлення надіслано на: ${_loginCtrl.text.trim()} (демо)')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Відновлення паролю')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _loginCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Логін або Email',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Поле є обов’язковим';
                    final val = v.trim();
                    if (val.contains('@') && !_isEmail(val)) {
                      return 'Невірний формат email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('Скинути пароль'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Повернутися до авторизації'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}