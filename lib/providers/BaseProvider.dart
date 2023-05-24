import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BaseProvider  {
  final dio = Dio();
  String? baseUrl;
  final storage = GetStorage();
  BaseProvider(): super() {
    baseUrl = dotenv.env['BASE_URL'];
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Access-Control-Allow-Origin'] = '*';
    final token = storage.read("token");
    if (token != null && !JwtDecoder.isExpired(token)) {
      dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    }
  }
}