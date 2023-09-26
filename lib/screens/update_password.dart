import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/homepage.dart';
import 'package:shaghaf_app/screens/profile.dart';
import '../constatnt/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';

class UpdatePassword extends StatelessWidget {
  final old_password = TextEditingController();
  final new_password = TextEditingController();
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
          "تعديل كلمة المرور",
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
              hintText: "كلمة المرور القديمة",
              controller: old_password,
              validator: (value) {},
              ispasswordType: true,
              hasIcon: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              hintText: "كلمة المرور الجديدة",
              controller: new_password,
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
                await controller.updateUserPasswordData(
                    new_password.text, old_password.text);
                print('تم تغير كلمة المرور');
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
