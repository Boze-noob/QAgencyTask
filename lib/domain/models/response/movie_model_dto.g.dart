// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelDtoAdapter extends TypeAdapter<MovieModelDto> {
  @override
  final int typeId = 1;

  @override
  MovieModelDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModelDto(
      page: fields[0] as int,
      results: (fields[1] as List).cast<MovieModel>(),
      totalPages: fields[2] as int,
      totalResults: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModelDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.results)
      ..writeByte(2)
      ..write(obj.totalPages)
      ..writeByte(3)
      ..write(obj.totalResults);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
