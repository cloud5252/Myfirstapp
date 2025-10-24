class RatingModel {
  final String customerName;
  final String customerId;
  final String customerPhone;
  final String customerDeviceToken;
  final String feedback;
  final String rating;
  final dynamic createdAt;

  RatingModel({
    required this.customerName,
    required this.customerId,
    required this.customerPhone,
    required this.customerDeviceToken,
    required this.feedback,
    required this.rating,
    required this.createdAt,
  });

  // Convert to JSON (for Firestore or API)
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerId': customerId,
      'customerPhone': customerPhone,
      'customerDeviceToken': customerDeviceToken,
      'feedback': feedback,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
