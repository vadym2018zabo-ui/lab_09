import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/form_button.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  final _api = ApiService(baseUrl: 'https://lab_09-vadym.requestcatcher.com');

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Зберігаємо messenger ДО await
    final messenger = ScaffoldMessenger.of(context);

    final ok = await _api.sendForm('reset', {
      'email': _email.text.trim(),
      'timestamp': DateTime.now().toIso8601String(),
    });

    messenger.showSnackBar(
      SnackBar(content: Text(ok ? 'Reset sent' : 'Failed to send')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter email' : null,
              ),
              const SizedBox(height: 20),
              FormButton(label: 'Reset', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}