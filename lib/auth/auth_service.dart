import 'package:wait_for_me/auth/auth_provider.dart';
import 'package:wait_for_me/auth/auth_user.dart';
import 'package:wait_for_me/auth/firebase_auth_provider.dart';

class AuthService implements GeneralAuthProvider {
  final GeneralAuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initilize() async {
    provider.initilize();
  }

  @override
  Future<AuthUser> createUser(
      {required String name, required String surname, required String email, required String password, required String role}) {
    return provider.createUser(name: name, surname: surname, email: email, password: password, role: role);
  }

  @override
  AuthUser? get currentUser {
    return provider.currentUser;
  }

  @override
  Future<void> emailVerification() async {
    provider.emailVerification();
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    return provider.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    provider.logout();
  }

  @override
  Future<AuthUser?> getCurrentUser() {
    return provider.getCurrentUser();
  }
}
