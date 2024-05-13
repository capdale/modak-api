import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/endpoint.dart';

enum UserVisibility { public, private }

extension UserVisibilityExtension on UserVisibility {
  String get toText {
    switch (this) {
      case UserVisibility.public:
        return "public";
      case UserVisibility.private:
        return "private";
      default:
        return "private";
    }
  }
}

class UserAPI {
  AuthAPI auth;
  Endpoint endpoint;
  UserAPI(this.auth, this.endpoint);

  Future<void> setVisibiltyPublic() async {
    await setVisibilty(UserVisibility.public);
  }

  Future<void> setVisibiltyPrivate() async {
    await setVisibilty(UserVisibility.private);
  }

  Future<void> setVisibilty(UserVisibility visibility) async {
    await auth.post("${endpoint.baseurl}/user/visibility/${visibility.toText}",
        (res) => null);
  }
}
