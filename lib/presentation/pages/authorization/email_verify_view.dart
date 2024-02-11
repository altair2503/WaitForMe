import 'package:flutter/material.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/constants/routes.dart';

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
        appBar: AppBar(title: const Text('Email Verify')),
        body: Column(
          children: [
            const Text(
                "We've already send email verification. Please, check your email!"),
            TextButton(
                onPressed: () async {
                  await AuthService.firebase().emailVerification;
                },
                child: const Text(
                    "If you haven't recived email yet, please, click me!")),
            TextButton(
                onPressed: () async {
                  await AuthService.firebase().logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(welcome, (route) => false);
                },
                child: const Text("Restart"))
          ],
        ));
  }
}
