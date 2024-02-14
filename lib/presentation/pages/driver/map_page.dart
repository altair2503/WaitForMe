import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wait_for_me/presentation/pages/driver/google_map_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black.withOpacity(.15), width: .4))
          ),
          child: TextButton(
            onPressed: () {  },
            style: TextButton.styleFrom(
              iconColor: Colors.black.withOpacity(.8),
              padding: const EdgeInsets.symmetric(horizontal: 20)
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Ionicons.bus_outline, size: 20),
                SizedBox(width: 7),
                Text(
                  "201 Bus",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                )
              ]
            )
          )
        ),
         Expanded(
          child: GoogleMapPage()
        )
      ]
    );
  }
}