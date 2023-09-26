import 'package:flutter/material.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

import 'custom_button.dart';

class UserCoursesCard extends StatelessWidget {
  String courseTitle;
  String courseImage;
  String coursePresenter;
  int coursePrice;
  bool status;
  bool isFavoritepage;
  IconData favoriteIcon;

  UserCoursesCard(
      {super.key,
      required this.courseTitle,
      required this.courseImage,
      this.coursePrice = 0,
      this.status = false,
      this.coursePresenter = '',
      this.isFavoritepage = false,
      this.favoriteIcon = Icons.favorite});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Card Widget...
        Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColor.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70,
            height: MediaQuery.of(context).size.height * 0.11,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Image.asset(courseImage, fit: BoxFit.fill),
            ),
          ),
          Column(
            children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Wrap(
                  spacing: 0,
                  runSpacing: 0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.vertical,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Text(courseTitle,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                !isFavoritepage
                    ? Row(
                        children: [
                          Text(
                            coursePrice.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'ر.س',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      )
                    : Text(
                        coursePresenter,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
              ]),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: !isFavoritepage
                ? !status
                    ? Column(
                        children: [
                          Text(
                            'غير مكتمل',
                            style: TextStyle(
                                fontSize: 15, color: AppColor.ErrorColor),
                          ),
                          Container(
                            height: 22,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              onPressed: () {},
                              color: AppColor.primaryColor,
                              child: const Text(
                                'إتمام الدفع',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'مكتمل',
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      )
                : Icon(
                    favoriteIcon,
                    color: AppColor.TertiaryColor,
                  ),
          ),
        ],
      ),
    );
  }
}
