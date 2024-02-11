import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wait_for_me/auth/auth_service.dart';
import 'package:wait_for_me/auth/auth_user.dart';
import 'package:wait_for_me/services/bus_model.dart';

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
    if (user != null) {
      final busSnapshot = await FirebaseFirestore.instance
          .collection('buses')
          .doc(user.id)
          .get();
      if (busSnapshot.exists) {
        return true;
      }
    }
    return false;
  }

  Future<void> assignBusNumber({required int number}) async {
    final user = await AuthService.firebase().getCurrentUser();
    if (user != null) {
      FirebaseFirestore.instance
          .collection('buses')
          .doc(user.id)
          .set({'number': number});
    }
  }

  Future<void> driverEndShift() async {
    final user = await AuthService.firebase().getCurrentUser();
    if (user != null) {
      FirebaseFirestore.instance.collection('buses').doc(user.id).delete();
    }
  }

  Future<Bus?> getDriverBusNumber() async {
    final user = await AuthService.firebase().getCurrentUser();
    if (user != null) {
      final DocumentSnapshot busDoc = await FirebaseFirestore.instance
          .collection('buses')
          .doc(user.id)
          .get();
      if (busDoc.exists && busDoc.data() is Map<String, dynamic>) {
        final busData = busDoc.data() as Map<String, dynamic>;
        final bus = Bus.fromFirebase(number: busData['number'] as int);
        // _user = user;
        return bus;
      }
    }
    return null;
  }
}
