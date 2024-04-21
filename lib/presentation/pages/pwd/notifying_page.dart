import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:wait_for_me/models/bus_model.dart';

import 'package:wait_for_me/services/notification_service.dart';
import 'package:wait_for_me/services/bus_service.dart';


class NotifyingPage extends StatefulWidget {

  final List<Bus> selectedBusNumbers;

  const NotifyingPage({super.key, required this.selectedBusNumbers});

  @override
  State<NotifyingPage> createState() => _NotifyingPageState(selectedBusNumbers: selectedBusNumbers);

}

class _NotifyingPageState extends State<NotifyingPage> {

  final List<Bus> selectedBusNumbers;

  bool found = false;

  _NotifyingPageState({required this.selectedBusNumbers});

  @override
  void initState() {
    super.initState();
    makeNotify();
  }

  void makeNotify() async {
    BusService.instance?.addUser(selectedBusNumbers).then((value) async => {
      await NotificationService.instance?.sendNotificationToDrivers(selectedBusNumbers, "Passenger is waiting for you"),
        Future
        .delayed(const Duration(milliseconds: 7000))
        .then((value) => setState(() {
          found = true;
        }))
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.png'),
                fit: BoxFit.cover
              )
            )
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: !found ? const EdgeInsets.only(bottom: 20) : const EdgeInsets.only(bottom: 140),
            child: const Align(
              alignment: Alignment.center,
              child: Image(image: AssetImage('assets/icons/location.gif'), width: 90)
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            margin: !found ? const EdgeInsets.only(bottom: 29) : const EdgeInsets.only(bottom: 149),
            child: const Image(
              image: AssetImage('assets/icons/locationicon.png'),
              width: 45
            )
          ),
          SafeArea(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: !found ? const EdgeInsets.fromLTRB(20, 30, 20, 30) : const EdgeInsets.fromLTRB(15, 45, 15, 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(.06)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    if(found) const Image(image: AssetImage('assets/icons/driver.gif.webp'), width: 300),
                    if(found) const SizedBox(height: 18),
                    if(found) Text(
                      'Drivers ${selectedBusNumbers.toString().substring(1, selectedBusNumbers.toString().length - 1)} have been notified, expect.', 
                      style: const TextStyle(fontSize: 18)
                    ),
                    if(found) const Divider(height: 40, color: Color.fromRGBO(0, 0, 0, .1)),
                    if(found) const SizedBox(height: 10),
                    if(!found)
                      Row(
                        children: [
                          const Text('We notifying drivers nearby ', style: TextStyle(fontSize: 19)),
                          AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 500),
                            animatedTexts: [
                              TyperAnimatedText('...',
                              textStyle: const TextStyle(fontSize: 19),
                              speed: const Duration(milliseconds: 250))
                            ]
                          )
                        ],
                      ),
                    if(!found) const SizedBox(height: 15),
                    Row(
                      children: [
                        if(found)
                          Expanded(
                            child: TextButton(
                              onPressed: () => {
                                // BusService.instance?.removeUser(),
                                // NotificationService.instance?.sendNotificationToDrivers(selectedBusNumbers, "Passenger is on the bus"),
                                // Navigator.pop(context)
                                Navigator.pushNamed(context, '/pwd-on-way-page')
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(22, 35, 56, 1),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                padding: const EdgeInsets.symmetric(vertical: 16)
                              ),
                              child: const Text(
                                "I'm on bus",
                                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white)
                              ),
                            )
                          ),
                        if(found) const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            onPressed: () => {
                              BusService.instance?.removeUser(),
                              NotificationService.instance?.sendNotificationToDrivers(selectedBusNumbers, "Passenger canceled the request"),
                              Navigator.pop(context)
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: found ? const Color.fromRGBO(243, 243, 243, 1) : const Color.fromRGBO(22, 35, 56, 1),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.symmetric(vertical: found ? 16 : 18)),
                              child: Text("Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: found  ? Colors.black : Colors.white
                              )
                            )
                          )
                        )
                      ],
                    )
                  ]
                ),
              )
            )
          )
        ]
      )
    );
  }
}
