import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/domain/TrainingDomain.dart';
import 'package:gym_app_mobile/services/AuthService.dart';
import 'package:gym_app_mobile/services/TrainingService.dart';
import 'package:gym_app_mobile/services/UserService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../domain/UserDomain.dart';
import '../../utils/TokenManager.dart';

class HomeController extends GetxController {
  final TrainingService _trainingService = TrainingService();
  final UserService _userService = UserService();
  final box = GetStorage();

  HomeController() : super() {
    final tokenManager = Get.find<TokenManager>();
    tokenManager.checkTokenExpiration();
  }

  Future<List<TrainingDomain?>> getTrainings() async {
    String userId = getUserIdToken();
    List<TrainingDomain?> response = await _trainingService.getByUser(userId);
    return response!;
  }

  Future<UserDomain?> getUser() async {
    String userId = getUserIdToken();

    UserDomain? user = await _userService.getById(userId);

    return user;
  }

  String getUserIdToken() {
    String token = box.read("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken["userId"] as String;
    return userId;
  }


}
