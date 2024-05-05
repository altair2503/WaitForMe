import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wait_for_me/models/bus_model.dart';
import 'package:wait_for_me/models/stops_model.dart';

class AnalyticsEngine {

  static final _instance = FirebaseAnalytics.instance;

  static void selectedBusesAndStation(Position currentPosition, List<Bus> buses, Stop stop, DateTime time) async{
    for(var bus in buses){
      _instance.logEvent(name: "selected_bus_and_stop",  parameters: {"current_position": "${currentPosition.latitude.toString()}, ${currentPosition.longitude.toString()}", "bus": bus.number, "stop": stop.toString(), "time": time.toString()});
    }
  }

  static void selectedStation(Stop stop, DateTime time) async {
    return _instance.logEvent(name: "selected_bus_stop",  parameters: {"bus_stop": stop.toString(), "time": time.toString()});
  }

  static void getOffStation(Stop stop, DateTime time) async {
    return _instance.logEvent(name: "get_off_station",  parameters: {"bus_stop": stop.toString(), "time": time.toString()});
  }

  static void onBusActivity(Position currentPosition, List<Bus> buses, Stop stop, DateTime time) async {
    for(var bus in buses){
      _instance.logEvent(name: "on_bus_activity",  parameters: {"current_position": "${currentPosition.latitude.toString()}, ${currentPosition.longitude.toString()}", "bus": bus.number, "bus_stop": stop.toString(), "time": time.toString()});
    }
  }  

  static void cancelActivity(Position currentPosition, List<Bus> buses, Stop stop, DateTime time) async {
    for(var bus in buses){
       _instance.logEvent(name: "cancel_pressed",  parameters: {"current_position": "${currentPosition.latitude.toString()}, ${currentPosition.longitude.toString()}", "bus":bus.toString(), "bus_stop": stop.toString(), "time": time.toString()}); 
    }
  } 

}
