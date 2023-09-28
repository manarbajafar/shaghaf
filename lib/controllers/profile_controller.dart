import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/controllers/home_controller.dart';

import '../models/course_model.dart';
import '../models/user_model.dart';
import 'auth_controller.dart';
import 'user_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  //get email of the user who is currently logged in (from AuthController) and pass to user controller to fetch user record
  final _auth_controller = Get.put(AuthController());
  final _user_controller = Get.put(UserController());
  final _db = FirebaseFirestore.instance;
  String? userName = 'username';
  List<Map> registeredcoursesIDsandStauts = [];
  static List<CourseModel> registeredCourses = [];
  // final registeredCourses = <CourseModel>[].obs;
  @override
  void onReady() {
    super.onReady();
    userName = _auth_controller.firebaseUser.value?.displayName;
  }

  //fetch user information from database
  getUserData() {
    final email = _auth_controller.firebaseUser.value?.email;
    if (email != null) {
      return _user_controller.getUserDetails(email);
    } else {
      Get.snackbar('خطأ', '.'); //
    }
  }

  //update user information
  updateUserData(UserModel user) async {
    await _user_controller.updateUserRecord(user);
  }

  //update user password
  updateUserPasswordData(String newPassword, String oldPassword) async {
    await _user_controller.updateUserPassword(newPassword, oldPassword);
  }

  //update user email
  updateUseremailData(String newEmail, String password) async {
    await _user_controller.updateUserEmail(newEmail, password);
  }

/////// profile page

//get user registerd courses
// the plan :
// 1- Get the registered_courses (array of maps) from user collections
// 2- I have a list of all courses, store what is equal to the course id in registered_courses in  registered_courses list to display them in profile
  Future getRegisterdCourses() async {
    //1
    registeredCourses.clear();
    UserModel userData = await getUserData();
    registeredcoursesIDsandStauts = userData.registered_courses!;
    //2
    for (var item in registeredcoursesIDsandStauts) {
      int id = item["courseId"];
      for (var course in HomeController.courses) {
        if (course.id == id) registeredCourses.add(course);
      }
    }
    update();
    return registeredCourses;
  }

  updateUserName() {
    userName = _auth_controller.firebaseUser.value
        ?.displayName; //I have to change the name field in db to displayName
    update();
  }

/*
the plan :
1- The status value updated to true in db
2- updated the screen to 'مكتمل' and the button disappears
*/
  completePayment(int courseId) async {
    //1.1 get index of regidter course from db
    UserModel userData = await getUserData();
    registeredcoursesIDsandStauts = userData.registered_courses!;
    int index = registeredcoursesIDsandStauts
        .indexWhere((i) => i['courseId'] == courseId);
    //1.2 update specific array
    await _db
        .collection('users')
        .doc(_auth_controller.firebaseUser.value!.uid)
        .update({
      "registered_courses"[index]: FieldValue.arrayUnion([
        {
          'courseId': courseId,
          'status': true,
        }
      ])
    });
    getRegisterdCourses(); // 2 but it doesn't work yet
  }
}
