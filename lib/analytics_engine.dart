import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wait_for_me/models/stops_model.dart';

class AnalyticsEngine {

  static final _instance = FirebaseAnalytics.instance;

  static void selectedStation(Stop stop, DateTime time) async {
    return _instance.logEvent(name: "Selected bus stop",  parameters: {"Bus stop": stop, "Time": time});
  }

  static void getOffStation(Stop stop, DateTime time) async {
    return _instance.logEvent(name: "Get off station",  parameters: {"Bus stop": stop, "Time": time});
  }

  static void onBusActivity(Position currentPosition, Stop stop, DateTime time) async {
    return _instance.logEvent(name: "On bus activity",  parameters: {"Current position": "${currentPosition.latitude}, ${currentPosition.longitude}", "Bus stop": stop, "Time": time});
  }  

  static void cancelActivity(Position currentPosition, Stop stop, DateTime time) async {
    return _instance.logEvent(name: "Cancel pressed",  parameters: {"Current position": "${currentPosition.latitude}, ${currentPosition.longitude}", "Bus stop": stop, "Time": time});
  } 

}
