class City {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  City(
      {required this.name,
      required this.country,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static City fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'],
      country: map['country'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
