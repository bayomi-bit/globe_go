class PlaceModel {
  final String name;
  final String? image;
  final String description;
  final double? lat;
  final double? lng;

  PlaceModel({
    required this.name,
    this.image,
    required this.description,
    this.lat,
    this.lng,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'] ?? '',
      image: json['image'],
      description: json['description'] ?? '',
      lat: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
      lng: json['lng'] != null ? (json['lng'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'lat': lat,
      'lng': lng,
    };
  }
}