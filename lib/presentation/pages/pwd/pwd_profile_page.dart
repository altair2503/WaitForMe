// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/services/bus_service.dart';
import 'package:wait_for_me/presentation/pages/pwd/notifying_page.dart';
import 'package:wait_for_me/services/notification_service.dart';
import 'package:wait_for_me/services/location_service.dart';
import 'package:wait_for_me/services/tts_service.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:ionicons/ionicons.dart';


class PwdProfilePage extends StatefulWidget {
  const PwdProfilePage({super.key});

  @override
  State<PwdProfilePage> createState() => _PwdProfilePageState();
}

class _PwdProfilePageState extends State<PwdProfilePage> {

  List<Map<String, String>> pwdRoles = [
    {
      'name': 'Disabled',
      'img': 'assets/images/di_role.png'
    },
    {
      'name': 'Visualy Impaired',
      'img': 'assets/images/vi_role.png'
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
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
                        "Profile",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                    ]
                  )
                ),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                  items: pwdRoles.asMap().map((index, roles) =>
                    MapEntry(
                      index,
                      Container(
                        child: Text(roles['name'].toString()),
                      ),
                    ),
                  ).values.toList()
                )
              ),
            ]
          )
        )
      ),
      bottomNavigationBar: Container(
        height: 105,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(29, 0, 20, 20),
        decoration: const BoxDecoration(
          color: Colors.white, 
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0, -0.5))
          ]
        ),
        child: SizedBox(
          width: double.infinity,
          height: 62,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(41, 86, 154, 1),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
            ),
            child: const Text(
              "Exit",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.white
              )
            ),
          )
        ), 
      ) 
    );
  }

}