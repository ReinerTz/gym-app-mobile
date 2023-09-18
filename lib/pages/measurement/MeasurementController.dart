import 'package:get/get.dart';

import '../../domain/MeasurementDomain.dart';
import '../../utils/util.dart';

class MeasurementController extends GetxController {
  final measurements = <MeasurementDomain>[].obs;

  Future<List<MeasurementDomain?>> getMeasurements() async {
    String userId = UtilApp.getUserIdToken();

    // MeasurementDomain? user = await _userService.getById(userId);

    final list = List<MeasurementDomain>.filled(1, MeasurementDomain.fromJson(''));
    return list;
  }
}
