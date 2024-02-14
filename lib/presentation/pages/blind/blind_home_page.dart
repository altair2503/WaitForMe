// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wait_for_me/models/bus_model.dart';
import 'package:wait_for_me/presentation/pages/blind/notifying_page.dart';
import 'package:wait_for_me/services/bus_service.dart';

class BlindHomePage extends StatefulWidget {
  const BlindHomePage({super.key});

  @override
  State<BlindHomePage> createState() => _BlindHomePageState();
}

class _BlindHomePageState extends State<BlindHomePage> {

  // List<int> busNumbers = [1, 2, 16, 37, 48, 59, 99, 119, 126, 201, 206];
  List<Bus> selectedBusNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          // City choose button UI
          _BlindHomePageTopBarUI(),
          // Title of the page UI
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 12),
            child: const Text(
              "Transport List",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
            )
          ),
          // Selected bus numbers UI
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color.fromRGBO(0, 0, 0, .1)),
            ),
            child: Column(
              children: [
                const Row(children: [
                  Icon(Ionicons.bus_outline,
                      size: 20, color: Color.fromRGBO(0, 0, 0, .7)),
                  SizedBox(width: 6),
                  Text("Selected bus numbers:", style: TextStyle(fontSize: 17))
                ]),
                selectedBusNumbers.isNotEmpty
                    ? const SizedBox(height: 10)
                    : const SizedBox(),
                GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      for(var bus in selectedBusNumbers)
                        OutlinedButton(
                          onPressed: () => {
                            setState(() {
                              selectedBusNumbers.remove(bus);
                            })
                          },
                          style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              side: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, .05)),
                              backgroundColor:
                                  const Color.fromRGBO(215, 223, 229, 1),
                              padding: EdgeInsets.zero),
                          child: Text(bus.number,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(30, 54, 89, 1))),
                        )
                    ])
              ],
            ),
          ),
          StreamBuilder<List<Bus>>(
            stream: BusService.getBuses(), 
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } 
              else if(snapshot.hasData) {
                final buses = snapshot.data!;

                return Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    scrollDirection: Axis.vertical,
                    children: [
                      for(var bus in buses)
                        OutlinedButton(
                          onPressed: () => {
                            if(!selectedBusNumbers.contains(bus)) {
                              setState(() {
                                selectedBusNumbers.add(bus);
                              })
                            } else setState(() { selectedBusNumbers.remove(bus); })
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                            borderRadius:  BorderRadius.all(Radius.circular(15))),
                            side: const BorderSide(color: Color.fromRGBO(0, 0, 0, .05)),
                            backgroundColor: selectedBusNumbers.contains(bus) ? const Color.fromRGBO(41, 86, 154, 1) : const Color.fromRGBO(250, 250, 250, 1),
                            padding: EdgeInsets.zero
                          ),
                          child: Text(
                            bus.number,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: selectedBusNumbers.contains(bus) ? Colors.white : const Color.fromRGBO(30, 54, 89, 1)
                            )
                          ),
                        )
                    ]
                  )
                );
              } 
              else {
                return const Text("Loading");
              }
            },)
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
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0, -0.5)
            )
          ]
        ),
        child: SizedBox(
          width: double.infinity,
          height: 62,
          child: TextButton(
            onPressed: selectedBusNumbers.isNotEmpty 
            ? 
              () => {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder : (context) => NotifyingPage(selectedBusNumbers: selectedBusNumbers))
                )
              } 
            : null,
            style: TextButton.styleFrom(
              backgroundColor: selectedBusNumbers.isNotEmpty ? const Color.fromRGBO(41, 86, 154, 1) : Colors.black.withOpacity(.4),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
            ),
            child: const Text("Notify", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white)),
          )
        ),
      )
    );
  }
}

class _BlindHomePageTopBarUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .15), offset: Offset(0, 0.4))
      ]),
      child: Row(
        children: [
          Expanded(
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cities');
                  },
                  style: TextButton.styleFrom(
                      iconColor: Colors.black.withOpacity(.8),
                      padding: const EdgeInsets.symmetric(horizontal: 20)),
                  child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Ionicons.business_outline, size: 21),
                            SizedBox(width: 7),
                            Text(
                              "Almaty",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(width: 8),
                        Icon(Ionicons.chevron_forward_outline, size: 18)
                      ]))),
          Expanded(
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      iconColor: Colors.black.withOpacity(.8),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight),
                  child: const Icon(Ionicons.log_out_outline,
                      size: 28, color: Color.fromRGBO(41, 86, 154, 1))))
        ],
      ),
    );
  }
}
