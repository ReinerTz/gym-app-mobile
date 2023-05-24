import '../domain/GroupItemDomain.dart';
import '../providers/GroupItemProvider.dart';

class GroupItemService {
  final GroupItemProvider _provider = GroupItemProvider();

  Future<GroupItemDomain> getById(String id) async {
    try {
      final response = await _provider.getById(id);
      return response;
    } catch (error) {
      throw Exception("Erro ao buscar grupos de treino: $error");
    }
  }
}