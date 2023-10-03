import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';
import '../widgets/userCourses_card.dart';
import 'homepage.dart';

class Favorite extends StatelessWidget {
  late String pageTitle;
  Favorite({super.key, required this.pageTitle});
  // final controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 130,
              child: GetBuilder<FavoriteController>(
                init: FavoriteController(),
                builder: (controller) {
                  if (!controller.isLoadingData.value) {
                    int favoriteCoursesLength =
                        FavoriteController.favoriteCourses.length;
                    print(
                        " FavoriteController.favoriteCourses.length: ${FavoriteController.favoriteCourses.length}");
                    return favoriteCoursesLength > 0
                        ? SizedBox(
                            height: 200,
                            child: ListView.builder(
                                itemCount: favoriteCoursesLength,
                                itemBuilder: (context, i) {
                                  return UserCoursesCard(
                                      courseTitle: FavoriteController
                                          .favoriteCourses[i].title!,
                                      coursePresenter: FavoriteController
                                          .favoriteCourses[i].presenter!,
                                      courseImage: FavoriteController
                                          .favoriteCourses[i].imageUrl
                                          .toString(),
                                      isFavoritepage: true,
                                      favoriteOnPressed: (() async {
                                        await controller.removeFromFavorites(
                                            FavoriteController
                                                .favoriteCourses[i].id!);
                                      }));
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                "لا توجد دورات ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
