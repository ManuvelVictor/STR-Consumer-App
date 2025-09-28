class LocationModel {
  final String address;
  final String label;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.address,
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'],
      label: json['label'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}