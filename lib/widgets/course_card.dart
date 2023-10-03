import 'package:flutter/material.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

class CourseCard extends StatelessWidget {
  int? id;
  String? title;
  String? presenter;
  int? price;
  String? imageUrl;
  Future Function()? registerOnPressed;
  bool isRegistered = false;
  Function? favoriteOnPressed;
  int isFavorite;

  CourseCard(
      {super.key,
      this.title,
      this.id,
      this.presenter,
      this.price,
      this.imageUrl,
      this.registerOnPressed,
      this.isFavorite = 0,
      this.favoriteOnPressed,
      required this.isRegistered});

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
          Stack(
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
              isFavorite == 0
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border),
                        color: AppColor.secondaryColor,
                        onPressed: () {
                          isFavorite++;
                          favoriteOnPressed!();
                        },
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.favorite),
                          color: AppColor.secondaryColor,
                          onPressed: () {
                            isFavorite--;
                            favoriteOnPressed!();
                          },
                        ),
                      ),
                    ),
            ],
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
                child: !isRegistered
                    ? MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        onPressed: registerOnPressed,
                        color: AppColor.primaryColor,
                        child: const Text(
                          'سجل الآن',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                      )
                    : null,
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
