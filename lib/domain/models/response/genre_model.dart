import 'package:q_agency_task/_all.dart';

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

  static Map<String, dynamic> toMap(GenreModel model) => {
        'id': model.id,
        'name': model.name,
      };

  static String serialize(GenreModel model) => json.encode(GenreModel.toMap(model));
}
