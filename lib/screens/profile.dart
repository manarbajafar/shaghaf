import 'package:flutter/material.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

import '../widgets/registeredCourses_card.dart';

class Profile extends StatelessWidget {
  //
  late String pageTitle;

  String userName = 'Manar Bajafar';

  List registeredcourses = [
    {'title': 'مقدمة في الذكاء الاصطناعي', 'price': 100, 'status': false},
    {'title': 'تحليل البيانات باستخدام الاكسل', 'price': 100, 'status': true},
  ];
  //

  Profile({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  pageTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.logout,
                size: 32,
                color: AppColor.primaryColor,
              ),
            ],
          ),
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
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit),
                Text(
                  'تعديل الحساب',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text('دورات',
                                style: Theme.of(context).textTheme.titleMedium)
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text('شهادات',
                                style: Theme.of(context).textTheme.titleMedium)
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
                  return RegisteredCoursesCard(
                    coursePrice: registeredcourses[i]['price'],
                    status: registeredcourses[i]['status'],
                    courseTitle: registeredcourses[i]['title'],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
