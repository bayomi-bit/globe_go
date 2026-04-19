class TripsModel {
  final String? name;
  final String? image;
  final String? description;
  final int? price;
  final String? duration;
  final String? location;
  final double? lat;
  final double? lng;

  TripsModel({ this.name, this.image, this.description, this.price, this.duration,
      this.location, this.lat, this.lng});

  factory TripsModel.fromJson(Map<String, dynamic> json) {
   return TripsModel(
     name : json['name']??'',
     image : json['image']??'',
     description : json['description']??'',
     price : json['price']??'',
     duration : json['duration']??'',
     location : json['location']??'',
     lat : json['lat']??'',
     lng : json['lng']??'',

   );

  }


}