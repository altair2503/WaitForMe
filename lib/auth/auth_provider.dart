import 'package:wait_for_me/auth/auth_user.dart';

abstract class GeneralAuthProvider {

  Future<void> initilize();

  // AuthUser? get currentUser;

  Future<AuthUser?> getCurrentUser();

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({required String name, required String surname, required String email, required String password, required String role});

  Future<void> logout();
  Future<void> emailVerification();
}
