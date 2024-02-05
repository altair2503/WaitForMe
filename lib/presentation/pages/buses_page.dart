import 'package:flutter/material.dart';

class BusesPage extends StatefulWidget {
  const BusesPage({super.key});

  @override
  State<BusesPage> createState() => _BusesPageState();
}

class _BusesPageState extends State<BusesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Buses"),
    );
  }
}