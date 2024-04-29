// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:wait_for_me/models/bus_model.dart';
import 'package:wait_for_me/models/stops_model.dart';
import 'package:wait_for_me/presentation/pages/pwd/notifying_page.dart';
import 'package:wait_for_me/services/stop_service.dart';

class BusStationsPage extends StatefulWidget {

  final List<Bus> selectedBusNumbers;

  const BusStationsPage({super.key, required this.selectedBusNumbers});

  @override
  State<BusStationsPage> createState() => _BusStationsPageState(selectedBusNumbers: selectedBusNumbers);

}

class _BusStationsPageState extends State<BusStationsPage> {

  final List<Bus> selectedBusNumbers;
  List<Stop> busStations = [];

  var selectedStation;

  _BusStationsPageState({required this.selectedBusNumbers});

  @override
  void initState() {
    super.initState();
    StopService.instance?.getStops(selectedBusNumbers).then((value) => {
      setState(() {
        busStations = value;
      })
    });
  }

  void changeDirection() {
    setState(() {
      busStations = busStations.reversed.toList();
    });
  }

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
                onPressed: () {
                  Navigator.pop(context);
                },
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                  ]
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
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
                          borderRadius: const BorderRadius.all(Radius.circular(8)
                        ),
                        color: const Color.fromRGBO(215, 223, 229, 1)),
                        child: Text(
                          selectedBusNumbers[index].number,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(30, 54, 89, 1)
                          )
                        )
                      )
                    )
                  )
                ]
              )
            ),
            TextButton(
              onPressed: changeDirection,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Ionicons.swap_vertical_outline, size: 22, color: Color.fromRGBO(41, 86, 154, 1)),
                  SizedBox(width: 5),
                  Text(
                    "Change direction",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    )
                  )
                ]
              )
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: busStations.length > 7 ? 1 : 0,
              child: Stack(
                children: [
                  Positioned.fill(
                    left: 21,
                    right: MediaQuery.of(context).size.width - 26,
                    child: Container(
                      width: 20,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color.fromRGBO(215, 215, 215, 1)
                      )
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
                                  border: selectedStation == i ? Border.all(color: const Color.fromRGBO(41, 86, 154, 1)) : null
                                ),
                                child: selectedStation == i ? Container(
                                  width: 13,
                                  height: 13,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                    color: Color.fromRGBO(41, 86, 154, 1)
                                  )
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
                                      busStations[i].name,
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
            ),
            const SizedBox(height: 20)
          ]
        ),
      ),
      bottomNavigationBar: Container(
        height: 105,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
            onPressed: selectedStation != null ? () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotifyingPage(selectedBusNumbers: selectedBusNumbers, busStations: busStations.sublist(0, selectedStation + 1))
                )
              )
            } : null,
            style: TextButton.styleFrom(
              backgroundColor: selectedStation != null ? const Color.fromRGBO(41, 86, 154, 1) : Colors.black.withOpacity(.4),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Ionicons.radio_outline, size: 26, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "Notify",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  )
                )
              ]
            )
          )
        ),
      )
    );
  }
}
