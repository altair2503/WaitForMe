import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:wait_for_me/presentation/pages/driver/map_page.dart';
import 'package:wait_for_me/presentation/pages/driver/profile_page.dart';

class DriverNavigationPage extends StatefulWidget {
  const DriverNavigationPage({super.key});

  @override
  State<DriverNavigationPage> createState() => _DriverNavigationPageState();
}

class _DriverNavigationPageState extends State<DriverNavigationPage> {

  List<Widget> pages = [
    const MapPage(),
    const DriverProfilePage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[currentIndex]
      ),
      bottomNavigationBar: 
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [ BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0, -0.5)) ]
          ),
          child: BottomNavigationBar(
          // Routing Options
            onTap: onTap,
            currentIndex: currentIndex,
            // Color Options
            selectedItemColor: const Color.fromRGBO(30, 54, 89, 1),
            unselectedItemColor: Colors.black.withOpacity(.4),
            backgroundColor: Colors.white, // Background color
            // Label Options
            showSelectedLabels: false,
            showUnselectedLabels: false,
            // Elevation Options
            elevation: 0,
            // Icons Size Options
            iconSize: 33,
            // BottomNavigationBar Items list
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.map,
                  size: 35,
                ),
                label: "Map"
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.person_circle_outline,
                  size: 40
                ), 
                label: "Profile"
              ),
            ]
          ),
      )
    );
  }

}