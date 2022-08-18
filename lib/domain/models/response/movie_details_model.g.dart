// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailsModelAdapter extends TypeAdapter<MovieDetailsModel> {
  @override
  final int typeId = 3;

  @override
  MovieDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailsModel(
      id: fields[0] as int,
      adult: fields[1] as bool?,
      backdropPath: fields[2] as String?,
      posterPath: fields[3] as String,
      originalTitle: fields[4] as String,
      originalLanguage: fields[5] as String?,
      overview: fields[6] as String,
      voteAverage: fields[7] as double,
      popularity: fields[8] as double?,
      releaseDate: fields[9] as String?,
      title: fields[10] as String,
      video: fields[11] as bool?,
      voteCount: fields[12] as int?,
      genreList: (fields[13] as List).cast<GenreModel>(),
      genres: (fields[14] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailsModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.adult)
      ..writeByte(2)
      ..write(obj.backdropPath)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.originalTitle)
      ..writeByte(5)
      ..write(obj.originalLanguage)
      ..writeByte(6)
      ..write(obj.overview)
      ..writeByte(7)
      ..write(obj.voteAverage)
      ..writeByte(8)
      ..write(obj.popularity)
      ..writeByte(9)
      ..write(obj.releaseDate)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.video)
      ..writeByte(12)
      ..write(obj.voteCount)
      ..writeByte(13)
      ..write(obj.genreList)
      ..writeByte(14)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
