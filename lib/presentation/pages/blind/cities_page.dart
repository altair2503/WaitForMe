import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {

  List<String> cities = ['Almaty', 'Astana', 'Shymkent', 'Pavlodar'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white, 
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, .15), offset: Offset(0, 0.4))
                ]
              ),
              child: TextButton(
                onPressed: () { Navigator.pop(context); },
                style: TextButton.styleFrom(
                  iconColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 15)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Ionicons.chevron_back, size: 21),
                    Text(
                      "Choose city",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                  ]
                )
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                for(int i = 0; i < cities.length; i++)
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: i != cities.length - 1 ? const BorderDirectional(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, .15), width: .3)) : const BorderDirectional(bottom: BorderSide(color: Colors.white))
                    ),
                    child: TextButton(
                      onPressed: i == 0 ? () => { } : null,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Ionicons.location_outline, size: 21, color: (i == 0 ? const Color.fromRGBO(0, 0, 0, .75) : const Color.fromRGBO(0, 0, 0, .3))),
                              const SizedBox(width: 5),
                              Text(
                                cities[i].toString(),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: (i == 0 ? Colors.black : const Color.fromRGBO(0, 0, 0, .4))),
                              )
                            ],
                          ),
                          i == 0 ? const Icon(Ionicons.checkmark_done_outline, size: 22, color: Color.fromRGBO(29, 79, 154, 1)) : const Text("Soon...", style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1)))
                        ]
                      )
                    ),
                  )
              ],
            )
          ],
        ),
      )
    );
  }

}
