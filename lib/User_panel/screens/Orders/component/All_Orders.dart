// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/User_panel/screens/Models/Order_model.dart';
import 'package:my_first_app/User_panel/screens/Orders/Orders_view_model.dart';
import 'package:my_first_app/User_panel/screens/Rating_bar/Add_reviews_view.dart';
import 'package:stacked/stacked.dart';

class AllOrders extends StatelessWidget {
  final OrderModel productModel;

  const AllOrders({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = productModel.createdAt;
    String formattedDateOnly = DateFormat('d MMMM yy').format(createdAt);

    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => OrdersViewModel(),
      builder: (context, viewmodel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SwipeActionCell(
            backgroundColor: Colors.blue.shade200,
            trailingActions: [
              SwipeAction(
                title: 'Delete',
                forceAlignmentToBoundary: true,
                performsFirstActionWithFullSwipe: true,
                onTap: (CompletionHandler handler) async {
                  await FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(viewmodel.user!.uid)
                      .collection('confirmedOrders')
                      .doc(productModel.productId)
                      .delete();
                },
              )
            ],
            key: ObjectKey(productModel.productId),
            child: Card(
              elevation: 5,
              color: Colors.white70,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(productModel.productImages[0]),
                ),
                title: Text(
                  productModel.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹${productModel.fullPrice}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          formattedDateOnly,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          productModel.status == false
                              ? 'Pending..'
                              : 'Delivered',
                          style: TextStyle(
                            fontSize: 14,
                            color: productModel.status == false
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: productModel.status == true
                    ? ElevatedButton(
                        onPressed: () => Get.to(
                            () => AddReviewsView(productModel: productModel)),
                        child: const Text('Review'),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
    );
  }
}
