import 'package:flutter/material.dart';

class StationsPage extends StatefulWidget {
  const StationsPage({super.key});

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Stations Page"),
    );
  }
}