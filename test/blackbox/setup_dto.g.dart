// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestConfig _$TestConfigFromJson(Map<String, dynamic> json) => TestConfig(
      json['host'] as String,
      (json['port'] as num).toInt(),
      json['access_token'] as String,
      json['refresh_token'] as String,
      UUID.fromJson(json['uuid'] as String),
      SpecificTestConfig.fromJson(json['tests'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestConfigToJson(TestConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'uuid': instance.uuid,
      'tests': instance.test,
    };

SpecificTestConfig _$SpecificTestConfigFromJson(Map<String, dynamic> json) =>
    SpecificTestConfig(
      CollectionTestConfig.fromJson(json['collection'] as Map<String, dynamic>),
      AuthTestConfig.fromJson(json['auth'] as Map<String, dynamic>),
      ArticleTestConfig.fromJson(json['article'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpecificTestConfigToJson(SpecificTestConfig instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'auth': instance.auth,
      'article': instance.article,
    };

AuthTestConfig _$AuthTestConfigFromJson(Map<String, dynamic> json) =>
    AuthTestConfig(
      (json['invalid_token'] as List<dynamic>).map((e) => e as String).toList(),
      (json['no_uuid_token'] as List<dynamic>).map((e) => e as String).toList(),
      (json['expired_token'] as List<dynamic>).map((e) => e as String).toList(),
      (json['not_expired_token'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthTestConfigToJson(AuthTestConfig instance) =>
    <String, dynamic>{
      'invalid_token': instance.invalidTokens,
      'no_uuid_token': instance.noUUIDTokens,
      'expired_token': instance.expiredTokens,
      'not_expired_token': instance.notExpiredToken,
    };

CollectionTestConfig _$CollectionTestConfigFromJson(
        Map<String, dynamic> json) =>
    CollectionTestConfig(
      json['collectionUUID'] as String,
    );

Map<String, dynamic> _$CollectionTestConfigToJson(
        CollectionTestConfig instance) =>
    <String, dynamic>{
      'collectionUUID': instance.collectionUUID,
    };

ArticleTestConfig _$ArticleTestConfigFromJson(Map<String, dynamic> json) =>
    ArticleTestConfig(
      json['collectionUUID'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$ArticleTestConfigToJson(ArticleTestConfig instance) =>
    <String, dynamic>{
      'collectionUUID': instance.collectionUUID,
      'link': instance.link,
    };
