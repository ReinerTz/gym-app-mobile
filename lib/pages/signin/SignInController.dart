import 'package:get/get.dart';
import 'package:gym_app_mobile/domain/AuthDomain.dart';
import 'package:gym_app_mobile/services/AuthService.dart';

class SignInController extends GetxController {
  Rx<bool> loading = false.obs;

  Future<void> signIn(String email, String password) async {
    loading.value = true;
    final provider = AuthService();
    AuthDomain auth = AuthDomain(email: email, password: password);
    try {
      await provider.login(auth);
    } finally {
      loading.value = false;
    }
  }
}
