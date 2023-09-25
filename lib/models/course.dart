import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String? id;
  String? title;
  String? presenter;
  String? place;
  int? price;
  String? level;
  // String? date;
  String? category;
  String? imageUrl;

  CourseModel(
      {this.id,
      this.title,
      this.presenter,
      this.place,
      this.price,
      this.level,
      // this.date,
      this.category,
      this.imageUrl});


  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        title: json['title'],
        presenter: json['presenter'],
        price: json['price']);
  }
}
