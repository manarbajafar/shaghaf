import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constatnt/app_colors.dart';
import '../controllers/signup_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColor.primaryColor,
        ),
        title: Text(
          "إنشاء حساب",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مرحباً بك",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text("الرجاء إدخال المعلومات الخاصة بك لإنشاء حسابك",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hintText: "اسم المستخدم",
                  controller: controller.name,
                  validator: (value) {},
                  ispasswordType: false,
                  hasIcon: false,
                ),
                CustomTextFormField(
                  hintText: "البريد الإلكتروني",
                  controller: controller.email,
                  validator: (value) {},
                  ispasswordType: false,
                  hasIcon: false,
                ),
                CustomTextFormField(
                  hintText: "كلمة المرور",
                  ispasswordType: true,
                  hasIcon: false,
                  controller: controller.password,
                  validator: (value) {
                    if (value == null) {
                      print("error");
                    }
                  },
                ),
                CustomButton(
                  text: "إنشاء حساب",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUpController.instance.registerUser(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                    }
                  },
                  buttonColor: AppColor.primaryColor,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
