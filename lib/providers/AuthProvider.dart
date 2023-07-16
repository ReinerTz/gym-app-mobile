import 'package:dio/src/response.dart';
import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/AuthDomain.dart';

class AuthProvider extends BaseProvider {
  Future<Response<Map<String, dynamic>>> login(AuthDomain body) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$baseUrl/auth/token',
      data: body.toJson(),
    );

    return response;
  }
}
