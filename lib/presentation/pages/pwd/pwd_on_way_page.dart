// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PwdOnWayPage extends StatefulWidget {
  const PwdOnWayPage({super.key});

  @override
  State<PwdOnWayPage> createState() => _PwdOnWayPageState();
}

class _PwdOnWayPageState extends State<PwdOnWayPage> {

  int selectedBusNumber = 126;
  final List<String> busStations = ['Astana alley', 'Silk Way', 'Seifullin street', 'Almaty Technical University', 'Muratbayev street', 'Mukanov street'];

  var selectedStation;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.only(bottom: 40),
              padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
              decoration: const BoxDecoration(
                color: Colors.white, 
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, .18), offset: Offset(0, 0.4))
                ]
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Ionicons.bus_outline, size: 22),
                  SizedBox(width: 6),
                  Text(
                    "Bus Route",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ]
              )
            ),
            Stack(
              children: [
                Positioned.fill(
                  left: 21,
                  right: MediaQuery.of(context).size.width - 26,
                  child: Container(
                    width: 20,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color.fromRGBO(215, 215, 215, 1)
                    ),
                  )
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    for(int i = 0; i < busStations.length; i++)
                      Container(
                        margin: EdgeInsets.only(left: selectedStation == i ? 13 : 17, right: 20),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: selectedStation == i ? 21 : 13,
                              height: selectedStation == i ? 21 : 13,
                              decoration: BoxDecoration(
                                borderRadius: selectedStation == i ? const BorderRadius.all(Radius.circular(11)) : const BorderRadius.all(Radius.circular(7)),
                                color: selectedStation != i ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromRGBO(255, 255, 255, 1),
                                border: selectedStation == i ? Border.all(color: const Color.fromRGBO(41, 86, 154, 1), width: 1.5) : null
                              ),
                              child: selectedStation == i ? const Icon(
                                Ionicons.bus, 
                                size: 13, 
                                color: Color.fromRGBO(41, 86, 154, 1)
                              ) : null,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: i != busStations.length - 1 ? const BorderDirectional(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, .2), width: .3)) : const BorderDirectional(bottom: BorderSide(color: Colors.white))
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedStation = i;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8)
                                  ),
                                  child: Text(
                                    busStations[i],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: selectedStation == i ? FontWeight.w500 : FontWeight.w400,
                                      color: selectedStation == i ? const Color.fromRGBO(41, 86, 154, 1) : Colors.black
                                    ),
                                  )
                                )
                              )
                            )
                          ]
                        )
                      )
                  ]
                )
              ]
            )
          ]
        )
      ),
      bottomNavigationBar: Container(
        height: 105,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(29, 0, 20, 20),
        decoration: const BoxDecoration(
          color: Colors.white, 
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0, -0.5))
          ]
        ),
        child: SizedBox(
          width: double.infinity,
          height: 62,
          child: TextButton(
            onPressed: () => {
              // BusService.instance?.removeUser(),
              // NotificationService.instance?.sendNotificationToDrivers(selectedBusNumbers, "Passenger canceled the request"),
              Navigator.pushNamed(context, 'pwd-home-page')
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.walk_outline,
                  size: 25, 
                  color: Colors.white
                ),
                SizedBox(width: 6),
                Text("I have arrived", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white))
              ]
            )
          )
        ),
      )
    );
  }

}