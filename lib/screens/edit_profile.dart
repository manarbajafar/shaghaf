import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/profile.dart';
import 'package:shaghaf_app/screens/update_email.dart';
import 'package:shaghaf_app/screens/update_password.dart';
import '../constatnt/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';
import 'homepage.dart';

class EditProfile extends StatelessWidget {
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
          "تعديل الحساب",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  //controllers to update values
                  final email = TextEditingController(text: userData.email);
                  final name = TextEditingController(text: userData.name);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          "اسم المستخدم",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.TertiaryColor,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: name,
                        validator: (value) {},
                        ispasswordType: false,
                        hasIcon: false,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, right: 5),
                        child: Text(
                          "البريد الإلكتروني",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.TertiaryColor,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          CustomTextFormField(
                            controller: email,
                            validator: (value) {},
                            isEmailOrPasswordForUpdate: true,
                            ispasswordType: false,
                            hasIcon: false,
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 5.0,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              iconSize: 20,
                              color: AppColor.primaryColor,
                              onPressed: () {
                                Get.to(() => UpdateEmail());
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.to(() => UpdatePassword());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.edit,
                                color: AppColor.TertiaryColor,
                              ),
                              Text(
                                'تغيير كلمة المرور',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.TertiaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        text: "حفظ التعديلات",
                        onPressed: () async {
                          final user = UserModel(
                            uid: userData.uid,
                            email: email.text.trim(),
                            name: name.text.trim(),
                          );
                          await controller.updateUserName(user.name);
                          Get.to(() => Homepage());
                        },
                        buttonColor: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print('line 128 ${snapshot.error.toString()}');
                  return Text(snapshot.error.toString());
                } else {
                  //to sovle this ERROR: The body might complete normally, causing 'null' to be returned, but the return type, 'Widget', is a potentially non-nullable type. Try adding either a return or a throw statement at the end.dartbody_might_complete_normally
                  return Text(snapshot.toString());
                }
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
