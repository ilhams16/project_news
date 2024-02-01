// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_news.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteNewsAdapter extends TypeAdapter<FavoriteNews> {
  @override
  final int typeId = 0;

  @override
  FavoriteNews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteNews(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String?,
      fields[5] as String,
      fields[4] as String?,
      fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteNews obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imgUrl)
      ..writeByte(4)
      ..write(obj.publish)
      ..writeByte(5)
      ..write(obj.media)
      ..writeByte(6)
      ..write(obj.fav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteNewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
