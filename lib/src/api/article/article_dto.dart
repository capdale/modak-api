import 'package:json_annotation/json_annotation.dart';
import 'package:modak/modak.dart';

part 'article_dto.g.dart';

@JsonSerializable()
class Article {
  final String title;
  final String content;
  @JsonKey(name: "update_at", fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime? updateAt;
  @JsonKey(name: "collections", includeToJson: false)
  final CollectionsUUID collectionsUUID;

  Article(this.title, this.content, this.updateAt, this.collectionsUUID);
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  static DateTime? _dateFromJson(String? timestamp) =>
      timestamp == null ? null : DateTime.parse(timestamp);
  static String? _dateToJson(DateTime? time) => time?.toIso8601String();
}

@JsonSerializable()
class ArticleLinks {
  final List<String> links;
  ArticleLinks(this.links);
  factory ArticleLinks.fromJson(Map<String, dynamic> json) =>
      _$ArticleLinksFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleLinksToJson(this);
}

@JsonSerializable()
class PostArticle {
  final String title;
  final String content;
  @JsonKey(name: "collections")
  final List<CollectionOrderInfo> collectionOrderInfo;
  PostArticle(this.title, this.content, this.collectionOrderInfo);
  factory PostArticle.fromJson(Map<String, dynamic> json) =>
      _$PostArticleFromJson(json);
  Map<String, dynamic> toJson() => _$PostArticleToJson(this);
}

@JsonSerializable()
class CollectionOrderInfo {
  final String uuid;
  final int order;
  CollectionOrderInfo(this.uuid, this.order);
  factory CollectionOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$CollectionOrderInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionOrderInfoToJson(this);
}
