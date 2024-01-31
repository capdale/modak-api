import 'package:modak/modak.dart';
import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/collection/collection.dart';
import 'package:modak/src/api/endpoint.dart';

class Modak {
  late Endpoint endpoint;
  late AuthAPI auth;
  late CollectionAPI collection;
  Modak({
    required Token token,
    required String refreshToken,
    required this.endpoint,
  }) {
    auth = AuthAPI(token, refreshToken, endpoint);
    collection = CollectionAPI(auth, endpoint);
  }
}
