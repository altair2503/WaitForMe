import 'package:flutter_tts/flutter_tts.dart';
import 'package:location/location.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Location location = Location();
  GoogleMapController? mapController;
  LatLng bus = const LatLng(43.254916, 76.943788);
  BitmapDescriptor markerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  List<Marker> markerList = [];
  double remainingDistance = 0.0;
  var destinations = [];
  var usersInfo = [];
  final FlutterTts flutterTts = FlutterTts();
  var speachState = {500: false, 100: false, 0: false};

  Future<void> speak(text) async {
    try {
      await flutterTts.setLanguage("en-US"); // Set desired language
      await flutterTts.setVolume(0.5);
      await flutterTts.setSpeechRate(0.7);
      await flutterTts.speak(text);
    } catch (e) {
      print(e);
    }
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/map_style.json")
        .then((value) => setMapStyle(value, mapController));
  }

  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> updateBusLocation(LatLng busPos) async {
    final Uint8List busMarkerIcon =
        await getBytesFromAsset('assets/icons/busmark.png', 180);
    markerList.add(
      Marker(
        markerId: const MarkerId('bus'),
        position: busPos,
        icon: BitmapDescriptor.fromBytes(busMarkerIcon),
        infoWindow: InfoWindow(
          title: 'driver',
          snippet: 'Lat: ${bus.latitude}, Lng: ${bus.longitude}',
        ),
      ),
    );

    mapController?.animateCamera(CameraUpdate.newLatLng(busPos));
    usersDistance(busPos);
  }

  void usersDistance(busPos) {
    print("Hello then distance");
    List<double> usersDistanceList = [];
    for (var user in usersInfo) {
      var distance = calculateDistance(
          busPos, LatLng(user['latitude'], user['longitude']));
      print("distance $distance");
      usersDistanceList.add(distance);
    }
    setState(() {
      remainingDistance =
          usersDistanceList.reduce((curr, next) => curr < next ? curr : next);
    });

    // if (speachState[500] == false && remainingDistance > 100 && remainingDistance < 500) {
    //   speak(
    //       "A person with disabilities is waiting for you less than 500 meters away");
    //   speachState[500] = true;
    //   speachState[100] = false;
    // } else if (speachState[100] == false && remainingDistance > 10 && remainingDistance < 100) {
    //   speak(
    //       "A person with disabilities is waiting for you less than 100 meters away");
    //   speachState[100] = true;
    //   speachState[10] = false;
    // } else if (speachState[10] == false && remainingDistance < 10 && speachState[10] == false) {
    //   speak(
    //       "A person with disabilities is waiting for you less than 10 meters away");
    //   speachState[10] = true;
    //   speachState[500] = false;
    // }
  }

  double calculateDistance(busPos, userPos) {
    double distance = Geolocator.distanceBetween(
        busPos.latitude, busPos.longitude, userPos.latitude, userPos.longitude);
    return distance;
  }

  Future<void> updateMarkersFromFirestore(
      QuerySnapshot<Map<String, dynamic>> snapshot) async {
    var userData = snapshot.docs[0].data()['users_info'];
    List<Marker> newMarkerList = [];

    setState(() {
      usersInfo = userData;
    });

    final Uint8List busMarkerIcon =
        await getBytesFromAsset('assets/icons/busmark.png', 180);
    final Uint8List pwdMarkerIcon =
        await getBytesFromAsset('assets/icons/pwdmark.png', 150);

    newMarkerList.add(
      Marker(
        markerId: const MarkerId('bus'),
        position: bus,
        icon: BitmapDescriptor.fromBytes(busMarkerIcon),
        infoWindow: InfoWindow(
          title: 'driver',
          snippet: 'Lat: ${bus.latitude}, Lng: ${bus.longitude}',
        ),
      ),
    );

    for (var user in userData) {
      newMarkerList.add(
        Marker(
          markerId: MarkerId(user['id']),
          position: LatLng(user['latitude'], user['longitude']),
          icon: BitmapDescriptor.fromBytes(pwdMarkerIcon),
          infoWindow: InfoWindow(
            title: 'user',
            snippet: 'Lat: ${user["latitude"]}, Lng: ${user["longitude"]}',
          ),
        ),
      );
    }

    setState(() {
      markerList = newMarkerList;
    });
  }

  Future<void> subscribeToFirestore() async {
    final user = await AuthService.firebase().getCurrentUser();
    if (user != null) {
      FirebaseFirestore.instance
          .collection('buses')
          .where('drivers_id',
              arrayContains: user.id) // Change to your collection name
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
        updateMarkersFromFirestore(snapshot);
      });
    }
  }

  void trackBusLocatoin() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      print(
          "Location changed: ${currentLocation.latitude}, ${currentLocation.longitude}");

      LatLng newLocation =
          LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);

      setState(() {
        bus = newLocation;
      });

      updateBusLocation(newLocation);
    });
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData locationData = await location.getLocation();
      print(
          "Current location: ${locationData.latitude}, ${locationData.longitude}");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    trackBusLocatoin();
    subscribeToFirestore();
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
                changeMapMode(controller);
              },
              initialCameraPosition: CameraPosition(
                target: bus,
                zoom: 15.0,
              ),
              myLocationEnabled: false,
              padding: const EdgeInsets.symmetric(vertical: 35),
              markers: Set<Marker>.from(markerList)),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 250, 250),
                border: Border(
                    top: BorderSide(
                        color: Colors.black.withOpacity(.15), width: .4)),
              ),
              child: Text(
                "Remaining Distance: ${remainingDistance > 1000 ? (remainingDistance / 1000).toStringAsFixed(1) + 'km' : remainingDistance.toStringAsFixed(0) + 'm'}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
