import 'package:flutter/material.dart';
import 'package:wait_for_me/services/bus_service.dart';

Future<bool> startShiftDialog(BuildContext context, String busNumber) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
                'Do you want to start the shift on bus number $busNumber?'),
            content: const Text('Please, double check!'),
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
                  child: const Text('Yes'))
            ]);
      }).then((value) => value ?? false);
}

Future<bool> endShiftDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Do you want to end shift'),
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
                  child: const Text('Yes'))
            ]);
      }).then((value) => value ?? false);
}

TextEditingController _newBusNumber = TextEditingController();

Future<bool> changeShiftDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Enter bus number'),
            content: TextField(
              controller: _newBusNumber,
              decoration: const InputDecoration(hintText: "Enter bus number"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Discard')),
              TextButton(
                  onPressed: () async {
                    await BusService.instance?.assignBusNumber(
                        number: _newBusNumber.text);
                    _newBusNumber.clear();
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Save'))
            ]);
      }).then((value) => value ?? false);
}
