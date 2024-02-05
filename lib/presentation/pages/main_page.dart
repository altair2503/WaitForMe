// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:wait_for_me/presentation/pages/buses_page.dart';
import 'package:wait_for_me/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Widget> pages = [
    const BusesPage(), 
    const ProfilePage()
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
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // Routing Options
        onTap: onTap,
        currentIndex: currentIndex,
        // Items Color Options
        selectedItemColor: Colors.black,
        // Label Options
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // Elevation Options
        elevation: 0,
        // Icons Size Options
        iconSize: 40,
        // BottomNavigationBar Items list
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert_outlined), 
            label: "Bus"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), 
            label: "Profile"
          ),
        ]
      ),
    );
  }

}
