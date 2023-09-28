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
  Rx<List<CourseModel>> found_courses = Rx<List<CourseModel>>([]);
  RxBool isOnChangedActive = false.obs;
  static bool on_home = true;

  List categories = [
    {'iconeName': Icons.laptop, 'title': 'الحاسب الآلي'},
    {'iconeName': Icons.attach_money, 'title': 'إدارة الأعمال'},
    {'iconeName': Icons.brush, 'title': 'الفن'},
    {'iconeName': Icons.language, 'title': 'اللغات'}
  ];

  @override
  void onInit() {
    super.onInit();
    found_courses.value = courses;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchCoursebyTextField(String searchText) {
    found_courses.value.clear();
    List<CourseModel> results = [];
    if (searchText.isEmpty) {
      results = courses;
    } else {
      results = courses
          .where((element) =>
              element.title.toString().toLowerCase().contains(searchText) ||
              element.presenter.toString().toLowerCase().contains(searchText))
          .toList();
    }
    found_courses.value = results;
  }

//needs modification
  void filterCourse() {
    found_courses.value.clear();
    List<CourseModel> results = [];
    if (selectedValue_levels.value == 'الكل' &&
        selectedValue_types.value == 'الكل' &&
        selectedValue_categories.value == 'الكل') {
      isOnChangedActive.value = false;
      results = courses;
    } else {
      isOnChangedActive.value = true;
      results = courses
          .where((element) =>
              element.category == selectedValue_categories.value ||
              element.level == selectedValue_levels.value ||
              element.place.toString().contains(selectedValue_types.value))
          .toList();
    }
    found_courses.value = results;
  }

  void updateSelectedValue_levels(String value) {
    selectedValue_levels.value = value;
    filterCourse();
  }

  void updateSelectedValue_categories(String value) {
    selectedValue_categories.value = value;
    filterCourse();
  }

  void updateSelectedValue_types(String value) {
    selectedValue_types.value = value;
    filterCourse();
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
    for (var registeredCourse in ProfileController.registeredCourses) {
      if (courseId == registeredCourse.id) {
        update(); //
        return true;
      }
    }
    update(); //
    return false;
  }
}
