import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var selectedValue_levels = 'الكل'.obs;
  var selectedValue_categories = 'الكل'.obs;
  var selectedValue_types = 'الكل'.obs;

   List categories = [
    {'iconeName': Icons.laptop, 'title': 'الحاسب الآلي'},
    {'iconeName': Icons.attach_money, 'title': 'إدارة الأعمال'},
    {'iconeName': Icons.brush, 'title': 'الفن'},
    {'iconeName': Icons.language, 'title': 'اللغات'}
  ];

  void updateSelectedValue_levels(String value) {
    selectedValue_levels.value = value;
  }

  void updateSelectedValue_categories(String value) {
    selectedValue_categories.value = value;
  }

  void updateSelectedValue_types(String value) {
    selectedValue_types.value = value;
  }
}
