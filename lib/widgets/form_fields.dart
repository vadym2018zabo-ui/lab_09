import 'package:flutter/material.dart';

/// Перевірка формату email
bool isValidEmail(String value) {
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
  return emailRegex.hasMatch(value);
}

/// Поле для логіну або email з валідацією
TextFormField loginOrEmailField({
  required TextEditingController controller,
  required String label,
  TextInputAction action = TextInputAction.next,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
    textInputAction: action,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Поле є обов’язковим';
      }
      final val = value.trim();
      if (val.contains('@') && !isValidEmail(val)) {
        return 'Невірний формат email';
      }
      return null;
    },
  );
}

/// Поле для паролю з валідацією довжини
TextFormField passwordField({
  required TextEditingController controller,
  String label = 'Пароль',
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
    obscureText: true,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Поле є обов’язковим';
      }
      if (value.length < 7) {
        return 'Пароль має містити щонайменше 7 символів';
      }
      return null;
    },
  );
}

/// Поле для імені користувача
TextFormField nameField({
  required TextEditingController controller,
  String label = 'Ім’я користувача',
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
    textInputAction: TextInputAction.next,
    validator: (value) =>
    (value == null || value.trim().isEmpty) ? 'Поле є обов’язковим' : null,
  );
}