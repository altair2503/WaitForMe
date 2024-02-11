import 'package:flutter/material.dart';

@immutable
class Bus {
  final int number;
  // final String location;

  const Bus({
    required this.number
  });

  factory Bus.fromFirebase({required int number}) =>
      Bus(
        number : number
      );
}