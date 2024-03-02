// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['title'] as String,
      json['content'] as String,
      Article._dateFromJson(json['update_at'] as String?),
      (json['collections'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['images'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'update_at': Article._dateToJson(instance.updateAt),
      'collections': instance.collections,
      'images': instance.images,
    };

ArticleLinks _$ArticleLinksFromJson(Map<String, dynamic> json) => ArticleLinks(
      (json['links'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ArticleLinksToJson(ArticleLinks instance) =>
    <String, dynamic>{
      'links': instance.links,
    };

PostArticle _$PostArticleFromJson(Map<String, dynamic> json) => PostArticle(
      json['title'] as String,
      json['content'] as String,
      (json['collections'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostArticleToJson(PostArticle instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'collections': instance.collectionOrderInfo,
    };

OrderInfo _$OrderInfoFromJson(Map<String, dynamic> json) => OrderInfo(
      json['uuid'] as String,
      json['order'] as int,
    );

Map<String, dynamic> _$OrderInfoToJson(OrderInfo instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'order': instance.order,
    };
