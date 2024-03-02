import 'package:json_annotation/json_annotation.dart';

part 'collection_dto.g.dart';

@JsonSerializable()
class GeoLocation {
  final double longtitude;
  final double latitude;
  final double altitude;
  @JsonKey(name: "acc")
  final double accuracy;
  GeoLocation(this.longtitude, this.latitude, this.altitude, this.accuracy);
  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}

@JsonSerializable()
class CollectionsUUID {
  final List<String> collections;
  CollectionsUUID(this.collections);
  factory CollectionsUUID.fromJson(Map<String, dynamic> json) =>
      _$CollectionsUUIDFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionsUUIDToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Collection {
  final int index;
  final GeoLocation geolocation;
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime? datetime;

  Collection(this.index, this.geolocation, this.datetime);
  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  static DateTime? _dateFromJson(String? timestamp) =>
      timestamp == null ? null : DateTime.parse(timestamp);
  static String? _dateToJson(DateTime? time) => time?.toIso8601String();
}
