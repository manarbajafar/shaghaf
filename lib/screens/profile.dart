import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

import '../widgets/userCourses_card.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {
  late String pageTitle;

  // This section is temporary until I finish the design and move to backend :)
  String userName = 'Manar Bajafar';

  List registeredcourses = [
    {
      'title': 'مقدمة في الذكاء الاصطناعي',
      'price': 100,
      'status': false,
      'imageUrl': 'images/intro.jpg'
    },
    {
      'title': 'تحليل البيانات باستخدام الاكسل',
      'price': 100,
      'status': true,
      'imageUrl': 'images/intro.jpg'
    },
  ];

  logout() {
    FirebaseAuth.instance.signOut();
  }
  //

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
                          onPressed: () => logout(), // from auth
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
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
                      children: [
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
                                ImageIcon(
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
                                ImageIcon(
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                              alignment: AlignmentDirectional(1.00, 0.00),
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
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: registeredcourses.length,
                        itemBuilder: (context, i) {
                          return UserCoursesCard(
                            coursePrice: registeredcourses[i]['price'],
                            status: registeredcourses[i]['status'],
                            courseTitle: registeredcourses[i]['title'],
                            courseImage:
                                registeredcourses[i]['imageUrl'].toString(),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
