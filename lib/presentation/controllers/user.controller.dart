import 'package:get/get.dart';
import 'package:projetflutter/domain/usecases/user.usecase.dart';

class AuthController extends GetxController {
  final AuthenticateUserUseCase _userUseCase;

  AuthController({required AuthenticateUserUseCase userUseCase})
      : _userUseCase = userUseCase;

  var isAuthenticated = false.obs;

  Future<bool> login(String username, String password) async {
    final res = await _userUseCase.call(username, password);
    isAuthenticated.value = res;
    return res;
  }

  Future<void> register(String username, String password) async {
    await _userUseCase.register(username, password);
  }
}
