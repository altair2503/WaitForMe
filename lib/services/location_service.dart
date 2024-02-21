import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<LatLng> requestLocation() async {

    LocationPermission permission = await Geolocator.requestPermission();

    if(permission == LocationPermission.denied) {
      print("Location permission denied");
    }
    else if (permission == LocationPermission.deniedForever) {
      print("Location permission denied forever");
    } 
    else {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        return LatLng(position.latitude, position.longitude);
      } 
      catch (e) {
        print('Error: ${e.toString()}');
      }
    }

    return LatLng(0, 0);

  }
}