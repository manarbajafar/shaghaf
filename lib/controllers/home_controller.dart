import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var selectedValue_levels = 'الكل'.obs;
  var selectedValue_categories = 'الكل'.obs;
  var selectedValue_types = 'الكل'.obs;



  @override
  void onInit() {
     getCourses();
    super.onInit();
  }

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

  getCourses() async {
    var url = Uri.parse(
        "https://run.mocky.io/v3/d5293e75-45b3-42c5-8522-e5ec91c24711");
    var response = await http.get(url);
    print(response.body);
  }
}
