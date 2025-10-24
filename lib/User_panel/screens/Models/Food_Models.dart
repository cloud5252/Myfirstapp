import 'package:cloud_firestore/cloud_firestore.dart';

class Foodd {
  final String foodId;
  final String foodImage;
  final String foodName;
  final DateTime createAt;
  final DateTime updataAt;
  final String category;
  final String fullprice;
  final String description;
  final int foodquentity;
  final double totalprice;

  // Constructor for the Food class
  Foodd({
    required this.foodId,
    required this.foodImage,
    required this.foodName,
    required this.createAt,
    required this.updataAt,
    required this.category,
    required this.fullprice,
    required this.description,
    required this.foodquentity,
    required this.totalprice,
  });
  Map<String, dynamic> toMap() {
    return {
      'foodId': foodId,
      'foodImage': foodImage,
      'foodName': foodName,
      'createAt': createAt,
      'updateAt': updataAt,
      'category': category,
      'description': description,
      // 'totalprice': totalprice,
      // 'fullprice': fullprice,
      // 'foodquentity': foodquentity,
    };
  }

  factory Foodd.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Foodd(
      foodId: data['foodId'] ?? '',
      foodImage: data['foodImage'] ?? '',
      foodName: data['foodName'] ?? '',
      createAt: (data['createAt'] as Timestamp).toDate(),
      updataAt: (data['updateAt'] as Timestamp).toDate(),
      category: data['category'] ?? '',
      fullprice: data['Price'] ?? '',
      description: data['description'] ?? '',
      totalprice: data['totalprice'] ?? 0.0,
      foodquentity: data['foodquentity'] ?? 0,
    );
  }

  factory Foodd.fromMap(Map<String, dynamic> map) {
    return Foodd(
      foodId: map['foodId'] ?? '',
      foodImage: map['foodImage'] ?? '',
      foodName: map['foodName'] ?? '',
      createAt: (map['createAt'] as Timestamp).toDate(),
      updataAt: (map['updateAt'] as Timestamp).toDate(),
      category: map['category'] ?? '',
      fullprice: map['fullprice'] ?? '',
      description: map['description'] ?? '',
      totalprice: map['totalprice'] ?? 0.0,
      foodquentity: map['foodquentity'] ?? 0,
    );
  }
}
