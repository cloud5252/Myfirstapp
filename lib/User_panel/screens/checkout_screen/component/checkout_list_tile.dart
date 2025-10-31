// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/User_panel/Models/ProductModel.dart';
import 'package:stacked/stacked.dart';

import '../checkout_screen_view_model.dart';

class CheckoutListTile extends StatelessWidget {
  final ProductModel productModel;

  const CheckoutListTile({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = productModel.createdAt;

    int productquantity = productModel.productQuantity;
    double totalprice = productModel.TotalPrice;
    String formattedDateOnly = DateFormat('d MMMM yy').format(createdAt);
    String formattedTimeOnly = DateFormat('HH:mm').format(createdAt);

    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => CheckoutScreenViewModel(),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name:  ${productModel.productName}",
                            style: viewmodel.textStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                'Price:  ${productModel.fullPrice.toString()}',
                                style: viewmodel.textStyles(),
                              ),
                            ],
                          ),
                          Text(
                            'Quantity:  $productquantity',
                            style: viewmodel.textStyles(),
                          ),
                          Text(
                            'Total Price:  ${totalprice.toString()}',
                            style: viewmodel.textStyles(),
                          ),
                          Row(
                            children: [
                              Text(
                                'Time:  $formattedDateOnly',
                                style: viewmodel.textStyles(),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                formattedTimeOnly,
                                style: viewmodel.textStyles(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
