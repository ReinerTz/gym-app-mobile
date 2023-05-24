import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/services/AuthService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenManager {
  final box = GetStorage();
  final AuthService _authService = AuthService();
  final StreamController<bool> _tokenExpiredController =
      StreamController<bool>();

  Stream<bool> get onTokenExpired => _tokenExpiredController.stream;

  void checkTokenExpiration() {
    final token = box.read('token');

    bool isTokenExpired = token == null || JwtDecoder.isExpired(token);

    if (isTokenExpired) {
      _authService.logout();
    }
    _tokenExpiredController.add(isTokenExpired);
  }

  void setToken(String token) {
    box.write('token', token);
  }

  void dispose() {
    _tokenExpiredController.close();
  }
}
