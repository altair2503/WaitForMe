import 'package:flutter/material.dart';

class BusesPage extends StatefulWidget {
  const BusesPage({super.key});

  @override
  State<BusesPage> createState() => _BusesPageState();
}

class _BusesPageState extends State<BusesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red
          ),
          height: 110,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: Text("City Name"),
          ),
        )
      ],
    );
  }
}