import 'package:flutter/material.dart';
import 'package:wait_for_me/auth/auth_exeptions.dart';
import 'dart:developer' show log;

import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/constants/colors.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/dialogs/show_error_dialog.dart';

class RegisterPWDView extends StatefulWidget {
  const RegisterPWDView({super.key});

  @override
  State<RegisterPWDView> createState() => _RegisterPWDViewState();
}

class _RegisterPWDViewState extends State<RegisterPWDView> {
  late final TextEditingController _name;
  late final TextEditingController _surname;
  late final TextEditingController _email;
  late final TextEditingController _password;

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
        appBar: AppBar(
          title: const Text("Registertion for PwDs",
              style: TextStyle(
                  fontSize: 21,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: mainColor)),
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
                      child: Text("Name",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: mainColor)),
                    ),
                    TextField(
                      controller: _name,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: mainColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color:
                                  mainColor), // Border color when TextField is focused
                        ),
                        hintText: "Your name",
                        hintStyle: const TextStyle(color: mainColor),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text("Surename",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: mainColor)),
                    ),
                    TextField(
                      controller: _surname,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: mainColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color:
                                  mainColor), // Border color when TextField is focused
                        ),
                        hintText: "Your surename",
                        hintStyle: const TextStyle(color: mainColor),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text("Email",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: mainColor)),
                    ),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: mainColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color:
                                  mainColor), // Border color when TextField is focused
                        ),
                        hintText: "Enter your email",
                        hintStyle: const TextStyle(color: mainColor),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text("Password",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: mainColor)),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: mainColor)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color:
                                    mainColor), // Border color when TextField is focused
                          ),
                          hintText: "Choose a password",
                          hintStyle: const TextStyle(color: mainColor)),
                    ),
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final name = _name.text;
                            final surname = _surname.text;
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              //  await AuthService.firebase().createUser(
                              //     email: email,
                              //     password: password,
                              //    );
                              await AuthService.firebase().createUser(
                                  name: name,
                                  surname: surname,
                                  email: email,
                                  password: password,
                                  role: "PWD");
     
                              Navigator.of(context).pushNamed(emailVerifyRoute);
                              log("registred!");
                            } on WeakPasswordAuthException {
                              await showErrorDialog(
                                  context, "Weak password, make it STRONGER!");
                            } on InvalidEmailAuthException {
                              await showErrorDialog(
                                  context, "Invalid email, double check!");
                            } on EmailAlreadyInUseAuthException {
                              await showErrorDialog(context,
                                  'The email $email address is already in use by another account');
                            } on GenericAuthException {
                              await showErrorDialog(
                                  context, 'Authentication error');
                            }
                          },
                          child: const Text("Register"),
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              backgroundColor: mainColor,
                              foregroundColor: Colors.white),
                        )),
                    Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute, (route) => false);
                            },
                            child: const Text('Do you have account? login here',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: mainColor)))),
                  ],
                ))));
  }
}
