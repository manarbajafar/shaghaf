import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaghaf_app/screens/first_page.dart';
import 'constatnt/app_colors.dart';
import 'controllers/auth_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //to make the app from right-to-left (RTL)
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('ar', 'AE'),

      debugShowCheckedModeBanner: false,
      title: 'shaghaf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),
        backgroundColor: AppColor.backgroundColor,
        fontFamily: 'Tajawal',
        textTheme: const TextTheme(
          //for pages title
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
          //for welcomeing words
          titleLarge: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: AppColor.primaryColor,
          ),
          bodySmall: TextStyle(
            color: AppColor.grey,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
          titleSmall: TextStyle(
            decoration: TextDecoration.underline,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            color: AppColor.primaryColor,
          ),
        ),
      ),
      home: const FirstPage(),
    );
  }
}
