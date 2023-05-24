import '../domain/TrainingGroupDomain.dart';
import '../providers/TrainingGroupProvider.dart';

class TrainingGroupService {
  final TrainingGroupProvider _provider = TrainingGroupProvider();

  Future<TrainingGroupDomain> getById(String id) async {
    try {
      final response = await _provider.getById(id);
      return response;
    } catch (error) {
      throw Exception("Erro ao buscar grupos de treino: $error");
    }
  }
}