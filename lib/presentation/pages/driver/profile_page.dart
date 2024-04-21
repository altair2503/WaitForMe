// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/services/bus_service.dart';

import 'package:wait_for_me/constants/colors.dart';
import 'package:wait_for_me/constants/routes.dart';

import 'package:wait_for_me/dialogs/driver_shift_dialog.dart';
import 'package:wait_for_me/dialogs/logout_dialog.dart';

import 'package:wait_for_me/models/auth_user.dart';
import 'package:wait_for_me/models/bus_model.dart';


class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  
  late final TextEditingController _busNumber;

  AuthUser? _user;
  bool? _isShiftActive;
  Bus? driverBusNumber;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _busNumber = TextEditingController();
    List l1 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    List l2 = [1, 2, 3, 4, 5, 6, 7];
    List l3 = [1, 2, 3, 4];
    l1.removeWhere((item) => !l2.contains(item));
    l1.removeWhere((item) => !l3.contains(item));
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
    double adjustedHeight = screenHeight - 155;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 100),
          color: mainColor,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 60),
              width: MediaQuery.of(context).size.width,
              height: adjustedHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: _user != null 
                        ? Text(
                          '${_user?.name} ${_user?.surname}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ) 
                        : FutureBuilder(
                          future: AuthService.firebase().getCurrentUser(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.connectionState == ConnectionState.done) {
                              if(snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if(snapshot.hasData) {
                                _user = snapshot.data;
                                return Text(
                                  '${_user?.name} ${_user?.surname}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  ),
                                );
                              } 
                              else {
                                return const Text('No user found');
                              }
                            } 
                            else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )
                      ),
                      _isShiftActive == true
                      ? Column(
                        children: [
                          Stack(
                            children: [
                              const Image(
                                image: AssetImage('assets/icons/driver.gif.webp'),
                                width: 270
                              ),
                              Positioned(
                                top: 0,
                                left: screenWidth / 2 + 10,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 233, 233, 233),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: StreamBuilder<Bus?>(
                                      stream: BusService.instance?.readDriverBusNumber(),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasError) {
                                          return const Text('No bus found');
                                        } 
                                        else if(snapshot.hasData) {
                                          final driverBusNumber = snapshot.data!;
                                          print(driverBusNumber.number);
                                          return Text(
                                            driverBusNumber.number,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                            ),
                                          );
                                        } 
                                        else {
                                          return const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                                            )
                                          );
                                        }
                                      }
                                    )
                                  )
                                ),
                              )
                            ]
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 35.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final dialog = await changeShiftDialog(context);
                                if(dialog) {
                                  _busNumber.clear();
                                  _fetchData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white
                              ),
                              child: const Text("Change bus number"),
                            )
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final dialog = await endShiftDialog(context);
                                if(dialog) {
                                  await BusService.instance?.removeDriverFromBuses();
                                  _busNumber.clear();
                                  setShiftActive(false);
                                  _fetchData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                backgroundColor: const Color.fromARGB(255, 226, 81, 71),
                                foregroundColor: Colors.white
                              ),
                              child: const Text("End shift"),
                            )
                          ),
                        ]
                      )
                      : Column(
                        children: [
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
                                final busNumber = _busNumber.text;
                                final dialog = await startShiftDialog(context, busNumber);

                                if(dialog) {
                                  await BusService.instance?.assignBusNumber(number: busNumber);
                                  setShiftActive(true);
                                  _fetchData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                              backgroundColor: greenColor,
                              foregroundColor: Colors.white),
                              child: const Text("Start shift"),
                            )
                          )
                        ]
                      ),
                    ]
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        final dialog = await showLogoutDialog(context);
                        if(dialog) {
                          await AuthService.firebase().logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(welcome, (route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: mainColor),
                        backgroundColor: lightGrayColor,
                        foregroundColor: mainColor,
                      ),
                      child: const Text("Logout")
                    )
                  ),
                ]
              ),
            )
          )
        ),
        Positioned(
          top: 50,
          left: screenWidth / 2 - 50,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/driver_profile.png', width: 100, height: 100)
            )
          )
        )
      ]
    );
  }
}
