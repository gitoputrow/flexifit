class CityModel {
  String? id;
  String? name;

  CityModel({
    this.id,
    this.name,
  });

  CityModel copyWith({
    String? id,
    String? name,
  }) =>
      CityModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
