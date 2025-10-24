import 'dart:math';

String generateRandomcostomerId() {
  DateTime now = DateTime.now();
  int randomId = Random().nextInt(9999999);
  String id = '${now.microsecondsSinceEpoch}_$randomId';
  return id;
}
