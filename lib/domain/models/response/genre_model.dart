class GenreModel {
  int id;
  String name;

  GenreModel({required this.id, required this.name});

  GenreModel copyWith({
    int? id,
    String? name,
  }) =>
      GenreModel(id: id ?? this.id, name: name ?? this.name);

  factory GenreModel.fromMap(dynamic map) {
    return GenreModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
