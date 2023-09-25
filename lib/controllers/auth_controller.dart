import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';
import '../screens/first_page.dart';
import '../screens/homepage.dart';
import 'login_controller.dart';
import 'signup_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  //variables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setFirstpage);
  }

  _setFirstpage(User? user) {
    user == null
        ? Get.offAll(() => const FirstPage())
        : Get.offAll(() => Homepage());
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(Homepage());
    } on FirebaseAuthException catch (e) {
      final ex = LogInFailure.code(e.code);
      print('firebase auth exception - ${ex.message}');
      Get.snackbar(
        "خطأ في عملية تسجيل الدخول",
        ex.message,
        colorText: AppColor.black,
        icon: const Icon(Icons.error, color: AppColor.ErrorColor),
        snackPosition: SnackPosition.TOP,
      );
      throw ex;
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final User? currentUser = FirebaseAuth.instance.currentUser;
        // store data in in user collection
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser?.uid)
            .set({
          'uid': currentUser?.uid,
          'email': email,
          'name': name,
        });
      });

      firebaseUser.value != null
          ? Get.to(() => Homepage())
          : Get.offAll(() => const FirstPage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      print('firebase auth exception - ${ex.message}');
      Get.snackbar(
        "خطأ في عملية إنشاء الحساب",
        ex.message,
        colorText: AppColor.black,
        icon: const Icon(Icons.error, color: AppColor.ErrorColor),
        snackPosition: SnackPosition.TOP,
      );
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      print('exception - ${ex.message}');
      Get.snackbar(
        "خطأ في عملية إنشاء الحساب",
        ex.message,
        colorText: AppColor.black,
        icon: const Icon(Icons.error, color: AppColor.ErrorColor),
        snackPosition: SnackPosition.TOP,
      );
      throw ex;
    }
  }

  Future<void> logout() async => await _auth.signOut();

  Future<void> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((event) {});
  }
}
