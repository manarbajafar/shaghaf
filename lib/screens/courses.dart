import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constatnt/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/course_card.dart';

class Courses extends StatelessWidget {
  String categoryName = 'اسم الفئة';
  final HomeController controller = Get.put(HomeController());
  Courses({super.key, required this.categoryName});

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
            categoryName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: ListView.builder(
              itemCount: HomeController.courses.length,
              itemBuilder: (context, i) =>
                  HomeController.courses[i].category == categoryName
                      ? CourseCard(
                          title: HomeController.courses[i].title,
                          presenter: HomeController.courses[i].presenter,
                          price: HomeController.courses[i].price,
                          imageUrl: HomeController.courses[i].imageUrl,
                          registerOnPressed: (() => controller
                              .registerInCourse(HomeController.courses[i].id!)),
                          isRegistered:
                              controller.isCourseinUserRegisteredCourses(
                                  HomeController.courses[i].id!),
                          isFavorite: 0, //temp
                        )
                      : Container()),
        ));
  }
}
