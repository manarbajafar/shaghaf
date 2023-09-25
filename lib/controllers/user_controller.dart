import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

import '../models/user.dart';
import 'auth_controller.dart';

// this class to perform database user opreations
class UserController extends GetxController {
  static UserController get instance => Get.find();
  //
  final _auth_controller = Get.put(AuthController());
  final _db = FirebaseFirestore.instance;

  /// - fetch user data
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db
        .collection('users')
        .where('email', isEqualTo: email)
        .get(); // all data
    //convert snapshot to single record
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  /// - update user data
  Future<void> updateUserRecord(UserModel user, String oldPassword) async {
    // Prompt the user to enter their email and password
    //reference: https://firebase.flutter.dev/docs/auth/usage/
    //other reference: https://stackoverflow.com/questions/73113046/flutter-firebase-auth-how-to-get-user-current-password

    var current_user = FirebaseAuth.instance.currentUser;

    //// Create a credential
    AuthCredential credential =
        EmailAuthProvider.credential(email: user.email, password: oldPassword);

    print('line 37');

    // Reauthenticate
    await current_user!
        .reauthenticateWithCredential(credential)
        .then((value) async =>
            {await _db.collection('users').doc(user.uid).update(user.toJson())})
        .catchError((error) {
      print(error.toString());
    });

    // print('line 41');
  }

  /// update user password
  Future<void> updateUserPassword(
      String newPassword, String oldPassword) async {
    var current_user = FirebaseAuth.instance.currentUser;
    //// Create a credential
    AuthCredential credential = EmailAuthProvider.credential(
        email: current_user!.email!, password: oldPassword);
    // Reauthenticate
    await current_user!
        .reauthenticateWithCredential(credential)
        .then((value) async {
      current_user.updatePassword(newPassword);
    }).catchError((error) {
      print(error.toString());
    });
  }

  /// update user email
  Future<void> updateUserEmail(String newEmail, String password) async {
    var current_user = FirebaseAuth.instance.currentUser;
    //// Create a credential
    AuthCredential credential = EmailAuthProvider.credential(
        email: current_user!.email!, password: password);
    // Reauthenticate
    await current_user!
        .reauthenticateWithCredential(credential)
        .then((value) async {
      current_user.updateEmail(newEmail);
      await _db
          .collection('users')
          .doc(current_user.uid)
          .update({'email': newEmail});
    }).catchError((error) {
      print(error.toString());
    });
  }
}
