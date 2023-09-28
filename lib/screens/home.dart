import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/courses.dart';
import 'package:shaghaf_app/widgets/course_card.dart';
import '../constatnt/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_textForm.dart';
import 'homepage.dart';

class Home extends StatelessWidget {
  late String pageTitle;

  Home({super.key, required this.pageTitle});

//---------------------------------------------------------
// This section is temporary until I finish the design and move to - filters -backend :)
  List<String> levels = ['الكل', 'مبتدئ', 'متوسط', 'متقدم'];

  List<String> categories = [
    'الكل',
    'اللغات',
    'الفن',
    'إدارة الأعمال',
    'الحاسب الآلي'
  ];

  List<String> types = ['الكل', 'عن بعد', 'حضوري'];

//---------------------------------------------------------

  final HomeController controller = Get.put(HomeController());

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
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: "بحث",
                  hasIcon: true,
                  ispasswordType: false,
                  onChanged: (value) {
                    //value == null || value.length == 0
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
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.cancel,
                  size: 35,
                  color: AppColor.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 90,
                  height: 75,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('نوع الدورات'),
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
                        items:
                            types.map<DropdownMenuItem<String>>((String value) {
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 90,
                  height: 67,
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
                          controller
                              .updateSelectedValue_levels(newValue.toString());
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 90,
                  height: 75,
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
            ),
          ),
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
          Obx(() => SizedBox(
                height: !controller.isOnChangedActive.value ? 220 : 420,
                child: FutureBuilder(
                  future: controller.getCourses(),
                  builder: (context, snapshot) {
                    // is it done loading? then show courses data
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          scrollDirection: !controller.isOnChangedActive.value
                              ? Axis.horizontal
                              : Axis.vertical,
                          itemCount: controller.found_courses.value.length,
                          itemBuilder: (context, i) {
                            return CourseCard(
                              title: controller.found_courses.value[i].title,
                              presenter:
                                  controller.found_courses.value[i].presenter,
                              price: controller.found_courses.value[i].price,
                              imageUrl:
                                  controller.found_courses.value[i].imageUrl,
                              onPressed: (() async {
                                await controller.registerInCourse(
                                    controller.found_courses.value[i].id!);
                                Get.offAll(() => Homepage());
                              }),
                              isCourseinUserRegisteredCourses:
                                  controller.isCourseinUserRegisteredCourses(
                                      controller.found_courses.value[i].id!),
                            );
                          });
                    }
                    //if it is still loading, show loading circle
                    else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}
