import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/widgets/course_card.dart';
import '../constatnt/app_colors.dart';
import '../controllers/homepage_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textForm.dart';

class Homepage extends StatelessWidget {
  Homepage({
    super.key,
  });
//
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

  logout() {
    FirebaseAuth.instance.signOut();
  }

  TextEditingController text = TextEditingController();

  List courses = [
    {
      'title': 'مقدمة في الذكاء الاصطناعي',
      '': 'أ. عمر أحمد',
      'price': 100,
      'imageUrl': 'images/intro.jpg'
    },
    {
      'title': 'تحليل البيانات باستخدام الاكسل',
      '': 'أ. عمر أحمد',
      'price': 100,
      'imageUrl': 'images/intro.jpg'
    },
  ];
//
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColor.primaryColor,
        ),
        title: Text(
          "الرئيسية",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryColor,
        selectedItemColor: AppColor.secondaryColor,
        unselectedItemColor: AppColor.backgroundColor,
        iconSize: 32,
        items: [
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
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
                          items: types
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
              height: 200,
              child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (context, i) {
                    return CourseCard(
                        title: 'مقدمة في الذكاء الاصطناعي',
                        presenter: 'أ. عمر أحمد',
                        price: 100,
                        imageUrl: 'images/intro.jpg');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
