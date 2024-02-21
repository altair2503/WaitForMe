import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;

@immutable
class AuthUser {

  final String id;
  final bool emailVerified;
  final String name;
  final String surname;
  final String role;

  const AuthUser({
    required this.id,
    required this.emailVerified,
    required this.name,
    required this.surname,
    required this.role,
  });

  factory AuthUser.fromFirebase(
    User user, 
    { required String name, 
      required String surname, 
      required String role }
  ) =>
    AuthUser(
      id: user.uid,
      emailVerified: user.emailVerified,
      name: name,
      surname: surname,
      role: role,
    );

}