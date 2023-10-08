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
  List<Map> registeredcoursesIDsandStauts = [];
  static List<CourseModel> registeredCourses = [];

  var isLoadingData = false.obs;
  var userName = 'userName';

  @override
  Future<void> onInit() async {
    userName = await getUserName();
    update();
    super.onInit();
  }

  // @override
  // void onReady() async {
  //   await getRegisterdCourses();
  //   super.onReady();
  // }

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
  updateUserName(String name) async {
    await _user_controller.updateUserName(name);
    getUserName();
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
  logout() {
    _auth_controller.logout();
  }

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

  getUserName() async {
    UserModel userData = await getUserData();
    print('userData.name  ${userData.name}');
    userName = userData.name;
    update();
    return userName;
  }

/*
the plan :
1- The status value updated to true in db
2- updated the screen to 'مكتمل' and the button disappears
*/
  completePayment(int courseId) async {
    //1.1 read the document
    UserModel userData = await getUserData();
    //1.2 get the array of registered courses
    registeredcoursesIDsandStauts = userData.registered_courses!;
    //1.3 get index of the element to be modified and modify it
    int index = registeredcoursesIDsandStauts
        .indexWhere((i) => i['courseId'] == courseId);
    registeredcoursesIDsandStauts[index]['status'] = true;
    //1.4 update that field in db
    await _db
        .collection('users')
        .doc(_auth_controller.firebaseUser.value!.uid)
        .update({'registered_courses': registeredcoursesIDsandStauts});

    // 2 update listview
    update();
  }
}
