import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login() async {
    String? error = await AuthController.instance
        .login(email.text.trim(), password.text.trim());
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }
}

class LogInFailure {
  final String message;
  const LogInFailure(
      [this.message = 'الرجاء تعبئة الخانات قبل الضغط على زر تسجيل الدخول']);

  factory LogInFailure.code(String code) {
    switch (code) {
      case 'wrong-password':
        return const LogInFailure('كلمة المرور غير صحيحة');
      case 'invalid-email':
        return const LogInFailure('البريد الإلكتروني غير صالح');
      case 'user-not-found':
        return const LogInFailure('لا يوجد حساب مسجل بهذا البريد الإلكتروني');
      default:
        return const LogInFailure();
    }
  }
}
