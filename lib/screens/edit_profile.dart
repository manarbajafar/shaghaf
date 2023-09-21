import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/profile.dart';
import '../constatnt/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../models/user.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
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
                  User userData = snapshot.data as User;

                  //controllers to update values
                  final email = TextEditingController(text: userData.email);
                  final password =
                      TextEditingController(text: userData.password);
                  final name = TextEditingController(text: userData.name);

                  return Form(
                    key: _formKey,
                    child: Column(
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
                        CustomTextFormField(
                          controller: email,
                          validator: (value) {},
                          ispasswordType: false,
                          hasIcon: false,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, right: 5),
                          child: Text(
                            "كلمة المرور",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.TertiaryColor,
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          ispasswordType: true,
                          hasIcon: false,
                          controller: password,
                          validator: (value) {
                            if (value == null) {
                              print("error");
                            }
                          },
                        ),
                        CustomButton(
                          text: "حفظ التعديلات",
                          onPressed: () async{
                            final user = User(
                                uid: userData.uid,
                                email: email.text.trim(),
                                name: name.text.trim(),
                                password: password.text.trim());
                            await controller.updateUserData(user);
                            Get.to(() => Profile(
                                  pageTitle: 'حسابي',
                                ));
                          },
                          buttonColor: AppColor.primaryColor,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  print('line 128 ${snapshot.error.toString()}');
                  return Text(snapshot.error.toString());
                } else {
                  //to sovle this ERROR: The body might complete normally, causing 'null' to be returned, but the return type, 'Widget', is a potentially non-nullable type. Try adding either a return or a throw statement at the end.dartbody_might_complete_normally
                  return Text(snapshot.toString());
                  print('line 133 ${snapshot.error.toString()}');
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
