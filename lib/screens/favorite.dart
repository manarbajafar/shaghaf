import 'package:flutter/material.dart';

import '../widgets/userCourses_card.dart';

class Favorite extends StatelessWidget {
  late String pageTitle;
  Favorite({super.key, required this.pageTitle});

  List favoritecourses = [
    {
      'title': 'مقدمة في الذكاء الاصطناعي',
      'presenter': 'أ. عمر أحمد',
      'imageUrl': 'images/intro.jpg'
    },
    {
      'title': 'تحليل البيانات باستخدام الاكسل',
      'presenter': 'أ. محمد سعيد',
      'imageUrl': 'images/intro.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 130,
              child: ListView.builder(
                  itemCount: favoritecourses.length,
                  itemBuilder: (context, i) {
                    return UserCoursesCard(
                      courseTitle: favoritecourses[i]['title'],
                      coursePresenter: favoritecourses[i]['presenter'],
                      courseImage: favoritecourses[i]['imageUrl'].toString(),
                      isFavoritepage: true,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
