import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';
import 'package:shaghaf_app/screens/login.dart';

import '../widgets/custom_button.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/logo.png',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Text(
                'هو تطبيق لدعم الأشخاص الذين يبحثون عن الهوايات والشغف الخاص بهم، يحتوي على العديد من الدورات التي يحاول بها المستخدم تحقيق هدفه النهائي المتمثل في عيش شغفه واكتشاف مواهبه الخفية.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.backgroundColor,
                ),
              ),
            ),
            CustomButton(
              text: "تسجيل الدخول",
              onPressed: () {
                Get.to(() => Login());
              },
              buttonColor: AppColor.backgroundColor,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {},
                child: const Text(
                  'الدخول كزائر',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColor.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
