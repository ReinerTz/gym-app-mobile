import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/core/routes.dart';
import 'package:gym_app_mobile/pages/home/HomePage.dart';
import 'package:gym_app_mobile/pages/signin/SignInPage.dart';
import 'package:gym_app_mobile/utils/TokenManager.dart';

void main() async {
  await dotenv.load();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(TokenManager());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      defaultTransition: Transition.native,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          outline: Colors.indigo,
        ),
      ),
      home: const HomePage(),
      getPages: Routes.getPages(),
    );
  }
}