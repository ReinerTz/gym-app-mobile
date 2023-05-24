import 'package:dio/src/response.dart';
import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/AuthDomain.dart';

class AuthProvider extends BaseProvider {
  Future<String> login(AuthDomain body) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$baseUrl/auth/token',
      data: body.toJson(),
    );

    final authResponse = AuthResponse.fromJson(response.data!);
    return authResponse.token;
  }
}
