// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/User_panel/screens/checkout_screen/checkout_screen_view_model.dart';
import 'package:my_first_app/User_panel/screens/checkout_screen/component/checkout_list_tile.dart';
import 'package:my_first_app/User_panel/screens/checkout_screen/component/conformed_orders.dart';
import 'package:stacked/stacked.dart';
import '../Models/ProductModel.dart';

class CheckoutScreenView extends StatelessWidget {
  const CheckoutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutScreenViewModel>.nonReactive(
      viewModelBuilder: () => CheckoutScreenViewModel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: Colors.blue.shade200,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade200,
            centerTitle: true,
            title: const Text(
              'Checkout Screen',
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cart')
                      .doc(viewmodel.user?.uid)
                      .collection('cartOrders')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 400,
                              width: 400,
                              child: Image.asset(
                                'lib/User_panel/screens/splash_screens/images/empty3.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final cartData = snapshot.data!.docs[index];

                        ProductModel productModel = ProductModel(
                          productId: cartData['foodId'],
                          categoryId: cartData['category'] ?? '',
                          productName: cartData['foodName'] ?? '',
                          fullPrice: double.tryParse(
                                  cartData["fullprice"].toString()) ??
                              0.0,
                          productDescription: cartData["description"] ?? '',
                          createdAt:
                              (cartData["createAt"] as Timestamp).toDate(),
                          updatedAt: cartData["updateAt"] != null
                              ? (cartData["updateAt"] as Timestamp).toDate()
                              : DateTime.now(),
                          productQuantity: cartData["foodquantity"] ?? 0,
                          productImages: cartData['foodImage'] != null
                              ? [cartData['foodImage']]
                              : ['No Image'],
                          TotalPrice: double.tryParse(
                                  cartData['totalprice'].toString()) ??
                              0.0,
                        );
                        viewmodel.productPriceController.fetchproductPrice();
                        return CheckoutListTile(productModel: productModel);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
              ConformedOrders(ontep: () {
                viewmodel.showCustomBottomSheet();
              }),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
