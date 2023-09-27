import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shaghaf_app/models/course_model.dart';

import 'auth_controller.dart';
import 'profile_controller.dart';

class HomeController extends GetxController {
  final _auth_controller = Get.put(AuthController());
  final _profile_controller = Get.put(ProfileController());

  var selectedValue_levels = 'الكل'.obs;
  var selectedValue_categories = 'الكل'.obs;
  var selectedValue_types = 'الكل'.obs;
  final _db = FirebaseFirestore.instance;
  static List<CourseModel> courses = [];
  static bool on_home = true;

  List categories = [
    {'iconeName': Icons.laptop, 'title': 'الحاسب الآلي'},
    {'iconeName': Icons.attach_money, 'title': 'إدارة الأعمال'},
    {'iconeName': Icons.brush, 'title': 'الفن'},
    {'iconeName': Icons.language, 'title': 'اللغات'}
  ];

  void updateSelectedValue_levels(String value) {
    selectedValue_levels.value = value;
  }

  void updateSelectedValue_categories(String value) {
    selectedValue_categories.value = value;
  }

  void updateSelectedValue_types(String value) {
    selectedValue_types.value = value;
  }

//get courses from API
  Future getCourses() async {
    if (on_home) {
      courses
          .clear(); //So that the elements are not repeated whenever we return to the homepage
      var url = Uri.parse(
          "https://run.mocky.io/v3/6c6f00a9-5bca-4186-b73d-b5b27773b059");
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);

      //make it a List of CourseModel object
      for (var eachCourse in jsonData) {
        final course = CourseModel(
          id: eachCourse['id'],
          title: eachCourse['title'],
          presenter: eachCourse['presenter'],
          category: eachCourse['category'],
          imageUrl: eachCourse['imageUrl'],
          level: eachCourse['level'],
          place: eachCourse['place'],
          price: eachCourse['price'],
        );
        courses.add(course);
      }
      await _profile_controller.getRegisterdCourses();
      print('courses.length: ${courses.length}');
      update();
    }
  }

  registerInCourse(int courseId) async {
    await _db
        .collection('users')
        .doc(_auth_controller.firebaseUser.value!.uid)
        .set({
      "registered_courses": FieldValue.arrayUnion([
        {
          'courseId': courseId,
          'status': false,
        }
      ])
    }, SetOptions(merge: true));
  }

  bool isCourseinUserRegisteredCourses(int courseId) {
    print(
        'ProfileController.registeredCourses: ${ProfileController.registeredCourses}');
    for (var registeredCourse in ProfileController.registeredCourses) {
      if (courseId == registeredCourse.id) {
        update();
        return true;
      }
    }
    update();
    return false;
  }
}
