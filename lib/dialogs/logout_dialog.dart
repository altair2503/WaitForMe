import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text(
          'Log out',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(0, 0, 0, .85)
              )
            )
          ),
          SizedBox(
            width: 120,
            height: 45,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              child: const Text(
                "Log out",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                )
              )
            )
          )
        ]
      );
    }
  ).then((value) => value ?? false);
}