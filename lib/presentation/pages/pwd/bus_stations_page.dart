import 'package:flutter/material.dart';
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
        child: Container(

        ),
      )
    );
  }
}