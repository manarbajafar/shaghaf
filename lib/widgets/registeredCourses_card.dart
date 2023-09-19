import 'package:flutter/material.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

class RegisteredCoursesCard extends StatelessWidget {
  String courseTitle;
  int coursePrice;
  bool status;

  RegisteredCoursesCard({
    super.key,
    required this.courseTitle,
    required this.coursePrice,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return // Generated code for this Card Widget...
        Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColor.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  Text(
                    coursePrice.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ]),
              ],
            ),
            Text(
              status ? ' مكتمل' : 'غير مكتمل',
              style: status
                  ? TextStyle(fontSize: 16, color: Colors.green)
                  : TextStyle(fontSize: 16, color: AppColor.ErrorColor),
            ),
          ],
        ),
      ),
    );
  }
}
