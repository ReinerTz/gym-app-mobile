import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/TrainingGroupDomain.dart';

class TrainingGroupProvider extends BaseProvider {
  Future<TrainingGroupDomain> getById(String id) async {
    final queryParams = {
      'expand': 'true',
    };
    final response = await dio.get(
      '$baseUrl/training-group/$id',
      queryParameters: queryParams
    );

    final responseJson = TrainingGroupDomain.fromJson(response.data!);

    return responseJson;
  }
}
