class Stop {
  int id;
  String name;
  double latitude;
  double longitude;

  Stop({
    this.id = 0,
    this.name = "",
    this.latitude = 0.0,
    this.longitude = 0.0 
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  };

  static Stop fromJson(Map<String, dynamic> json) => Stop(
    id: int.parse(json['id'].toString()),
    name: json['name'],
    latitude: double.parse(json['latitude'].toString()),
    longitude: double.parse(json['longitude'].toString()),
  );

  @override
  bool operator==(Object other) => 
    other is Stop && id == other.id && latitude == other.latitude && longitude == other.longitude;

  @override
  int get hashCode => Object.hash(id, latitude, longitude);

  @override
  String toString() {
    return "$name [$latitude, $longitude]";
  }

}