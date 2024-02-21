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
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backwelcome.png'),
                fit: BoxFit.cover
              )
            )
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(15, 150, 15, 0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/logowelcome.png'),
                  width: 240,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(registerUserRoute, (route) => false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 60.0, bottom : 15.0),
                    padding: const EdgeInsets.fromLTRB(25, 16, 20, 16),
                    decoration: BoxDecoration(
                      color: mainColor.withOpacity(.8),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 205,
                              margin: const EdgeInsets.only(bottom: 6.0),
                              child: const Text(
                                "I need help with transportation",
                                style: TextStyle(fontSize: 24, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Colors.white, height: 1.35, letterSpacing: .8),
                              )
                            ),
                            const Text(
                              "For people with disabilities",
                              style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: Color.fromRGBO(255, 255, 255, .95), letterSpacing: .8),
                            ),
                          ],
                        ),
                        Image.asset('assets/icons/icon-profile-fill.png', scale: 1.2)
                      ]
                    ),
                  )
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerDriverRoute, (route) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 21),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(147, 167, 178, 1),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Text(
                      "I'm bus driver",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  )
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 55),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(.7), width: 1)
                    ),
                    child: const Text(
                      "Or login here",
                      style: TextStyle(fontSize: 18.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  )
                )
              ],
            )
          )
        ]
      )
    );
  }
}
