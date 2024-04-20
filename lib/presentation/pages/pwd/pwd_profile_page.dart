// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/dialogs/logout_dialog.dart';

import 'package:wait_for_me/auth/auth_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wait_for_me/models/auth_user.dart';


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
    {
      'name': 'PWD',
      'img': 'assets/images/vi_role.png'
    },
  ];
  
  final CarouselController _controller = CarouselController();
  int currentIndex = 0;

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
              Column(
                children: [
                  const SizedBox(height: 20),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enableInfiniteScroll: false,
                      initialPage: 1,
                      height: 330
                    ),
                    carouselController: _controller,
                    items: pwdRoles.asMap().map((index, roles) =>
                      MapEntry(
                        index,
                        Container(
                          width: 280,
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(250, 250, 250, 1),
                            border: Border.all(color: Colors.black.withOpacity(.06)),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Stack(
                            children: [
                              Image(
                                image: AssetImage(roles['img'].toString()),
                                width: index > 0 ? 118 : 125
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  roles['name'].toString(),
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                )
                              )
                            ],
                          )
                        ),
                      ),
                    ).values.toList()
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...Iterable<int>.generate(pwdRoles.length).map(
                        (int pageIndex) => Flexible(
                          child: Container(
                            width: pageIndex == 1 ? 1000 : null,
                            height: pageIndex == 1 ? null : 45,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            child: TextButton(
                              onPressed: () async {
                                if(await AuthService.firebase()
                                    .changeRole(pageIndex == 0 ? "PWD_DI" : (pageIndex == 1 ? "PWD_VI" : "PWD"))){
                                  print("changed");
                                } else{
                                  print("not changed"); 
                                };


                                _controller.animateToPage(pageIndex);
                                currentIndex = pageIndex;
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: currentIndex == pageIndex ? Color.fromRGBO(41, 86, 154, 1) : Colors.grey,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                side: BorderSide(color: Colors.black.withOpacity(.06))
                              ),
                              child: Text(
                                pwdRoles[pageIndex]['name'].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                                )
                              )
                            )
                          )
                        )
                      )
                    ],
                  )
                ]
              )
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
            onPressed: () async {
              final dialog = await showLogoutDialog(context);
              if(dialog) {
                await AuthService.firebase().logout();
                Navigator.of(context).pushNamedAndRemoveUntil(welcome, (route) => false);
              }
            },
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