import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../domain/GroupItemDomain.dart';
import '../../services/GroupItemService.dart';

class GroupItemController extends GetxController {
  final GroupItemService _service = GroupItemService();

  final RxBool isVideoFullscreen = false.obs;

  void enterFullscreen() {
    isVideoFullscreen.value = true;
  }

  void exitFullscreen() {
    isVideoFullscreen.value = false;
  }

  Future<GroupItemDomain> getById(String id) async {
    return _service.getById(id);
  }
}