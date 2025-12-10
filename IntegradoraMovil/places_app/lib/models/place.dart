class Place {
  final String id;
  final String name;
  final String description;
  final double lat;
  final double lng;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.lat,
    required this.lng,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json["id"].toString(),
      name: json["name"],
      description: json["description"],
      lat: (json["lat"] as num).toDouble(),
      lng: (json["lng"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "description": description, "lat": lat, "lng": lng};
  }
}
