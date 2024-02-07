// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BlindNavigationPage extends StatefulWidget {
  const BlindNavigationPage({super.key});

  @override
  State<BlindNavigationPage> createState() => _BlindNavigationPageState();
}

class _BlindNavigationPageState extends State<BlindNavigationPage> {

  List<int> busNumbers = [16, 37, 48, 59, 99, 119, 126, 201, 206, 16, 37, 48, 59, 99, 119, 126, 201, 206, 16, 37, 48, 59, 99, 119, 126, 201, 206];
  List<int> selectedBusNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // City choose button
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [ BoxShadow(color: Color.fromRGBO(0, 0, 0, .15), offset: Offset(0, 0.4)) ]
              ),
              child: TextButton(
                onPressed: () => {}, 
                style: TextButton.styleFrom(
                  iconColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Ionicons.business_outline, size: 22),
                        SizedBox(width: 7),
                        Text(
                          "Almaty",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
                        )
                      ],
                    ),
                    Icon(Ionicons.chevron_forward, size: 23)
                  ]
                )
              ),
            ),
            // Title of the page
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 12),
              child: const Text(
                "Transport List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
              )
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color.fromRGBO(0, 0, 0, .1)),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Ionicons.bus_outline, size: 21),
                      SizedBox(width: 7),
                      Text("Selected bus numbers:", style: TextStyle(fontSize: 19))
                    ]
                  ),
                  GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      for(var number in selectedBusNumbers) 
                        OutlinedButton(
                          onPressed: () => {}, 
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                            side: const BorderSide(color: Color.fromRGBO(0, 0, 0, .05)),
                            backgroundColor: const Color.fromRGBO(215, 223, 229, 1),
                            padding: EdgeInsets.zero
                          ),
                          child: Text(
                            number.toString(),
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color.fromRGBO(30, 54, 89, 1))
                          ),
                        )
                    ]
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                scrollDirection: Axis.vertical,
                children: [
                  for(var number in busNumbers) 
                    OutlinedButton(
                      onPressed: () => {}, 
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        side: const BorderSide(color: Color.fromRGBO(0, 0, 0, .05)),
                        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
                        padding: EdgeInsets.zero
                      ),
                      child: Text(
                        number.toString(),
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color.fromRGBO(30, 54, 89, 1))
                      ),
                    )
                ]
              )
            )
          ]
        )
      ),
      bottomNavigationBar: 
        Container(
          height: 105,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(29, 0, 20, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [ BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0, -0.5)) ]
          ),
          child: SizedBox(
            width: double.infinity,
            height: 62,
            child: TextButton(
              onPressed: () => {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              child: const Text("Notify", style: TextStyle(fontSize: 20, color: Colors.white)),
            )
          ),
        )
    );
  }

}

// List<Widget> pages = [
//   const BusesPage(), 
//   const ProfilePage(),
// ];

// int currentIndex = 0;

// void onTap(int index) {
//   setState(() {
//     currentIndex = index;
//   });
// }

// return Scaffold(
//   body: SafeArea(
//     child: pages[currentIndex]
//   ),
//   bottomNavigationBar: 
//     Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [ BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0, -0.5)) ]
//       ),
//       child: BottomNavigationBar(
//       // Routing Options
//         onTap: onTap,
//         currentIndex: currentIndex,
//         // Color Options
//         selectedItemColor: const Color.fromRGBO(30, 54, 89, 1),
//         unselectedItemColor: Colors.black.withOpacity(.4),
//         backgroundColor: Colors.white, // Background color
//         // Label Options
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         // Elevation Options
//         elevation: 0,
//         // Icons Size Options
//         iconSize: 33,
//         // BottomNavigationBar Items list
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Ionicons.bus), 
//             label: "Bus"
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Ionicons.map,
//               size: 35,
//             ),
//             label: "Map"
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Ionicons.person_circle_outline,
//               size: 40
//             ), 
//             label: "Profile"
//           ),
//         ]
//       ),
//   )
// );