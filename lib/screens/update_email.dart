import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/profile.dart';
import '../constatnt/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../models/user.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';
import 'homepage.dart';

class UpdateEmail extends StatelessWidget {
  final password = TextEditingController();
  final new_email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColor.primaryColor,
        ),
        title: Text(
          "تعديل البريد الإلكتروني",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CustomTextFormField(
              hintText: "البريد الإلكتروني الجديد",
              controller: new_email,
              validator: (value) {},
              ispasswordType: false,
              hasIcon: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              hintText: "كلمة المرور",
              controller: password,
              validator: (value) {},
              ispasswordType: true,
              hasIcon: false,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "حفظ",
              onPressed: () async {
                await controller.updateUseremailData(
                    new_email.text, password.text);

                Get.to(() => Homepage());
              },
              buttonColor: AppColor.primaryColor,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
