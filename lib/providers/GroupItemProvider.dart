import 'package:gym_app_mobile/providers/BaseProvider.dart';

import '../domain/GroupItemDomain.dart';

class GroupItemProvider extends BaseProvider {
  Future<GroupItemDomain> getById(String id) async {
    final response = await dio.get(
      '$baseUrl/group-item/$id',
    );

    final responseJson = GroupItemDomain.fromJson(response.data!);

    return responseJson;
  }
}