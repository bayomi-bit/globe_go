class HotelModel {
  final String hotelName;
  final String? image;
  final String description;
  final double? lat;
  final double? lng;
  final double? rating;
  final  int? id;
  final  int? price;


  HotelModel({
    required this.hotelName,
    this.image,
    required this.description,
    this.lat,
    this.lng,
    this.rating,
    this.id,
    this.price,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      hotelName: json['name'] ?? '',
      image: json['image'],
      description: json['description'] ?? '',
      lat: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
      lng: json['lng'] != null ? (json['lng'] as num).toDouble() : null,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
      price: json['price'] != null ? (json['price'] as num).toInt() : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': hotelName,
      'image': image,
      'description': description,
      'lat': lat,
      'lng': lng,
      'rating': rating,
      'id': id,
      'price': price,
    };
  }
}