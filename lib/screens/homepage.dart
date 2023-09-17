import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constatnt/app_colors.dart';
import '../widgets/custom_button.dart';

class Homepage extends StatelessWidget {
  logout() {
    FirebaseAuth.instance.signOut();
  }

  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "homepage",
            style: TextStyle(fontSize: 40),
          ),
          CustomButton(
            text: "تسجيل الخروج",
            onPressed: logout,
            buttonColor: AppColor.primaryColor,
          ),
        ],
      ),
    );
  }
}
