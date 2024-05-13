// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) => GeoLocation(
      (json['longtitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
      (json['altitude'] as num).toDouble(),
      (json['acc'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoLocationToJson(GeoLocation instance) =>
    <String, dynamic>{
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
      'altitude': instance.altitude,
      'acc': instance.accuracy,
    };

CollectionsUUID _$CollectionsUUIDFromJson(Map<String, dynamic> json) =>
    CollectionsUUID(
      (json['collections'] as List<dynamic>)
          .map((e) => UUID.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$CollectionsUUIDToJson(CollectionsUUID instance) =>
    <String, dynamic>{
      'collections': instance.collections,
    };

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      (json['index'] as num).toInt(),
      GeoLocation.fromJson(json['geolocation'] as Map<String, dynamic>),
      Collection._dateFromJson(json['datetime'] as String?),
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) {
  final val = <String, dynamic>{
    'index': instance.index,
    'geolocation': instance.geolocation.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('datetime', Collection._dateToJson(instance.datetime));
  return val;
}
