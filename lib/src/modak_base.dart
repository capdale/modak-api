import 'package:modak/modak.dart';
import 'package:modak/src/api/article/article.dart';
import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/collection/collection.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/api/social/social.dart';
import 'package:modak/src/api/user/user.dart';
import 'package:modak/src/types/uuid.dart';

class Modak {
  final Token token;
  final UUID uuid;
  late Endpoint endpoint;
  late AuthAPI auth;
  late CollectionAPI collection;
  late ArticleAPI article;
  late UserAPI user;
  late SocialAPI social;
  Modak({
    required this.token,
    required String refreshToken,
    required this.uuid,
    required this.endpoint,
  }) {
    auth = AuthAPI(token, refreshToken, endpoint);
    collection = CollectionAPI(auth, endpoint);
    article = ArticleAPI(auth, endpoint);
    user = UserAPI(auth, endpoint);
    social = SocialAPI(auth, endpoint);
  }
}
