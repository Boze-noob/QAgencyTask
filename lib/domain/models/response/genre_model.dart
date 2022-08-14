class GenreModel {
  int id;
  String name;

  GenreModel({required this.id, required this.name});

  GenreModel copyWith({
    int? id,
    String? name,
  }) =>
      GenreModel(id: id ?? this.id, name: name ?? this.name);

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
