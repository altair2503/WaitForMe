// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/models/auth_user.dart';
import 'package:wait_for_me/auth/auth_exeptions.dart';
import 'package:wait_for_me/auth/auth_service.dart';

import 'package:wait_for_me/dialogs/show_error_dialog.dart';

import 'package:ionicons/ionicons.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final AuthUser? _user;

  bool passwordVisible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.white
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
                    Icon(Ionicons.chevron_back, size: 25),
                    Text(
                      "",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                  ]
                )
              ),
            ),
            const Align(
              heightFactor: 1.45,
              child: Image(
                image: AssetImage('assets/images/WaitForMeIcon.png'),
                width: 62,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Hi, welcome back!",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, .85)
                )
              )
            ),
            const SizedBox(height: 6),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 0),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
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
                ),
              )
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().login(email: email, password: password);
                    await AuthService.firebase().getCurrentUser().then((user) => _user = user);
                    
                    if(_user!.role.contains('PWD')) {
                      print("it's PWD");
                      Navigator.of(context).pushNamedAndRemoveUntil(pwdHomePage, (route) => false);
                    } 
                    else if (_user.role == 'driver') {
                      Navigator.of(context).pushNamedAndRemoveUntil(driverHomePage, (route) => false);
                    }
                    else {
                      print('Noo, ${_user.name}, ${_user.role}, ${_user.emailVerified}');
                    }

                    log("logged!");
                  } 
                  on UserNotFoundAuthException {
                    await showErrorDialog(context, "Such user don't exists, try another one");
                  } 
                  on WrongPasswordAuthException {
                    await showErrorDialog(context, "Password is wrong...");
                  } 
                  on InvalidCreditionalsAuthException {
                    await showErrorDialog(context, 'Email or password is wrong...');
                  } on GenericAuthException {
                    await showErrorDialog(
                        context, 'Authentication error');
                  }
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
                  backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))
                ),
                child: const Text("Log in"),
              )
            ),
            Center(
              heightFactor: 1.2,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(welcome, (route) => false);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Are you not registered yet?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, .8)
                      )
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Register here',
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