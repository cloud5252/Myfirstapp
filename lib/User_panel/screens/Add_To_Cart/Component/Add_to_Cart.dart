// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/User_panel/screens/Models/ProductModel.dart';
import 'package:stacked/stacked.dart';

import '../../Wish_list/Components/My_quantity_selector.dart';
import '../Add_to_view_model.dart';

class MyCartTile1 extends StatelessWidget {
  final ProductModel productModel;

  const MyCartTile1({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = productModel.createdAt;
    String formattedDateOnly = DateFormat('d MMMM yy').format(createdAt);
    String formattedTimeOnly = DateFormat('HH:mm').format(createdAt);

    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => AddToViewModel(),
      builder: (context, viewmodel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SwipeActionCell(
            backgroundColor: Colors.blue.shade200,
            trailingActions: [
              SwipeAction(
                title: 'Delete',
                forceAlignmentToBoundary: true,
                performsFirstActionWithFullSwipe: true,
                onTap: (CompletionHandler handler) async {
                  await FirebaseFirestore.instance
                      .collection('cart')
                      .doc(viewmodel.user!.uid)
                      .collection('cartOrders')
                      .doc(productModel.productId)
                      .delete();
                },
              )
            ],
            key: ObjectKey(productModel.productId),
            child: Card(
              elevation: 5,
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(productModel.productImages[0]),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.productName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              productModel.fullPrice.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              formattedDateOnly,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              formattedTimeOnly,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    MyQuantitySelector(
                      quantity: productModel.productQuantity,
                      onIncreament: () async {
                        if (productModel.productQuantity > 0) {
                          int newQuantity = productModel.productQuantity + 1;
                          double unitPrice =
                              double.parse(productModel.fullPrice.toString());
                          double newTotalPrice = unitPrice * newQuantity;

                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(viewmodel.user!.uid)
                              .collection('cartOrders')
                              .doc(productModel.productId)
                              .update({
                            'foodquantity': newQuantity,
                            'totalprice': newTotalPrice,
                          });
                        }
                      },
                      onDecreament: () async {
                        if (productModel.productQuantity > 1) {
                          int newQuantity = productModel.productQuantity - 1;
                          double unitPrice =
                              double.parse(productModel.fullPrice.toString());
                          double newTotalPrice = unitPrice * newQuantity;

                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(viewmodel.user!.uid)
                              .collection('cartOrders')
                              .doc(productModel.productId)
                              .update({
                            'foodquantity': newQuantity,
                            'totalprice': newTotalPrice,
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
