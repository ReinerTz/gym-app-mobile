import 'dart:io';

import 'package:dio/src/response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/UserDomain.dart';

class UserProvider extends BaseProvider {
  final storage = GetStorage();

  UserProvider() : super() {
    final token = storage.read("token");
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
  }

  Future<UserDomain?> getById(String id) async {
    final response = await dio.get(
      '$baseUrl/users/$id',
    );

    final userResponse = UserDomain.fromJson(response.data!);

    return userResponse;
  }

  Future<List<UserDomain>?> list() async {
    Response<List<UserDomain>> response =
        await dio.get<List<UserDomain>>('$baseUrl/users');
    return response.data;
  }

  Future<UserDomain?> save(UserDomain body) async {
    Response<UserDomain> response =
        await dio.post('$baseUrl/users', data: body);
    return response.data;
  }
}
