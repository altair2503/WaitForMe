class Bus {
  String id;
  String number;
  List<dynamic> driversId;
  List<dynamic> usersInfo;


  Bus({
    this.id = "",
    this.number = "",
    this.driversId = const [],
    this.usersInfo = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'drivers_id': driversId,
    'users_info': usersInfo,
  };

  static Bus fromJson(Map<String, dynamic> json) => Bus(
    id: json['id'],
    number: json['number'],
    driversId: json['drivers_id'],
    usersInfo: json['users_info'],
  );

  @override
  bool operator==(Object other) =>
      other is Bus && id == other.id && number == other.number;

  @override
    int get hashCode => Object.hash(id, number);
}