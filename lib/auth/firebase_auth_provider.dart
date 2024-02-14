import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wait_for_me/auth/auth_exeptions.dart';
import 'package:wait_for_me/auth/auth_provider.dart';
import 'package:wait_for_me/models/auth_user.dart';
import 'package:wait_for_me/firebase_options.dart';

class FirebaseAuthProvider implements GeneralAuthProvider {
  @override
  Future<void> initilize() async {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future<AuthUser> createUser(
      {required String name,
      required String surname,
      required String email,
      required String password,
      required String role}) async {
    try {
      UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await emailVerification();
      FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set(
          {'name': name, 'surname': surname, 'email': email, 'role': role});
      final user = await getCurrentUser();
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  AuthUser? _user;

  @override
  AuthUser? get currentUser {
    if (_user == null) {
      getCurrentUser().then((value) => _user = value);
    }
    return _user;
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    return await fetchUserFromFirestore();
  }

  @override
  Future<void> emailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('login');
      final user = await getCurrentUser();
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw UserNotLoggedInException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else if (e.code == "") {
        throw InvalidCreditionalsAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInException();
    }
  }

  Future<AuthUser?> fetchUserFromFirestore() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    if (userDoc.exists && userDoc.data() is Map<String, dynamic>) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final user = AuthUser.fromFirebase(
        firebaseUser,
        name: userData['name'] as String? ?? '',
        surname: userData['surname'] as String? ?? '',
        role: userData['role'] as String? ?? '',
      );
      _user = user;
      return user;
    }
    return null;
  }
}
