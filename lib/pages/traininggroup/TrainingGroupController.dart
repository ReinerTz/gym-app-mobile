import 'package:get/get.dart';
import 'package:gym_app_mobile/domain/AuthDomain.dart';
import 'package:gym_app_mobile/domain/TrainingGroupDomain.dart';
import 'package:gym_app_mobile/services/AuthService.dart';
import 'package:gym_app_mobile/services/TrainingGroupService.dart';

class TrainingGroupController extends GetxController {
  Rx<bool> loading = false.obs;
  final TrainingGroupService _service = TrainingGroupService();

  Future<TrainingGroupDomain> getById(String id) async {
    return _service.getById(id);
  }
}
