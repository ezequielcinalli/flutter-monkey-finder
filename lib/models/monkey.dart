class Monkey {
  Monkey(
    this.name,
    this.location,
    this.details,
    this.image,
    this.population,
    this.latitude,
    this.longitude,
  );

  String name;
  String location;
  String details;
  String image;
  int population;
  double latitude;
  double longitude;

  factory Monkey.fromJson(Map<String, dynamic> json) => Monkey(
        json['Name'] as String,
        json['Location'] as String,
        json['Details'] as String,
        json['Image'] as String,
        json['Population'] as int,
        json['Latitude'] as double,
        json['Longitude'] as double,
      );
}
