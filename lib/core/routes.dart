import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gym_app_mobile/pages/progressload/ProgressLoadPage.dart';
import 'package:gym_app_mobile/pages/signin/SignInPage.dart';

import '../pages/groupitem/GroupItemPage.dart';
import '../pages/home/HomePage.dart';
import '../pages/traininggroup/TrainingGroupPage.dart';
import '../pages/user/UserPage.dart';

class Routes {
  static const SIGN_IN = "/sign-in";
  static const HOME = "/home";
  static const TRAINING_GROUP = "/training-group";
  static const GROUP_ITEM = "/group-item";
  static const PROFILE = "/user";
  static const PROGESS_LOAD = "/progress-load";

  static List<GetPage<dynamic>> getPages() {
    List<GetPage<dynamic>> pages = [
      GetPage(name: Routes.HOME, page: () => const HomePage()),
      GetPage(name: Routes.SIGN_IN, page: () => const SignInPage()),
      GetPage(name: '${Routes.TRAINING_GROUP}/:id', page: () => const TrainingGroupPage()),
      GetPage(name: Routes.GROUP_ITEM, page: () => const GroupItemPage()),
      GetPage(name: Routes.PROFILE, page: () => const UserPage()),
      GetPage(name: '${Routes.PROGESS_LOAD}/:id', page: () => const ProgressLoad())
    ];
    return pages;
  }
}