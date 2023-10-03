import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/course_model.dart';
import '../models/user_model.dart';
import '../screens/homepage.dart';
import 'auth_controller.dart';
import 'home_controller.dart';
import 'user_controller.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();
  final _auth_controller = Get.put(AuthController());
  final _user_controller = Get.put(UserController());

  final _db = FirebaseFirestore.instance;

  List<int> favoritecoursesIDs = [];
  static List<CourseModel> favoriteCourses = [];

  var isLoadingData = false.obs;

  // @override
  // void onReady() async {
  //   await getFavoriteCourses();
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

  Future getFavoriteCourses() async {
    //1
    favoriteCourses.clear();
    UserModel userData = await getUserData();
    favoritecoursesIDs.addAll(userData.favorite_courses!);

    //2
    for (var item in favoritecoursesIDs) {
      for (var course in HomeController.courses) {
        if (course.id == item) favoriteCourses.add(course);
      }
    }
    update();
    return favoriteCourses;
  }

//use it in homepage
  addToFavorites(int courseId) async {
    await _db
        .collection('users')
        .doc(_auth_controller.firebaseUser.value!.uid)
        .set({
      "favorite_courses": FieldValue.arrayUnion([
        courseId,
      ])
    }, SetOptions(merge: true));
    update();
  }

  removeFromFavorites(int courseId) async {
    await _db
        .collection('users')
        .doc(_auth_controller.firebaseUser.value!.uid)
        .update(
      {
        "favorite_courses": FieldValue.arrayRemove([
          courseId,
        ])
      },
    );

    favoriteCourses.removeWhere((item) => item.id == courseId);

    print('favoriteCourses: ${favoriteCourses}');
    Get.to(() => Homepage());

    update();
  }

  int isCourseinUserFavoriteCourses(int courseId) {
    for (var favorite_course in favoriteCourses) {
      if (courseId == favorite_course.id) {
        return 1;
      }
    }
    return 0;
  }
}
