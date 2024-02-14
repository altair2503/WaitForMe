import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/models/bus_model.dart';
import 'package:wait_for_me/services/location_service.dart';

class BusService {
  static BusService? _instance;
  String? _driverBusNumber;

  String? get driverBusNumber {
    if (_driverBusNumber == null) {
      getDriverBusNumber();
    }
    return _driverBusNumber;
  }

  static BusService? get instance {
    if (_instance == null) {
      _instance = BusService._();
      return _instance;
    }
    return _instance;
  }

  BusService._();

  initialize() {
    _instance = BusService._();
  }

  Future<bool> driverIsActive() async {
    final user = await AuthService.firebase().getCurrentUser();
    try {
      final buses = FirebaseFirestore.instance.collection('buses');
      QuerySnapshot querySnapshot = await buses.get();
      List<Map<String, dynamic>> dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < dataList[i]['drivers_id'].length; j++) {
          if (dataList[i]['drivers_id'][j]['id'] == user?.id) {
            return true;
          }
        }
      }
    } catch (e) {
      print('Error getDriverBusNumber: ${e.toString()}');
    }
    return false;
  }

  Future<void> assignBusNumber({required String number}) async {
    try {
      final user = await AuthService.firebase().getCurrentUser();
      if (user != null) {
        late final String busId;
        await FirebaseFirestore.instance
            .collection('buses')
            .where("number", isEqualTo: number)
            .get()
            .then((QuerySnapshot snapshot) {
          busId = snapshot.docs[0].id;
          print(busId);
        });
        await FirebaseFirestore.instance.collection('buses').doc(busId).update({
          "drivers_id": FieldValue.arrayUnion([
            {"id": user.id}
          ])
        });
      }
    } catch (e) {
      print('Error assignBusNumber: ${e.toString()}');
    }
  }

  Future<void> removeDriverFromBuses() async {
    final user = await AuthService.firebase().getCurrentUser();
    try {
      final buses = FirebaseFirestore.instance.collection('buses');
      QuerySnapshot querySnapshot = await buses.get();
      List<Map<String, dynamic>> dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < dataList[i]['drivers_id'].length; j++) {
          if (dataList[i]['drivers_id'][j]['id'] == user?.id) {
            await buses.doc(dataList[i]['id']).update({
              "drivers_id": FieldValue.arrayRemove([
                {
                  "id": dataList[i]['drivers_id'][j]['id'],
                }
              ])
            });
          }
        }
      }
    } catch (e) {
      print('Error removeDriverFromBuses : ${e.toString()}');
    }
  }

  Stream<Bus?> readDriverBusNumber() async* {
    final bus = await getDriverBusNumber();
    yield bus;
  }

  Future<Bus?> getDriverBusNumber() async {
    final user = await AuthService.firebase().getCurrentUser();
    try {
      final buses = FirebaseFirestore.instance.collection('buses');
      late final driverBusNumber;
      QuerySnapshot querySnapshot = await buses.get();
      List<Map<String, dynamic>> dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < dataList[i]['drivers_id'].length; j++) {
          if (dataList[i]['drivers_id'][j]['id'] == user?.id) {
            driverBusNumber = dataList[i]['number'];
            return Bus(number: driverBusNumber);
          }
        }
      }
    } catch (e) {
      print('Error getDriverBusNumber: ${e.toString()}');
    }
    return null;
  }

  static Stream<List<Bus>> getBuses() {
    return FirebaseFirestore.instance.collection("buses").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Bus.fromJson(doc.data())).toList());
  }

  static Future<bool> addUser(List<Bus> buses) async {
    try {
      final user = await AuthService.firebase().getCurrentUser();
      LatLng currentLocation = await LocationService.requestLocation();

      for (var bus in buses) {
        FirebaseFirestore.instance.collection("buses").doc(bus.id).update({
          "users_info": FieldValue.arrayUnion([
            {
              "id": user?.id,
              "latitude": currentLocation.latitude,
              "longitude": currentLocation.longitude
            }
          ])
        });
      }
      return true;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return false;
  }

  static Future<bool> removeUser() async {
    final user = await AuthService.firebase().getCurrentUser();
    try {
      final buses = FirebaseFirestore.instance.collection("buses");
      // Get the documents from the collection
      QuerySnapshot querySnapshot = await buses.get();

      // Extract data from documents
      List<Map<String, dynamic>> dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < dataList[i]['users_info'].length; j++) {
          if (dataList[i]['users_info'][j]['id'] == user?.id) {
            buses.doc(dataList[i]['id']).update({
              "users_info": FieldValue.arrayRemove([
                {
                  "id": dataList[i]['users_info'][j]['id'],
                  "latitude": dataList[i]['users_info'][j]['latitude'],
                  "longitude": dataList[i]['users_info'][j]['longitude']
                }
              ])
            });
          }
        }
      }
      return true;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return false;
  }
}