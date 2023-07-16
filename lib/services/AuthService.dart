import 'package:dio/dio.dart';
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
      final response = await _provider.login(body);
      final authResponse = AuthResponse.fromJson(response.data!);
      final token = authResponse.token;

      box.write("token", token);
      Get.offAllNamed(Routes.HOME);
    } catch (error) {
      if (error is DioError) {
         throw Exception((error).response?.data["message"].toString());
      }
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
