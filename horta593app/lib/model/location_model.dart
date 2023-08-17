class LocationUser {
  String longitude;
  String latitude;
  String address;

  LocationUser(
      {required this.latitude, required this.longitude, required this.address});

  factory LocationUser.fromJson(Map<String, dynamic> json) {
    print("json['latitude']");
    print(json);
    final locationuser;
    if (json['latitude'] == null) {
      locationuser = LocationUser(latitude: "", longitude: '', address: '');
    } else {
      locationuser = LocationUser(
          latitude: json['latitude'].toString(),
          longitude: json['longitude'].toString(),
          address: json['address']);
    }
    return locationuser;
  }

  // factory LocationUser.fromJsonChange(Map<String, dynamic> json) {
  //   final locationuser;
  //   locationuser = LocationUser(
  //       latitude: json['latitude'].toString(),
  //       longitude: json['longitude'].toString(),
  //       address: json['address']);
  //   return locationuser;
  // }

  bool exists() {
    if (this.latitude.isEmpty && this.longitude.isEmpty) {
      return false;
    }
    return true;
  }
}
