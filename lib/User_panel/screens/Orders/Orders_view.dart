import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/User_panel/screens/Orders/Orders_view_model.dart';
import 'package:stacked/stacked.dart';

import '../Models/Order_model.dart';
import 'component/All_Orders.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  // Yeh async function bana rahe hain jo data fetch karega

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrdersViewModel>.reactive(
      viewModelBuilder: () => OrdersViewModel(),
      builder: (context, viewmodel, chile) {
        final user = FirebaseAuth.instance.currentUser;

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
                onPressed: () {},
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
          body: user == null
              ? const Center(child: Text('User not logged in'))
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(user.uid)
                      .collection('confirmedOrders')
                      .snapshots(),
                  // viewmodel.fetchAllConfirmedOrders(user),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error.toString()}'));
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
                            const SizedBox(height: 10),
                            const Text('No confirmed orders found'),
                          ],
                        ),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final cartData = docs[index];
                        OrderModel productModel = OrderModel(
                          productId: cartData['productId'] ?? '',
                          categoryId: cartData['categoryId'] ?? '',
                          productName: cartData['productName'] ?? '',
                          fullPrice: cartData['fullPrice'] ?? 0,
                          productDescription:
                              cartData["productDescription"] ?? '',
                          createdAt:
                              (cartData["createdAt"] as Timestamp).toDate(),
                          updatedAt: cartData["updatedAt"] != null
                              ? (cartData["updatedAt"] as Timestamp).toDate()
                              : DateTime.now(),
                          productQuantity: cartData["productQuantity"] ?? 0,
                          productImages: cartData['productImages'] == null
                              ? []
                              : cartData['productImages'] is String
                                  ? [cartData['productImages']]
                                  : List<String>.from(
                                      cartData['productImages']),
                          customerId: cartData['customerId'] ?? '',
                          status: cartData['status'] ?? '',
                          customerName: cartData['customerName'] ?? '',
                          customerPhone: cartData['customerPhone'] ?? '',
                          customerAddress: cartData['customerAddress'] ?? '',
                          customerDeviceToken:
                              cartData['customerDeviceToken'] ?? '',
                          isSale: cartData['isSale'] ?? false,
                          productTotalPrice: cartData['productTotalPrice'] ?? 0,
                        );

                        return AllOrders(
                          productModel: productModel,
                        );

                        //  ListTile(
                        //   title: Text(productModel.productName),
                        //   subtitle:
                        //       Text("Qty: ${productModel.productQuantity}"),
                        // );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
