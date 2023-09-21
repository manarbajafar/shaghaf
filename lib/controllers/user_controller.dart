import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<User> getUserDetails(String email) async {
    final snapshot = await _db
        .collection('users')
        .where('email', isEqualTo: email)
        .get(); // all data
    //convert snapshot to single record
    final userData = snapshot.docs.map((e) => User.fromSnapshot(e)).single;
    return userData;
  }

  /// - update user data
  Future<void> updateUserRecord(User user) async {
    await _db.collection('users').doc(user.uid).update(user.toJson());
  }
}
