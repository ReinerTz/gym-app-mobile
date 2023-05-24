import '../domain/TrainingDomain.dart';
import '../providers/TrainingProvider.dart';

class TrainingService {
  final TrainingProvider _provider = TrainingProvider();

  Future<TrainingDomain?> getById(String id) async {
    try {
      final response = await _provider.getById(id);

      final training = TrainingDomain.fromJson(response as Map<String, dynamic>);

      return training;
    } catch (error) {
      throw Exception("Erro ao buscar treino por ID: $error");
    }
  }

  Future<List<TrainingDomain>> getByUser(String id) async {
    try {
      final response = await _provider.getByUser(id);

      return response;
    } catch (error) {
      throw Exception("Erro ao buscar treinos por usuário: $error");
    }
  }
}
