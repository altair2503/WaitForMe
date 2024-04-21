import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';

import 'package:wait_for_me/models/bus_model.dart';


class BusStationsPage extends StatefulWidget {

  final List<Bus> selectedBusNumbers;

  const BusStationsPage({super.key, required this.selectedBusNumbers});

  @override
  State<BusStationsPage> createState() => _BusStationsPageState(selectedBusNumbers: selectedBusNumbers);

}

class _BusStationsPageState extends State<BusStationsPage> {

  final List<Bus> selectedBusNumbers;

  _BusStationsPageState({required this.selectedBusNumbers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 15),
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
                      "Bus Stations",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                  ]
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color.fromRGBO(0, 0, 0, .1)),
              ),
              child: Row(
                children: [
                  const Icon(Ionicons.bus_outline, size: 24, color: Color.fromRGBO(0, 0, 0, .8)),
                  const Text(':', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  ...Iterable<int>.generate(selectedBusNumbers.length).map(
                  (int index) => Flexible(
                    child: Container(
                      width: 45,
                      height: 30,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(0, 0, 0, .05)),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: const Color.fromRGBO(215, 223, 229, 1)
                      ),
                      child: Text(
                        selectedBusNumbers[index].number,
                        style: const TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.w500, 
                          color: Color.fromRGBO(30, 54, 89, 1)
                        )
                      )
                    )
                  ))
                ]
              )
            ),
            TextButton(
              onPressed: () {}, 
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Ionicons.swap_vertical_outline, size: 21, color: Color.fromRGBO(41, 86, 154, 1)),
                  SizedBox(width: 5),
                  Text(
                    "Change direction",
                    style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ]
              )
            ),
          ]
        ),
      )
    );
  }
}