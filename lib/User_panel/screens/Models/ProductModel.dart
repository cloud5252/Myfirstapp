class ProductModel {
  final String productId;
  final String categoryId;
  final String productName;
  // final double salePrice;
  final double fullPrice;
  final List<String> productImages; // final String deliveryTime;
  // final bool isSale;
  final String productDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int productQuantity;
  final double TotalPrice;

  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.productName,
    // required this.salePrice,
    required this.fullPrice,
    required this.productImages,
    // required this.deliveryTime,
    // required this.isSale,
    required this.productDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.productQuantity,
    required this.TotalPrice,
  });

  /// Convert Firestore document to model
  // factory ProductModel.fromMap(Map<String, dynamic> map) {
  //   return ProductModel(
  //     productId: map['productId'] ?? '',
  //     categoryId: map['categoryId'] ?? '',
  //     productName: map['productName'] ?? '',
  //     // salePrice: (map['salePrice'] ?? 0).toDouble(),
  //     fullPrice: (map['fullPrice'] ?? '0'),
  //     productImages:
  //         (map['productImages'] as List?)?.whereType<String>().toList() ?? [],

  //     // deliveryTime: map['deliveryTime'] ?? '',
  //     // isSale: map['isSale'] ?? false,
  //     productDescription: map['productDescription'] ?? '',
  //     createdAt: map['createdAt'] != null
  //         ? (map['createdAt'] as Timestamp).toDate()
  //         : DateTime.now(),
  //     updatedAt: map['updatedAt'] != null
  //         ? (map['updatedAt'] as Timestamp).toDate()
  //         : DateTime.now(),
  //     productQuantity: map['productQuantity'] ?? 0,
  //     TotalPrice: (map['productTotalPrice'] ?? 0).toDouble(),
  //   );
  // }

  /// Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'productName': productName,
      // 'salePrice': salePrice,
      'fullPrice': fullPrice,
      'productImages': productImages,
      // 'deliveryTime': deliveryTime,
      // 'isSale': isSale,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productQuantity': productQuantity,
      'productTotalPrice': TotalPrice,
    };
  }
}
