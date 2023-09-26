import 'package:flutter/material.dart';
import '../constatnt/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/homepage_controller.dart';

class Homepage extends StatelessWidget {
  Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return GetBuilder<HomePageController>(
        builder: (controller) => Scaffold(
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: BottomNavigationBar(
                  backgroundColor: AppColor.primaryColor,
                  selectedItemColor: AppColor.secondaryColor,
                  unselectedItemColor: AppColor.backgroundColor,
                  iconSize: 32,
                  onTap: controller.changePage,
                  currentIndex: controller.currentPage,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "الرئيسية",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: "المفضلة",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: "حسابي",
                    ),
                  ],
                ),
              ),
              body: controller.listPage.elementAt(controller.currentPage),
            ));
  }
}
