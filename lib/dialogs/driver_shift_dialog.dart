// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wait_for_me/services/bus_service.dart';

Future<bool> startShiftDialog(BuildContext context, String busNumber) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          'Start shift on bus №$busNumber?',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        content: const Text(
          'Do you want to start the shift. Please, double check!',
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
                "Yes",
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

Future<bool> endShiftDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text(
          'End shift',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        content: const Text(
          'Are you sure you want to end shift?',
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
                "Yes",
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

TextEditingController _newBusNumber = TextEditingController();

Future<bool> changeShiftDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text(
          'Enter bus number',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        content: TextField(
          controller: _newBusNumber,
          decoration: const InputDecoration(hintText: "Enter bus number"),
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
              onPressed: () async {
                await BusService.instance?.changeBusNumber(number: _newBusNumber.text);
                _newBusNumber.clear();
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              child: const Text(
                "Save",
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