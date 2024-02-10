import 'package:flutter/material.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      color: Colors.black,
                      child: Image(image: AssetImage('assets/images/driver.png')),
                    )
                  ],
                )
              ]
            )
          )
        ],
      ),
    );
  }
}