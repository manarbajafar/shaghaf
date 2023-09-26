import 'package:flutter/material.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

class CourseCard extends StatelessWidget {
  String? title;
  String? presenter;
  int? price;
  String? imageUrl;
  Future Function()? onPressed;

  CourseCard(
      {super.key,
      this.title,
      this.presenter,
      this.price,
      this.imageUrl,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width - 80,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: Image.network(imageUrl!, fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'تقديم',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Text(
                  presenter!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      price.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    'ر.س',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 30,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  onPressed: onPressed,
                  color: AppColor.primaryColor,
                  child: const Text(
                    'سجل الآن',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
