// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wait_for_me/auth/auth_exeptions.dart';
import 'dart:developer' show log;

import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/dialogs/show_error_dialog.dart';

class RegisterDriverView extends StatefulWidget {
  const RegisterDriverView({super.key});

  @override
  State<RegisterDriverView> createState() => _RegisterDriverViewState();
}

class _RegisterDriverViewState extends State<RegisterDriverView> {

  late final TextEditingController _name;
  late final TextEditingController _surname;
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool passwordVisible = false;

  @override
  void initState() {
    _name = TextEditingController();
    _surname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, .2), offset: Offset(0, 0.4))
                ]
              ),
              child: TextButton(
                onPressed: () { 
                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamed(context, '/welcome/');
                  });
                },
                style: TextButton.styleFrom(
                  iconColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 15)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Ionicons.chevron_back, size: 21),
                    Text(
                      "Registration",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                  ]
                )
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Driver's Registration",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, .85)
                )
              )
            ),
            const SizedBox(height: 3),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Fill in all the fields",
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(0, 0, 0, .6)
                )
              )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 12, 18, 6),
              child: Text(
                "Name",
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: TextField(
                controller: _name,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .75)), // Border color when TextField is focused
                  ),
                  hintText: "Enter your name...",
                  hintStyle: const TextStyle(fontSize: 15.5, color: Color.fromRGBO(0, 0, 0, .6))
                )
              )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 12, 18, 6),
              child: Text(
                "Surname",
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: TextField(
                controller: _surname,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .75)), // Border color when TextField is focused
                  ),
                  hintText: "Enter your surname...",
                  hintStyle: const TextStyle(fontSize: 15.5, color: Color.fromRGBO(0, 0, 0, .6))
                )
              )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 12, 18, 6),
              child: Text(
                "Email",
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .75)), // Border color when TextField is focused
                  ),
                  hintText: "Enter your email...",
                  hintStyle: const TextStyle(fontSize: 15.5, color: Color.fromRGBO(0, 0, 0, .6))
                )
              )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 12, 18, 6),
              child: Text(
                "Password",
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: TextField(
                controller: _password,
                obscureText: !passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, .75)), // Border color when TextField is focused
                  ),
                  hintText: "Enter your password...",
                  hintStyle: const TextStyle(fontSize: 15.5, color: Color.fromRGBO(0, 0, 0, .6)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                      passwordVisible ? Ionicons.eye : Ionicons.eye_off,
                      color: const Color.fromRGBO(0, 0, 0, .6),
                    ),
                    padding: const EdgeInsets.only(right: 15),
                  )
                )
              )
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.fromLTRB(18, 20, 18, 0),
              child: TextButton(
                onPressed: () async {
                  final name = _name.text;
                  final surname = _surname.text;
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase()
                    .createUser(name: name, surname: surname, email: email, password: password, role: 'driver');
                    Navigator.of(context).pushNamed(emailVerifyRoute);
                    log("registred!");
                  } 
                  on WeakPasswordAuthException {
                    await showErrorDialog(context, "Weak password, make it STRONGER!");
                  } 
                  on InvalidEmailAuthException {
                    await showErrorDialog(context, "Invalid email, double check!");
                  } 
                  on EmailAlreadyInUseAuthException {
                    await showErrorDialog(context, 'The email $email address is already in use by another account');
                  } 
                  on UserPermissionDeniedException {
                    await showErrorDialog(context, 'UserPermissionDeniedException');
                  } 
                  on QuotaExceededException {
                    await showErrorDialog(context, 'QuotaExceededException');
                  } 
                  on GenericFirestoreException {
                    await showErrorDialog(context, 'GenericFirestoreException');
                  } 
                  on GenericAuthException {
                    await showErrorDialog(context, 'Authentication error');
                  }
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
                  backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))
                ),
                child: const Text("Register"),
              )
            ),
            Center(
              heightFactor: 1.2,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Do you have account?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, .8)
                      )
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Log in here',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, .8),
                        decoration: TextDecoration.underline
                      ),
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}