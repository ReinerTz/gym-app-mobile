import '../domain/UserDomain.dart';
import '../providers/UserProvider.dart';

class UserService {

  final UserProvider _provider = UserProvider();

  Future<UserDomain?> getById(String id) async {
    try {
      final response = await _provider.getById(id);
      return response;
    } catch (error) {
      throw Exception("Erro ao buscar usuário por ID: $error");
    }
  }
}