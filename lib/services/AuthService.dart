import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/core/routes.dart';
import '../domain/AuthDomain.dart';
import '../providers/AuthProvider.dart';

class AuthService {
  final AuthProvider _provider = AuthProvider();
  final box = GetStorage();
  Future<void> login(AuthDomain body) async {

    try {
      final token = await _provider.login(body);
      box.write("token", token);
      Get.offAllNamed(Routes.HOME);
    } catch (error) {
      throw Exception("Erro ao logar: $error");
    }
  }

   void logout() {
     box.remove("token");
     WidgetsBinding.instance.addPostFrameCallback((_) {
       Get.offAllNamed(Routes.SIGN_IN);
     });
   }
}
