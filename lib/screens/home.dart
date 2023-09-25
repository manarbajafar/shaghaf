import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/widgets/course_card.dart';
import '../constatnt/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_textForm.dart';

class Home extends StatelessWidget {
  late String pageTitle;
  Home({super.key, required this.pageTitle});

//---------------------------------------------------------
// This section is temporary until I finish the design and move to backend :)
  List<String> levels = ['الكل', 'مبتدئ', 'متوسط', 'متقدم'];

  List<String> categories = [
    'الكل',
    'اللغات',
    'الفن',
    'إدارة الأعمال',
    'الحاسب الآلي'
  ];

  List<String> types = ['الكل', 'عن بعد', 'حضوري'];

  TextEditingController text = TextEditingController();

  List courses = [
    {
      'title': 'مقدمة في الذكاء الاصطناعي',
      'presenter': 'أ. عمر أحمد',
      'price': 100,
      'imageUrl': 'images/intro.jpg'
    },
    {
      'title': 'تحليل البيانات باستخدام الاكسل',
      'presenter': 'أ. محمد سعيد',
      'price': 100,
      'imageUrl': 'images/intro.jpg'
    },
  ];
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
            padding: EdgeInsets.only(top: 10),
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
                  controller: text,
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
            height: 8,
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
                            child: Text(value),
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
                            child: Text(value),
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
                            child: Text(value),
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
            height: 8,
          ),
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
                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          controller.categories[i]['iconeName'],
                          size: 40,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      Text(
                        controller.categories[i]['title'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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
          SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, i) {
                  return CourseCard(
                      title: courses[i]['title'],
                      presenter: courses[i]['presenter'],
                      price: courses[i]['price'],
                      imageUrl: courses[i]['imageUrl']);
                }),
          ),
        ],
      ),
    );
  }
}
