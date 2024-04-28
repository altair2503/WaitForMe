import 'package:flutter/material.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/constants/routes.dart';

import 'package:wait_for_me/presentation/pages/authorization/welcome_page.dart';
import 'package:wait_for_me/presentation/pages/authorization/registration_driver_page.dart';
import 'package:wait_for_me/presentation/pages/authorization/registration_user_page.dart';
import 'package:wait_for_me/presentation/pages/authorization/email_verify_view.dart';
import 'package:wait_for_me/presentation/pages/authorization/login_page.dart';

import 'package:wait_for_me/presentation/pages/pwd/pwd_home_page.dart';
import 'package:wait_for_me/presentation/pages/driver/driver_navigation_page.dart';
import 'package:wait_for_me/presentation/pages/pwd/cities_page.dart';
import 'package:wait_for_me/presentation/pages/pwd/pwd_on_way_page.dart';
import 'package:wait_for_me/presentation/pages/pwd/pwd_profile_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaitForMe',
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1)),
      home: const HomePage(),
      routes: {
        driverNavigation: (context) => const DriverNavigationPage(),
        cities: (context) => const CitiesPage(),
        loginRoute: (context) => const LoginView(),
        registerDriverRoute: (context) => const RegisterDriverView(),
        registerUserRoute: (context) => const RegisterPWDView(),
        emailVerifyRoute: (context) => const EmailVerifyView(),
        welcome: (context) => const WelcomePage(),
        pwdHomePage: (context) => const PwdHomePage(),
        driverHomePage: (context) => const DriverNavigationPage(),
        pwdProfilePage: (context) => const PwdProfilePage(),
        // pwdOnWayPage: (context) => const PwdOnWayPage(),
      }
    );
  }

}

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initilize(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.done:
            return const WelcomePage();
          default:
            return const CircularProgressIndicator();
        }
      }
    );
  }

}