// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:ionicons/ionicons.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({super.key});

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white, 
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, .15), offset: Offset(0, 0.4))
                ]
              ),
              child: TextButton(
                onPressed: () { Navigator.pop(context); },
                style: TextButton.styleFrom(
                  iconColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 15)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Ionicons.chevron_back, size: 21),
                    Text(
                      "Email Verify",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                  ]
                )
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 20, bottom: 15),
              child: Image(
                image: AssetImage('assets/images/email.png'),
                width: 180,
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const Text(
                    "We've already send email verification. Please, check your email!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Divider(height: 45, color: Color.fromRGBO(0, 0, 0, .1)),
                  SizedBox(
                    width: double.infinity,
                    height: 62,
                    child: TextButton(
                      onPressed: () async {
                        await AuthService.firebase().logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(welcome, (route) => false);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14)))
                      ),
                      child: const Text("Restart", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white)),
                    )
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () async {
                      await AuthService.firebase().emailVerification;
                    },
                    child: const Text("If you haven't recived email yet, click me!", style: TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, .75)))
                  )
                ]
              )
            )
          ]
        ),
      )
    );
  }
}
