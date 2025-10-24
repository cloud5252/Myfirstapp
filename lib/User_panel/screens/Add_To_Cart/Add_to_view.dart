import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../Models/ProductModel.dart';
import 'Add_to_view_model.dart';
import 'Component/Add_to_Cart.dart';
import 'Component/MyCartData.dart';

class AddToView extends StatelessWidget {
  const AddToView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddToViewModel>.reactive(
      viewModelBuilder: () => AddToViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.blue.shade200,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade200,
            title: const Text(
              "Your Cart",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  viewModel.showdailog(context);
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('cart')
                          .doc(viewModel.user?.uid)
                          .collection('cartOrders')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        }

                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
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

                            ProductModel Ordermodel = ProductModel(
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
                            viewModel.productPriceController
                                .fetchproductPrice();
                            return MyCartTile1(productModel: Ordermodel);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
              const Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: MyCartData(),
              ),
            ],
          ),
        );
      },
    );
  }
}
