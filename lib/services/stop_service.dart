import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wait_for_me/models/bus_model.dart';
import 'package:wait_for_me/models/stops_model.dart';

class StopService {

  static StopService? _instance;

  static StopService? get instance {
    if(_instance == null) {
      _instance = StopService._();
      return _instance;
    }
    return _instance;
  }

  StopService._();

  initialize() {
    _instance = StopService._();
  }

  Future<List<Stop>> getStops(List<Bus> buses) async {
    var stopIdList = List.from(buses[0].stopsId);
    for(int i = 1; i < buses.length; i++) {
      stopIdList.removeWhere((stop) => !buses[i].stopsId.contains(stop));
    }

    print(stopIdList);

    final stopsCollection = FirebaseFirestore.instance.collection("stops");

    QuerySnapshot querySnapshot = await stopsCollection.get();

    List<Stop> stops = querySnapshot.docs
      .map((doc) => Stop.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

    var toRemove = [];
    for (var stop in stops) {
      if (!stopIdList.contains(stop.id)) {
        toRemove.add(stop);
      }
    }

    stops.removeWhere((element) => toRemove.contains(element));

    return stops;
  }

}