import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  LatLng bus = LatLng(43.2560, 76.9614);
  LatLng destination = LatLng(43.2554, 76.9520);
  GoogleMapController? mapController;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  double remainingDistance = 0.0;

  void addCustomMarkers() {
    ImageConfiguration configuration = ImageConfiguration(size: Size(0, 0), devicePixelRatio: 5);

    BitmapDescriptor.fromAssetImage(configuration, "assets/icons/buslocation.png").then((value) =>  {
      setState(() {
        markerIcon = value;
      })
    });
  }

  void updateCurrentLocation(Position position) {
    setState(() {
      destination = LatLng(position.latitude, position.longitude);
    });
  }

  void updateBusLocation(Position position) {
    setState(() {
      bus = LatLng(position.latitude, position.longitude);
    });

    mapController?.animateCamera(CameraUpdate.newLatLng(bus));

    calculateRemainingDistance();
  }

  void calculateRemainingDistance(){
    double distance = Geolocator.distanceBetween(
      bus.latitude,
      bus.latitude, 
      bus.longitude, 
      bus.longitude
    );

    double distanceInKm = distance / 1000;

    setState(() {
      remainingDistance = distanceInKm;
    });

    print("Remaining Distance: ${distanceInKm} kilometers");
  }

  @override
  void initState(){
    super.initState();
    addCustomMarkers();
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10),
    ).listen((Position position) {
      updateBusLocation(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: bus,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('destination'),
                position: destination,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                  title: 'Destination',
                  snippet: 'Lat: ${destination.latitude}, Lng: ${destination.longitude}'
                )
              ),
              Marker(
                markerId: const MarkerId('bus'),
                position: bus,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                  title: 'Bus',
                  snippet: 'Lat: ${bus.latitude}, Lng: ${bus.longitude}'
                )
              ),
            },
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(0.8),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "Remaining Distance: ${remainingDistance.toStringAsFixed(2)} kilometers",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}