import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import 'auth_controller.dart';
import 'user_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  //get email of the user who is currently logged in (from AuthController) and pass to user controller to fetch user record
  final _auth_controller = Get.put(AuthController());
  final _user_controller = Get.put(UserController());

  late String? userName;

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
      Get.snackbar('خطأ', '...'); //
    }
  }

  //update user information
  updateUserData(User user) async {
    await _user_controller.updateUserRecord(user);
    //reAuthenticate
  }

  updateUserName() {
    userName = _auth_controller.firebaseUser.value
        ?.displayName; //I have to change the name field in db to displayName
    update();
  }

/////// profile page
  completePayment() {
    //i will implement it later:)
    update();
  }
}
