import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BusesPage extends StatefulWidget {
  const BusesPage({super.key});

  @override
  State<BusesPage> createState() => _BusesPageState();
}

class _BusesPageState extends State<BusesPage> {

  List<int> busNumbers = [16, 37, 48, 59, 99, 119, 126, 201, 206, 16, 37, 48, 59, 99, 119, 126, 201, 206, 16, 37, 48, 59, 99, 119, 126, 201, 206];
  List<int> selectedBusNumbers = [16, 37, 48];

  @override
  Widget build(BuildContext context) {
    return Column(
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
              const SizedBox(height: 12),
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
                        backgroundColor: Color.fromRGBO(215, 223, 229, 1),
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
      ],
    );
  }

}