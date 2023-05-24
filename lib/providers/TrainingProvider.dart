import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'BaseProvider.dart';
import '../domain/TrainingDomain.dart';

class TrainingProvider extends BaseProvider {
  Future<TrainingDomain?> getById(String id) async {
    final response = await dio.get(
      '$baseUrl/trainings/$id',
    );

    final userResponse = TrainingDomain.fromJson(response.data!);

    return userResponse;
  }

  Future<List<TrainingDomain>> getByUser(String id) async {
    Map<String, dynamic> query = {};
    query["user"] = id;
    final response = await dio.get(
      '$baseUrl/trainings',
      queryParameters: query,
    );

    final rawList = response.data as List;

    final trainings =
        rawList.map((training) => TrainingDomain.fromJson(training)).toList();

    return trainings;
  }
}
