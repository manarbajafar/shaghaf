import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/signup.dart';
import '../constatnt/app_colors.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColor.primaryColor,
        ),
        title: Text(
          "تسجيل الدخول",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مرحباً بك",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                    "الرجاء إدخال عنوان البريد الإلكتروني وكلمة المرور لتسجيل الدخول",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hintText: "البريد الإلكتروني",
                  controller: controller.email,
                  validator: (value) {if (value == null) {
                      print("the field is empty");
                    }},
                ),
                CustomTextFormField(
                  hintText: "كلمة المرور",
                  controller: controller.password,
                  validator: (value) {
                    if (value == null) {
                      print("the field is empty");
                    }
                  },
                ),
                CustomButton(
                  text: "تسجيل الدخول",
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.login();
                    }
                  },
                  buttonColor: AppColor.primaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "لا تملك حساب؟",
                      style: TextStyle(color: AppColor.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.to(() => Signup());
                        },
                        child: const Text(
                          'سجل الآن',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
