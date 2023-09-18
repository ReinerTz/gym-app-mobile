
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gym_app_mobile/services/ProgressLoadService.dart';

import '../../domain/ProgressLoadDomain.dart';
import '../../utils/util.dart';

class ProgressLoadController extends GetxController {
  final _service = ProgressLoadService();

  Future<List<ProgressLoadDomain>?> getProgressLoad(String exercise) async {
    String userId = UtilApp.getUserIdToken();

    List<ProgressLoadDomain>? list = await _service.getByUser(userId, exercise);

    return list;
  }

  Future<bool> save(String exercise, DateTime recorded, double load) async {
    String userId = UtilApp.getUserIdToken();
    final progressLoad = ProgressLoadDomain(user: userId, exercise: exercise, recorded: recorded, load: load);
    final response = await _service.save(progressLoad);

    return response;
  }

  Future<bool> delete(String id) async {
    final response = await _service.delete(id);
    return response;
  }
}
