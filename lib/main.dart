import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/core/routes.dart';
import 'package:gym_app_mobile/pages/home/HomePage.dart';
import 'package:gym_app_mobile/utils/TokenManager.dart';

void main() async {
  await dotenv.load();
  await GetStorage.init();
  runApp(const MyApp());
}

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
  ),
  cardColor: Colors.grey.shade700,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(TokenManager());

    PlatformDispatcher.instance.onError = (error, stack) {
      String message = error.toString();
      Get.snackbar("Error", message,
          duration: const Duration(seconds: 6),
          backgroundColor: const Color(0xFFB00020),
          colorText: Colors.white);
      return true;
    };

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      defaultTransition: Transition.native,
      theme: darkTheme,
      home: const HomePage(),
      getPages: Routes.getPages(),
    );
  }
}
