class AgencyTrips {
  String? id;
  String? agencyName;
  String? agencyLogo;

  String? tripTitle;
  String? location;

  dynamic? lat;
  dynamic? long;

  String? category;
  String? description;
  dynamic? price;

  dynamic? rating;
  dynamic? seatsTaken;
  dynamic? seatsMax;
  String? startDate;
  dynamic? durationHours;
  String? image;

  AgencyTrips({
    this.id,
    this.agencyName,
    this.agencyLogo,
    this.tripTitle,
    this.location,
    this.lat,
    this.long,
    this.category,
    this.description,
    this.price,
    this.rating,
    this.seatsTaken,
    this.seatsMax,
    this.startDate,
    this.durationHours,
    this.image,
  });

  factory AgencyTrips.fromJson(Map<String, dynamic> json) {
    return AgencyTrips(
      id: json['id'] ?? '',
      agencyName: json['agency_name'] ?? '',
      agencyLogo: json['agency_logo'] ?? '',
      tripTitle: json['trip_title'] ?? '',
      location: json['location'] ?? '',
      lat: json['lat'] ?? '',
      long: json['long'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      rating: json['rating'] ?? '',
      seatsTaken: json['seats_taken'] ?? '',
      seatsMax: json['seats_max'] ?? '',

      startDate: json['start_date'] ?? '',
      durationHours: json['duration_hours'] ?? '',
      image: json['image'] ?? '',

    );
  }
}
