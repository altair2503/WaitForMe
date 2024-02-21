// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:wait_for_me/constants/colors.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(context, '/welcome/');
            })
          },
          icon: const Icon(Ionicons.chevron_back)
        ),
        title: const Text(
          "Log in",
          style: TextStyle(
            fontSize: 21,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: mainColor
          )
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: mainColor
                  )
                ),
              ),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: mainColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: mainColor), // Border color when TextField is focused
                  ),
                  hintText: "Enter your email",
                  hintStyle: const TextStyle(color: mainColor),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: mainColor
                  )
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: mainColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color:mainColor), // Border color when TextField is focused
                  ),
                  hintText: "Choose a password",
                  hintStyle: const TextStyle(color: mainColor)
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuthService.firebase().login(email: email, password: password);
                      await AuthService.firebase().getCurrentUser().then((user) => _user = user);
                      
                      if(_user?.role == 'PWD') {
                        print("it's PWD");
                        Navigator.of(context).pushNamedAndRemoveUntil(pwdHomePage, (route) => false);
                      } 
                      else if (_user?.role == 'driver') {
                        Navigator.of(context).pushNamedAndRemoveUntil(driverHomePage, (route) => false);
                      }
                      else {
                        print('Noo, ${_user?.name}, ${_user?.role}, ${_user?.emailVerified}');
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
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 17, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: Colors.white),
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white
                  ),
                  child: const Text("Log in"),
                )
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(welcome, (route) => false);
                  },
                  child: const Text(
                    'Not registred yet? Register here',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: mainColor
                    )
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}


// Future<AuthUser> fetchUserFromFirestore() async {
//   final firebaseUser = FirebaseAuth.instance.currentUser!;
//   DocumentSnapshot userDoc = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(firebaseUser.uid)
//       .get();
//   final userData = userDoc.data() as Map<String, dynamic>;
//   return AuthUser.fromFirebase(
//     firebaseUser,
//     name: userData['name'] as String? ?? '',
//     surname: userData['surname'] as String? ?? '',
//     role: userData['role'] as String? ?? '',
//   );
// }
