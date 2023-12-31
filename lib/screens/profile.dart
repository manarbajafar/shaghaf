import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

import '../controllers/profile_controller.dart';
import '../models/user_model.dart';
import '../widgets/userCourses_card.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {
  late String pageTitle;
  final controller = Get.put(ProfileController());

  Profile({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 40, 0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      pageTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  iconSize: 32,
                  color: AppColor.primaryColor,
                  onPressed: () {
                    Get.defaultDialog(
                      title: "تسجيل الخروج",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("هل أنت متأكد أنك تريد تسجيل خروجك؟"),
                      ),
                      cancel: OutlinedButton(
                          onPressed: () => Get.back(), child: const Text("لا")),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.logout(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.ErrorColor,
                              side: BorderSide.none),
                          child: const Text("نعم"),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Icon(
                      Icons.account_circle,
                      color: AppColor.grey,
                      size: 150,
                    ),
                  ),
                  GetBuilder<ProfileController>(
                      init: ProfileController(),
                      builder: (value) {
                        return Text(
                          '${value.userName}',
                          style: Theme.of(context).textTheme.titleMedium,
                        );
                      }),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Get.to(() => EditProfile());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.edit,
                          color: AppColor.grey,
                        ),
                        Text(
                          'تعديل الحساب',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: AppColor.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: AppColor.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const ImageIcon(
                                  AssetImage(
                                    'images/course_icon.png',
                                  ),
                                  size: 42,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text('دورات',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: AppColor.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const ImageIcon(
                                  AssetImage(
                                    'images/certificate_icon.png',
                                  ),
                                  size: 42,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text('شهادات',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: AppColor.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الدورات المسجلة',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.00, 0.00),
                              child: Text(
                                'حالة التسجيل',
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (!controller.isLoadingData.value) {
                      int registeredCoursesLength =
                          ProfileController.registeredCourses.length;
                      return registeredCoursesLength > 0
                          ? SizedBox(
                              height: 200,
                              child: GetBuilder<ProfileController>(
                                  builder: (context) => ListView.builder(
                                      itemCount: registeredCoursesLength,
                                      itemBuilder: (context, i) {
                                        return UserCoursesCard(
                                          coursePrice: ProfileController
                                              .registeredCourses[i].price!,
                                          status: controller
                                                  .registeredcoursesIDsandStauts[
                                              i]['status'],
                                          courseTitle: ProfileController
                                              .registeredCourses[i].title!,
                                          courseImage: ProfileController
                                              .registeredCourses[i].imageUrl!,
                                          completePaymentOnPressed: () async {
                                            await controller.completePayment(
                                                ProfileController
                                                    .registeredCourses[i].id!);
                                          },
                                        );
                                      })),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "لا توجد دورات مسجلة",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
