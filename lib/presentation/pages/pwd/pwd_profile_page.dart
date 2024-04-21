// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/dialogs/logout_dialog.dart';

import 'package:wait_for_me/auth/auth_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ionicons/ionicons.dart';

class PwdProfilePage extends StatefulWidget {
  const PwdProfilePage({super.key});

  @override
  State<PwdProfilePage> createState() => _PwdProfilePageState();
}

class _PwdProfilePageState extends State<PwdProfilePage> {

  var user;

  List<Map<String, String>> pwdRoles = [
    {'name': 'Disabled', 'role': 'PWD_DI', 'img': 'assets/images/di_role.png'},
    {'name': 'Visualy Impaired', 'role': 'PWD_VI', 'img': 'assets/images/vi_role.png'},
    {'name': 'PWD', 'role': 'PWD', 'img': 'assets/images/vi_role.png'},
  ];

  final CarouselController _controller = CarouselController();

  var currentIndex;
  var initialPageIndex;

  Future <void> _fetchData() async {
    final data = await AuthService.firebase().getCurrentUser();
    setState(() { 
      user = data; 
      initialPageIndex = pwdRoles.indexWhere((role) => role['role'] == data?.role);
      currentIndex = initialPageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                      ),
                      Icon(Ionicons.chevron_back, size: 21, color: Colors.white)
                    ]
                  )
                ),
              ),
              initialPageIndex != null ? Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...Iterable<int>.generate(pwdRoles.length).map(
                      (int pageIndex) => Flexible(
                        child: Container(
                          height: 52,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: TextButton(
                            onPressed: () async {
                              if(
                                await AuthService.firebase()
                                .changeRole(pageIndex == 0 ? "PWD_DI" : (pageIndex == 1 ? "PWD_VI" : "PWD"))
                              ) {
                                debugPrint('Role changed to ${pwdRoles[pageIndex]["name"]}');
                              } else {
                                debugPrint('Role not changed');
                              }
                              _controller.animateToPage(pageIndex);
                              setState(() {
                                currentIndex = pageIndex;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: currentIndex == pageIndex ? const Color.fromRGBO(41, 86, 154, 1) : const Color.fromRGBO(174, 174, 174, 1),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                              side: BorderSide(color: Colors.black.withOpacity(.06)),
                              padding: const EdgeInsets.symmetric(horizontal: 25)
                            ),
                            child: Text(
                              pwdRoles[pageIndex]['name'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.2
                              ),
                              textAlign: TextAlign.center,
                            )
                          )
                        )
                      )) 
                    ],
                  ),
                  const SizedBox(height: 18),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      enlargeFactor: .11,
                      initialPage: initialPageIndex,
                      height: 330,
                      viewportFraction: .67,
                      onPageChanged: (index, reason) async {
                        await AuthService.firebase()
                        .changeRole(index == 0 ? "PWD_DI" : (index == 1 ? "PWD_VI" : "PWD"));
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    carouselController: _controller,
                    items: pwdRoles.asMap().map((index, roles) => 
                      MapEntry(
                        index,
                        Container(
                          width: 250,
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(250, 250, 250, 255),
                            border: Border.all(color: Colors.black.withOpacity(.06)),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Stack(
                            children: [
                              Image(
                                image: AssetImage(roles['img'].toString()),
                                width: index > 0 ? 115 : 125
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  roles['name'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              )
                            ],
                          )
                        ),
                      ),
                    ).values.toList()
                  )
                ]
              ) : Container(alignment: Alignment.bottomCenter, height: 250, child: const Image(image: AssetImage('assets/images/loading.gif'), width: 160))
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.log_out_outline,
                  size: 26, 
                  color: Colors.white
                ),
                SizedBox(width: 6),
                Text("Log out", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white))
              ]
            )
          )
        ),
      )
    );
  }
}
