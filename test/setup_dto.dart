import 'package:json_annotation/json_annotation.dart';
import 'package:modak/modak.dart';
import 'package:modak/src/api/endpoint.dart';

part 'setup_dto.g.dart';

@JsonSerializable()
class TestConfig {
  final String host;
  final int port;
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @JsonKey(name: "tests")
  final SpecificTestConfig test;
  TestConfig(
      this.host, this.port, this.accessToken, this.refreshToken, this.test);
  factory TestConfig.fromJson(Map<String, dynamic> json) =>
      _$TestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$TestConfigToJson(this);

  Modak getModak() => Modak(
      token: Token.parseFromString(accessToken),
      refreshToken: refreshToken,
      endpoint: Endpoint(host: host, port: port));
}

@JsonSerializable()
class SpecificTestConfig {
  final CollectionTestConfig collection;
  SpecificTestConfig(this.collection);
  factory SpecificTestConfig.fromJson(Map<String, dynamic> json) =>
      _$SpecificTestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificTestConfigToJson(this);
}

@JsonSerializable()
class CollectionTestConfig {
  @JsonKey(name: "collectionUUID")
  final String collectionUUID;
  CollectionTestConfig(this.collectionUUID);
  factory CollectionTestConfig.fromJson(Map<String, dynamic> json) =>
      _$CollectionTestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionTestConfigToJson(this);
}