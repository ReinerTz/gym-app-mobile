import 'package:gym_app_mobile/domain/ProgressLoadDomain.dart';
import 'package:gym_app_mobile/providers/ProgressLoadProvider.dart';

class ProgressLoadService {

  final ProgressLoadProvider _provider = ProgressLoadProvider();

  Future<List<ProgressLoadDomain>?> getByUser(String user, String exercise) async {
    try {
      final response = await _provider.getByUserAndExercise(user, exercise);
      return response;
    } catch (error) {
      throw Exception("Erro ao buscar carga: $error");
    }
  }

  Future<bool> save(ProgressLoadDomain progressLoad) async {
    try {
      final response = await _provider.save(progressLoad);
      return response;
    } catch (error) {
      throw Exception("Erro ao salvar carga: $error");
    }
  }

  Future<bool> delete(String id) async {
    try {
      final response = await _provider.delete(id);
      return response;
    } catch (error) {
      throw Exception("Erro ao escluir uma carga: $error");
    }
  }
}