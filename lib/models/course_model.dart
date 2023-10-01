import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  int? id;
  String? title;
  String? presenter;
  String? place;
  int? price;
  String? level;
  // String? date;
  String? category;
  String? imageUrl;
  bool? status;

  CourseModel(
      {this.id,
      this.title,
      this.presenter,
      this.place,
      this.price,
      this.level,
      // this.date,
      this.category,
      this.imageUrl,
      this.status});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        title: json['title'],
        presenter: json['presenter'],
        price: json['price']);
  }

  @override
  String toString() {
    return '{id: ${id}';
  }
}
