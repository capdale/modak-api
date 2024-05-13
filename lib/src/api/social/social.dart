import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/api/request.dart';
import 'package:modak/src/api/social/social_dto.dart';
import 'package:modak/src/api/validator.dart';

class SocialAPI {
  AuthAPI auth;
  Endpoint endpoint;
  SocialAPI(this.auth, this.endpoint);

  Future<Followers> getFollowers(String target,
      {int offset = 0, int limit = 8}) async {
    validateRange(offset, limit, 64);
    final apires = await auth.get(
        "${endpoint.baseurl}/social/follower/$target?offset=$offset&limit=$limit",
        responseJsonWrapper(Followers.fromJson));
    return apires.data;
  }

  Future<Followings> getFollowings(String target,
      {int offset = 0, int limit = 8}) async {
    validateRange(offset, limit, 64);
    final apires = await auth.get(
        "${endpoint.baseurl}/social/following/$target?offset=$offset&limit=$limit",
        responseJsonWrapper(Followings.fromJson));
    return apires.data;
  }

  Future<void> requestFollow(String target) async {
    await auth.post("${endpoint.baseurl}/social/follow/$target", (res) => null);
  }

  Future<FollowRequests> getFollowRequests(
      {int offset = 0, int limit = 16}) async {
    validateRange(offset, limit, 64);
    final resapi = await auth.get(
        "${endpoint.baseurl}/social/requests?offset=$offset&limit=$limit",
        responseJsonWrapper(FollowRequests.fromJson));
    return resapi.data;
  }

  Future<void> acceptFollowRequest(String target) async {
    await auth.post(
        "${endpoint.baseurl}/social/follow/accept/$target", (res) => null);
  }

  Future<void> rejectFollowRequest(String target) async {
    await auth.post(
        "${endpoint.baseurl}/social/follow/reject/$target", (res) => null);
  }

  Future<bool> isFollowing(String target) async {
    final apires = await auth.get(
        "${endpoint.baseurl}/social/is-following/$target",
        (res) => res.body as bool);
    return apires.data;
  }

  Future<bool> isFollower(String target) async {
    final apires = await auth.get(
        "${endpoint.baseurl}/social/is-follower/$target",
        (res) => res.body as bool);
    return apires.data;
  }

  Future<Relation> getRelation(String target) async {
    final apires = await auth.get("${endpoint.baseurl}/social/relation/$target",
        responseJsonWrapper(Relation.fromJson));
    return apires.data;
  }

  Future<void> removeFollower(String target) async {
    await auth.delete("${endpoint.baseurl}/social/follower/$target");
  }

  Future<void> removeFollowing(String target) async {
    await auth.delete("${endpoint.baseurl}/social/following/$target");
  }
}
