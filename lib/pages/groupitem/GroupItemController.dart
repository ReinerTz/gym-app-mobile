import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../domain/GroupItemDomain.dart';
import '../../services/GroupItemService.dart';

class GroupItemController extends GetxController {
  final GroupItemService _service = GroupItemService();

  Future<GroupItemDomain> getById(String id) async {
    return _service.getById(id);
  }
}