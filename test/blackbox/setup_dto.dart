import 'package:json_annotation/json_annotation.dart';
import 'package:modak/modak.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/types/uuid.dart';

part 'setup_dto.g.dart';

@JsonSerializable()
class TestConfig {
  final String host;
  final int port;
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @JsonKey(name: "uuid")
  final UUID uuid;
  @JsonKey(name: "tests")
  final SpecificTestConfig test;
  TestConfig(this.host, this.port, this.accessToken, this.refreshToken,
      this.uuid, this.test);
  factory TestConfig.fromJson(Map<String, dynamic> json) =>
      _$TestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$TestConfigToJson(this);

  Modak getModak() => Modak(
      token: Token.parseFromString(accessToken),
      refreshToken: refreshToken,
      uuid: uuid,
      endpoint: Endpoint(host: host, port: port));
}

@JsonSerializable()
class SpecificTestConfig {
  final CollectionTestConfig collection;
  final AuthTestConfig auth;
  final ArticleTestConfig article;
  SpecificTestConfig(this.collection, this.auth, this.article);
  factory SpecificTestConfig.fromJson(Map<String, dynamic> json) =>
      _$SpecificTestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificTestConfigToJson(this);
}

@JsonSerializable()
class AuthTestConfig {
  @JsonKey(name: "invalid_token")
  List<String> invalidTokens;
  @JsonKey(name: "no_uuid_token")
  List<String> noUUIDTokens;
  @JsonKey(name: "expired_token")
  List<String> expiredTokens;
  @JsonKey(name: "not_expired_token")
  List<String> notExpiredToken;
  AuthTestConfig(this.invalidTokens, this.noUUIDTokens, this.expiredTokens,
      this.notExpiredToken);
  factory AuthTestConfig.fromJson(Map<String, dynamic> json) =>
      _$AuthTestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AuthTestConfigToJson(this);
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

@JsonSerializable()
class ArticleTestConfig {
  final String collectionUUID;
  final String link;
  ArticleTestConfig(this.collectionUUID, this.link);
  factory ArticleTestConfig.fromJson(Map<String, dynamic> json) =>
      _$ArticleTestConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleTestConfigToJson(this);
}
