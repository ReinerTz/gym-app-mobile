import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/TrainingGroupDomain.dart';

class TrainingGroupProvider extends BaseProvider {
  Future<TrainingGroupDomain> getById(String id) async {
    final response = await dio.get(
      '$baseUrl/training-group/$id',
    );

    final responseJson = TrainingGroupDomain.fromJson(response.data!);

    return responseJson;
  }
}
