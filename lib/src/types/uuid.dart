import 'package:uuid/parsing.dart';

class UUID {
  final List<int> uuid;
  UUID(this.uuid);
  @override
  String toString() {
    return UuidParsing.unparse(uuid);
  }

  UUID.fromJson(String json) : uuid = UuidParsing.parse(json);
  String toJson() => toString();

  static UUID parse(String uuid) {
    return UUID(UuidParsing.parse(uuid));
  }
}
