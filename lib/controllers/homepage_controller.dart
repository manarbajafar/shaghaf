import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/favorite.dart';
import '../screens/home.dart';
import '../screens/profile.dart';

class HomePageController extends GetxController {
  List<Widget> listPage = [
    Home(
      pageTitle: 'الرئيسية',
    ),
    Favorite(
      pageTitle: 'المفضلة',
    ),
    Profile(
      pageTitle: 'حسابي',
    )
  ];

  int currentPage = 0;

  @override
  changePage(int i) {
    currentPage = i;
    update();
  }
}
