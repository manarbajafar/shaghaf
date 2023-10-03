import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  final String name;
  final String email;

  List<Map>? registered_courses = [];
  List<int>? favorite_courses = [];

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    this.registered_courses,
    this.favorite_courses,
  });

  toJson() {
    return {
      'name': name,
      'email': email,
      'registered_courses': registered_courses,
      'favorite_courses': favorite_courses
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!; //getting complete object

    return UserModel(
        uid: document.id,
        name: data['name'],
        email: data['email'],
        registered_courses:
            (data['registered_courses'] ?? [] as List).cast<Map>(),
        favorite_courses: List.from(data['favorite_courses']));
  }
}
