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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(.2), width: .4))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            const Icon(Ionicons.bus_outline, size: 20),
            const SizedBox(width: 5),
            StreamBuilder<Bus?>(
              stream: BusService.instance?.readDriverBusNumber(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return const Text('No bus found');
                } 
                else if(snapshot.hasData) {
                  final driverBusNumber = snapshot.data!;
                  return Text(
                    // ignore: unnecessary_string_interpolations
                    '${driverBusNumber.number}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
                  );
                } 
                else if(driverBusNumber == null) {
                  return const Text(
                    'Please, start your shift on the profile page',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    )
                  );
                } 
                else {
                  // print("Number: ${driverBusNumber}");
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mainColor)
                    )
                  );
                }
              }
            )
          ]
        )
      ),
      const Expanded(
        child: GoogleMapPage()
      )
    ]);
  }

}
