import 'package:modak/src/api/errors.dart';

/// validate [offset] and [limit] is in condition
/// [offset] >=0 and 0 < [limit] <= maxlimit
/// if not validate throw [InvalidInputError] with description
validateRange(int offset, int limit, int maxLimit) {
  if (offset < 0) {
    throw InvalidInputError(
        "offset cannot be $offset, must greater or equal to 0");
  }
  if (limit < 1) {
    throw InvalidInputError(
        "limit cannot be $limit, must greater then 0 and less then $maxLimit");
  }
  if (limit > maxLimit) {
    throw InvalidInputError(
        "limit cannot be $limit, must greater then 0 and less then $maxLimit");
  }
}
