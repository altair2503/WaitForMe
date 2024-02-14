import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wait_for_me/constants/colors.dart';
import 'package:wait_for_me/models/bus_model.dart';
import 'package:wait_for_me/presentation/pages/driver/google_map_page.dart';
import 'package:wait_for_me/services/bus_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Bus? driverBusNumber;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 45,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(.15), width: .4))),
          child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  iconColor: Colors.black.withOpacity(.8),
                  padding: const EdgeInsets.symmetric(horizontal: 20)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Ionicons.bus_outline, size: 20),
                SizedBox(width: 7),
                StreamBuilder<Bus?>(
                    stream: BusService.instance?.readDriverBusNumber(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('No bus found');
                      } else if (snapshot.hasData) {
                        final driverBusNumber = snapshot.data!;
                        print("${driverBusNumber.number}");
                        return Text(
                          '${driverBusNumber.number}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: mainColor),
                        );
                      } else if (driverBusNumber == null) {
                        return Text(
                            'Please, start your shift on the profile page',
                            style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: mainColor));
                      } else {
                        print("Number: ${driverBusNumber}");
                        return Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(mainColor)));
                      }
                    })
              ]))),
      Expanded(child: GoogleMapPage())
    ]);
  }
}
