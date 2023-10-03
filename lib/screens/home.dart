import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/courses.dart';
import 'package:shaghaf_app/widgets/course_card.dart';
import '../constatnt/app_colors.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_textForm.dart';
import 'homepage.dart';

class Home extends StatelessWidget {
  late String pageTitle;

  Home({super.key, required this.pageTitle});

  List<String> levels = ['الكل', 'مبتدئ', 'متوسط', 'متقدم'];

  List<String> categories = [
    'الكل',
    'اللغات',
    'الفن',
    'إدارة الأعمال',
    'الحاسب الآلي'
  ];

  List<String> types = ['الكل', 'عن بعد', 'مكة', 'جدة'];

  final HomeController controller = Get.put(HomeController());
  final favorite_controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 20),
            child: Text(
              pageTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          CustomTextFormField(
            hintText: "بحث",
            hasIcon: true,
            ispasswordType: false,
            onChanged: (value) {
              if (value.isEmpty)
                controller.isOnChangedActive.value = false;
              else
                controller.isOnChangedActive.value = true;
              controller.searchCoursebyTextField(value);
            },
            validator: (value) {
              if (value == null) {
                print("the field is empty");
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('المكان'),
                        DropdownButton<String>(
                          isExpanded: true,
                          underline: const SizedBox(),
                          value: controller.selectedValue_types.value == ""
                              ? null
                              : controller.selectedValue_types.value,
                          onChanged: (newValue) {
                            controller
                                .updateSelectedValue_types(newValue.toString());
                          },
                          items: types
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('المستوى'),
                        DropdownButton<String>(
                          isExpanded: true,
                          underline: const SizedBox(),
                          value: controller.selectedValue_levels.value == ""
                              ? null
                              : controller.selectedValue_levels.value,
                          onChanged: (newValue) {
                            controller.updateSelectedValue_levels(
                                newValue.toString());
                          },
                          items: levels
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('الفئات'),
                        DropdownButton<String>(
                          isExpanded: true,
                          underline: const SizedBox(),
                          value: controller.selectedValue_categories.value == ""
                              ? null
                              : controller.selectedValue_categories.value,
                          onChanged: (newValue) {
                            controller.updateSelectedValue_categories(
                                newValue.toString());
                          },
                          items: categories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: !controller.isOnChangedActive.value
                    ? [
                        const Text(
                          'الفئات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.TertiaryColor,
                          ),
                        ),
                        Container(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, i) {
                              return Container(
                                padding:
                                    const EdgeInsets.only(top: 2, bottom: 10),
                                margin: EdgeInsets.only(left: 20),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => Courses(
                                          categoryName: controller.categories[i]
                                              ['title'],
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          controller.categories[i]['iconeName'],
                                          size: 40,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          controller.categories[i]['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'الدورات المنشورة حديثًا',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.TertiaryColor,
                          ),
                        ),
                      ]
                    : [],
              )),
          Obx(() {
            if (!controller.isLoadingData.value) {
              int listLength = controller.found_courses.value.length;
              print("listLength: ${listLength}");
              return listLength > 0
                  ? SizedBox(
                      height: !controller.isOnChangedActive.value ? 220 : 420,
                      child: GetBuilder<FavoriteController>(
                          builder: (context) => ListView.builder(
                              scrollDirection:
                                  !controller.isOnChangedActive.value
                                      ? Axis.horizontal
                                      : Axis.vertical,
                              itemCount: listLength,
                              itemBuilder: (context, i) {
                                return CourseCard(
                                  title:
                                      controller.found_courses.value[i].title,
                                  presenter: controller
                                      .found_courses.value[i].presenter,
                                  price:
                                      controller.found_courses.value[i].price,
                                  imageUrl: controller
                                      .found_courses.value[i].imageUrl,
                                  registerOnPressed: (() async {
                                    await controller.registerInCourse(
                                        controller.found_courses.value[i].id!);
                                    Get.offAll(() => Homepage());
                                  }),
                                  ///////////////////
                                  isFavorite: favorite_controller
                                      .isCourseinUserFavoriteCourses(controller
                                          .found_courses.value[i].id!),
                                  favoriteOnPressed: (() async {
                                    favorite_controller
                                                .isCourseinUserFavoriteCourses(
                                                    controller.found_courses
                                                        .value[i].id!) ==
                                            0
                                        ? {
                                            await favorite_controller
                                                .addToFavorites(controller
                                                    .found_courses.value[i].id!)
                                          }
                                        : {
                                            await favorite_controller
                                                .removeFromFavorites(controller
                                                    .found_courses.value[i].id!)
                                          };

                                    Get.offAll(() => Homepage());
                                  }),
                                  ///////////////////
                                  isRegistered: controller
                                      .isCourseinUserRegisteredCourses(
                                          controller
                                              .found_courses.value[i].id!),
                                );
                              })),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "لا توجد نتائج",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
            }
            //if it is still loading, show loading circle
            else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ],
      ),
    );
  }
}
