import 'package:json_annotation/json_annotation.dart';
import 'package:modak/src/types/uuid.dart';

part 'social_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class Followers {
  final List<UUID> followers;
  Followers(this.followers);
  factory Followers.fromJson(Map<String, dynamic> json) =>
      _$FollowersFromJson(json);
  Map<String, dynamic> toJson() => _$FollowersToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Followings {
  final List<UUID> followings;
  Followings(this.followings);
  factory Followings.fromJson(Map<String, dynamic> json) =>
      _$FollowingsFromJson(json);
  Map<String, dynamic> toJson() => _$FollowingsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FollowRequests {
  final List<UUID> requests;
  FollowRequests(this.requests);
  factory FollowRequests.fromJson(Map<String, dynamic> json) =>
      _$FollowRequestsFromJson(json);
  Map<String, dynamic> toJson() => _$FollowRequestsToJson(this);
}

@JsonSerializable()
class Relation {
  @JsonKey(name: "is_following")
  final bool isFollowing;
  @JsonKey(name: "is_follower")
  final bool isFollower;
  Relation(this.isFollowing, this.isFollower);
  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);
  Map<String, dynamic> toJson() => _$RelationToJson(this);
}
