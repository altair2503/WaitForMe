import 'package:flutter/material.dart';

import 'package:wait_for_me/presentation/pages/blind/blind_home_page.dart';
import 'package:wait_for_me/presentation/pages/blind/cities_page.dart';
import 'package:wait_for_me/presentation/pages/blind/notifying_page.dart';
import 'package:wait_for_me/presentation/pages/driver/driver_navigation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaitForMe',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1)
      ),
      routes: {
        '/' : (context) => const DriverNavigationPage(),
        '/cities' : (context) => const CitiesPage(),
        '/notifying' : (context) => const NotifyingPage()
      },
    );
  }
  
}