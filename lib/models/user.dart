import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  final String name;
  final String email;
  final String password;

  User(
      {this.uid,
      required this.name,
      required this.email,
      required this.password});

  // User.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   email = json['email'];
  //   password = json['password'];
  // }

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!; //getting complete object

    return User(
        uid: document.id,
        name: data['name'],
        email: data['email'],
        password: data['password']);
  }
}
