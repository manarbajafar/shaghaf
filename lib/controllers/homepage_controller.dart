import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/favorite.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import 'home_controller.dart';

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
    if (currentPage == 0)
      HomeController.on_home = true;
    else
      HomeController.on_home = false;

    update();
  }
}
