import 'package:q_agency_task/_all.dart';
part 'genre_model.g.dart';

@HiveType(typeId: 4)
class GenreModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  GenreModel({required this.id, required this.name});

  GenreModel copyWith({
    int? id,
    String? name,
  }) =>
      GenreModel(id: id ?? this.id, name: name ?? this.name);

  factory GenreModel.fromJson(dynamic json) {
    return GenreModel(
      id: int.parse(json['id'].toString()),
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
