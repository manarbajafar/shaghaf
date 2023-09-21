import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  void registerUser(String email, String password) async {
    String? error = await AuthController.instance
        .signUp(email, password, name.text) as String?;

    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }
}

class SignUpFailure {
  final String message;
  const SignUpFailure([this.message = 'حدث خطأ غير معروف']);

  factory SignUpFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpFailure(
            'الرجاء ادخال كلمة مرور تتكون من 6 حروف أو أكثر');
      case 'invalid-email':
        return const SignUpFailure('البريد الإلكتروني غير صالح');
      case 'email-already-in-use':
        return const SignUpFailure(
            'البريد الإلكتروني مستخدم سابقًا، الرجاء إدخال بريد إلكتروني آخر');
      default:
        return const SignUpFailure();
    }
  }
}
