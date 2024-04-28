// ignore_for_file: unnecessary_this

class Bus {

  String id;
  String number;
  double numberInt;

  List<dynamic> driversId;
  List<dynamic> usersInfo;
  List<dynamic> stopsId;


  Bus({
    this.id = "",
    this.number = "",
    this.numberInt = 0.0,
    this.driversId = const [],
    this.usersInfo = const [],
    this.stopsId = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'number_int': numberInt.toDouble(),
    'drivers_id': driversId,
    'users_info': usersInfo,
    'stops_id': stopsId,
  };

  static Bus fromJson(Map<String, dynamic> json) => Bus(
    id: json['id'],
    number: json['number'],
    numberInt: double.parse(json['number_int'].toString()),
    driversId: json['drivers_id'],
    usersInfo: json['users_info'],
    stopsId: json['stops_id'],
  );

  @override
  bool operator==(Object other) => 
    other is Bus && id == other.id && number == other.number;

  @override
  int get hashCode => Object.hash(id, number);

  @override
  String toString() {
    return this.number;
  }

}