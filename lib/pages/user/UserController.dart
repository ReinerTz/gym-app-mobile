import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/domain/UserDomain.dart';
import 'package:gym_app_mobile/services/UserService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserController extends GetxController {
  UserService _userService = UserService();
  final box = GetStorage();
  final RxString name = "".obs;
  final RxString email = "".obs;
  final RxString avatar = "".obs;

  Future<UserDomain?> getUserById(String userId) async {
    String id = getUserIdToken();
    UserDomain? user = await _userService.getById(id);
    if (user != null) {
      name.value = user.name;
      email.value = user.email;
      avatar.value = user.avatar ?? "";
    }


    return user;
  }

  String getUserIdToken() {
    String token = box.read("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken["userId"] as String;
    return userId;
  }

  void updateUser({String? newName, String? newEmail, String? newAvatar}) {
    if (newName != null) name.value = newName;
    if (newEmail != null) email.value = newEmail;
    if (newAvatar != null) avatar.value = newAvatar;
  }
}