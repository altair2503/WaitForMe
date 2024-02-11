import 'package:flutter/material.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/auth/auth_user.dart';
import 'package:wait_for_me/constants/colors.dart';
import 'package:wait_for_me/constants/routes.dart';
import 'package:wait_for_me/dialogs/driver_shift_dialog.dart';
import 'package:wait_for_me/dialogs/logout_dialog.dart';
import 'package:wait_for_me/services/bus_model.dart';
import 'package:wait_for_me/services/bus_service.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  late final TextEditingController _busNumber;

  AuthUser? _user;
  bool? _isShiftActive;
  Bus? _driverBusNumber;

  @override
  void initState() {
    super.initState();
    _busNumber = TextEditingController();
    _fetchData();
  }

  @override
  void dispose() async {
    _busNumber.dispose();
    super.dispose();
  }

  void setShiftActive(bool value) {
    setState(() {
      _isShiftActive = !_isShiftActive!;
    });
  }

  Future<void> _fetchData() async {
    final value = await BusService.instance?.driverIsActive();
    setState(() {
      _isShiftActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight =
        MediaQuery.of(context).padding.top; // Height of status bar
    double adjustedHeight = screenHeight - 200 - statusBarHeight;

    return Stack(children: [
      Container(
          padding: const EdgeInsets.only(top: 100),
          color: mainColor,
          child: Center(
              child: Container(
            padding: const EdgeInsets.only(right: 25, left: 25, top: 60),
            height: adjustedHeight,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: _user != null
                            ? Text(
                                '${_user?.name} ${_user?.surname}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: mainColor),
                              )
                            : FutureBuilder(
                                future: AuthService.firebase().getCurrentUser(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    if (snapshot.hasData) {
                                      _user = snapshot.data;
                                      return Text(
                                        '${_user?.name} ${_user?.surname}',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: mainColor),
                                      );
                                    } else {
                                      return const Text('No user found');
                                    }
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              )),
                    _isShiftActive == false || _isShiftActive == null
                        ? Column(children: [
                            TextField(
                              textAlign: TextAlign.center,
                              controller: _busNumber,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: "Enter bus number",
                                hintStyle: TextStyle(color: grayColor),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 20.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final busNumber =
                                        int.parse(_busNumber.text);
                                    final dialog = await startShiftDialog(
                                        context, busNumber);
                                    if (dialog) {
                                      await BusService.instance
                                          ?.assignBusNumber(number: busNumber);
                                      setShiftActive(true);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      backgroundColor: greenColor,
                                      foregroundColor: Colors.white),
                                  child: const Text("Start shift"),
                                ))
                          ])
                        : Column(
                            children: [
                              Stack(children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/icons/driver.gif.webp'),
                                    width: 250),
                                Positioned(
                                  top: 0,
                                  left: screenWidth / 2,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                      ),
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: FutureBuilder(
                                            future: BusService.instance
                                                ?.getDriverBusNumber(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }
                                                if (snapshot.hasData) {
                                                  _driverBusNumber =
                                                      snapshot.data;
                                                  return Text(
                                                    '${_driverBusNumber?.number}',
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  );
                                                } else {
                                                  return const Text(
                                                      'No user found');
                                                }
                                              } else {
                                                return const SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ))),
                                )
                              ]),
                              Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 20.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await changeShiftDialog(context);
                                      _busNumber.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                        backgroundColor: mainColor,
                                        foregroundColor: Colors.white),
                                    child: const Text("Change bus number"),
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 20.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final dialog =
                                          await endShiftDialog(context);
                                      if (dialog) {
                                        await BusService.instance
                                            ?.driverEndShift();
                                        _fetchData();
                                        _busNumber.clear();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                        backgroundColor: redColor,
                                        foregroundColor: Colors.white),
                                    child: const Text("End shift"),
                                  )),
                            ],
                          ),
                  ]),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          final dialog = await showLogoutDialog(context);
                          if (dialog) {
                            await AuthService.firebase().logout();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                welcome, (route) => false);
                          }
                        },
                        child: const Text("Logout"),
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: mainColor),
                          backgroundColor: lightGrayColor,
                          foregroundColor: mainColor,
                        ),
                      )),
                ]),
          ))),
      Positioned(
          top: 50,
          left: screenWidth / 2 - 50,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/driver_profile.png',
                width: 100,
                height: 100,
              ),
            ),
          )),
    ]);
  }
}
