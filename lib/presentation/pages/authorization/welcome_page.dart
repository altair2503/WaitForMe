import 'package:flutter/material.dart';
import 'package:wait_for_me/constants/colors.dart';
import 'package:wait_for_me/constants/routes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Image.asset('assets/images/logo.JPEG', scale: 80),
            const Text(
              "Wait for me",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: logoColor),
            )
          ]),
        ),
        body: Center(
            child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerUserRoute, (route) => false);
              },
              child:
            Container(
              margin: const EdgeInsets.only(top: 160.0, bottom : 16.0),
              padding: const EdgeInsets.all(16.0),
              width: 370,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  )
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            width: 250,
                            child: const Text(
                              "I need help with transportation",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                        const Text(
                          "For people with disabilities",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Image.asset('assets/icons/icon-profile-fill.png',
                        scale: 1.5)
                  ]),
            )),

            GestureDetector(
              onTap: () {
                Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerDriverRoute, (route) => false);
              },
              child:
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              width: 370,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  )
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "I'm bus driver",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Image.asset('assets/icons/solid_bus.png', scale: 1.5)
                  ]),
            )),

            GestureDetector(
              onTap: () {
                Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child:
            Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: mainColor, // Set your desired border color here
                  width: 1, // Set the border width (optional)
                ),
                
              ),
              child: const Text(
                "Or login here",
                style: TextStyle(
                fontSize: 17,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: mainColor),
              ),
            ))
          ],
        )));
  }
}
