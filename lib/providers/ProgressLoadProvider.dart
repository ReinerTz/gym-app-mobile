import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/ProgressLoadDomain.dart';

class ProgressLoadProvider extends BaseProvider {
  Future<List<ProgressLoadDomain>> getByUserAndExercise(
      String user, String exercise) async {
    Map<String, dynamic> query = {};
    query["user"] = user;
    query["exercise"] = exercise;
    final response =
        await dio.get('$baseUrl/progress-load', queryParameters: query);

    final responseJson = ProgressLoadDomain.fromJsonList(response.data!);

    return responseJson;
  }

  Future<bool> save(ProgressLoadDomain progressLoad) async {
    final response =
        await dio.post('$baseUrl/progress-load', data: progressLoad.toMap());

    return response.statusCode == 200;
  }

  Future<bool> delete(String id) async {
    final response = await dio.delete('$baseUrl/progress-load/$id');
    return response.statusCode == 200;
  }
}
