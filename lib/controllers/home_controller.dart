import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shaghaf_app/models/course_model.dart';
import 'auth_controller.dart';
import 'favorite_controller.dart';
import 'profile_controller.dart';

class HomeController extends GetxController {
  final _auth_controller = Get.put(AuthController());
  final _profile_controller = Get.put(ProfileController());
  final _favorite_controller = Get.put(FavoriteController());

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

  var isLoadingData = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    await getCourses();
    super.onReady();
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

    found_courses.value = [];
    found_courses.value.addAll(results);
  }

  void filterCourse() {
    List<CourseModel> results = [];
    if (selectedValue_levels.value == 'الكل' &&
        selectedValue_types.value == 'الكل' &&
        selectedValue_categories.value == 'الكل') {
      isOnChangedActive.value = false;
      results.clear();
      found_courses.value.clear();
      results.addAll(courses);
    }

    if (selectedValue_levels.value == 'الكل' ||
        selectedValue_types.value == 'الكل' ||
        selectedValue_categories.value == 'الكل') {
      isOnChangedActive.value = true;
      results.clear();
      found_courses.value.clear();
      results.addAll(courses);
      if (selectedValue_types.value != 'الكل') {
        results.removeWhere((element) =>
            !element.place.toString().contains(selectedValue_types.value));
      }
      if (selectedValue_categories.value != 'الكل') {
        results.removeWhere(
            (element) => element.category != selectedValue_categories.value);
      }
      if (selectedValue_levels.value != 'الكل') {
        results.removeWhere(
            (element) => element.level != selectedValue_levels.value);
      }
    }

    if (selectedValue_levels.value != 'الكل' &&
        selectedValue_types.value != 'الكل' &&
        selectedValue_categories.value != 'الكل') {
      isOnChangedActive.value = true;
      results.clear();
      found_courses.value.clear();
      results = courses
          .where((element) =>
              element.category == selectedValue_categories.value &&
              element.level == selectedValue_levels.value &&
              element.place.toString().contains(selectedValue_types.value))
          .toList();
    }
    found_courses.value = [];
    found_courses.value.addAll(results);
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
      isLoadingData.value = true;
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
      await _favorite_controller.getFavoriteCourses();
      update();
      found_courses.value.addAll(courses);
      isLoadingData.value = false;
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
    // store course in list
    for (var course in HomeController.courses) {
      if (course.id == courseId)
        ProfileController.registeredCourses.add(course);
    }
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
