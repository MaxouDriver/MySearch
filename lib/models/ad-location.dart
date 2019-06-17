class AdLocation {
  final String regionId;
  final String regionName;
  final String departmentId;
  final String departmentName;
  final String cityLabel;
  final String city;
  final double lat;
  final double lng;

  AdLocation({this.regionId, this.regionName, this.departmentId, this.departmentName, this.cityLabel, this.city, this.lat, this.lng});

  factory AdLocation.fromJson(Map<String, dynamic> json) {
    return AdLocation(
      regionId: json['regionId'],
      regionName: json['regionName'],
      departmentId: json['departmentId'],
      departmentName: json['departmentName'],
      cityLabel: json['cityLabel'],
      city: json['city'],
      lat: json['lat'],
      lng: json['lng']
    );
  }
}
