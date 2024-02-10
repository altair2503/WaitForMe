import 'package:flutter/material.dart';
import 'dart:developer' show log;
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/enums/menu_actions.dart';

class MainView extends StatelessWidget {
 
  const MainView({super.key});

@override

Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: 
          FutureBuilder(
        future: AuthService.firebase().getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData) {
              final user = snapshot.data;
              return Text('Name: ${user?.role ?? "Unavailable"}');
            } else {
              return const Text('No user found');
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
          ),
          actions: [
            PopupMenuButton<HomePageMenuActions>(
              onSelected: (value) async {
                switch (value) {
                  case HomePageMenuActions.logout:
                    final shouldLogout = await showLogoutDialog(context);
                    log(shouldLogout.toString());
                    if (shouldLogout) {
                      AuthService.firebase().logout();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                    }
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<HomePageMenuActions>(
                      value: HomePageMenuActions.logout, child: Text('Log out'))
                ];
              },
            )
          ],
        ),
        body: const Text("Welcome!")
        );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Log out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Log out'))
            ]);
      }).then((value) => value ?? false);
}
