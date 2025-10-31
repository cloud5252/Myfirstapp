// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_first_app/User_panel/Service_Get_x_data/random_order_id.dart';
import 'package:my_first_app/User_panel/screens/Home_page/home_view.dart';
import 'package:my_first_app/User_panel/Models/Order_model.dart';

void placeOrder({
  required String costomerName,
  required String costomerPhone,
  required String costomerAddress,
  required String costomerDeviceToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: 'Please Wait..');

  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String orderId = generateRandomcostomerId();

        OrderModel orderModel = OrderModel(
          customerId: user.uid,
          status: false,
          productId: data['foodId']?.toString() ?? '',
          categoryId: data['category']?.toString() ?? '',
          productName: data['foodName']?.toString() ?? '',
          fullPrice: data['fullprice'],
          productImages: data['foodImage'] is List
              ? List<String>.from(data['foodImage'])
              : [data['foodImage'].toString()],
          isSale: data['isSale'] ?? false,
          productDescription: data['description']?.toString() ?? '',
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'] ?? DateTime.now(),
          productQuantity: data['foodquantity'] ?? 1,
          productTotalPrice:
              double.tryParse(data['totalprice']?.toString() ?? '') ?? 0.0,
          customerName: costomerName,
          customerPhone: costomerPhone,
          customerAddress: costomerAddress,
          customerDeviceToken: costomerDeviceToken,
        );

        print('Orders Added');

        // Save main order data

        for (var i = 0; i < documents.length; i++) {
          await FirebaseFirestore.instance
              .collection('Orders')
              .doc(user.uid)
              .set({
            'uid': user.uid,
            'customerName': costomerName,
            "customerPhone": costomerPhone,
            'customerAddress': costomerAddress,
            'customerDeviceToken': costomerDeviceToken,
            'orderStatus': false,
            'createdAt': DateTime.now(),
          });
        }
        // await FirebaseFirestore.instance.collection('Orders').doc(orderId).set({
        //   'uid': user.uid,
        //   'customerName': costomerName,
        //   "customerPhone": costomerPhone,
        //   'customerAddress': costomerAddress,
        //   'customerDeviceToken': costomerDeviceToken,
        //   'orderStatus': false,
        //   'createdAt': DateTime.now(),
        // });

        // Save order details in subcollection
        await FirebaseFirestore.instance
            .collection('Orders')
            .doc(user.uid)
            .collection('confirmedOrders')
            .doc(orderId)
            .set(orderModel.toMap());

        // Delete from cart
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .collection('cartOrders')
            .doc(orderModel.productId)
            .delete();
      }

      EasyLoading.dismiss();

      Get.snackbar(
        'Order Confirmed',
        'Thanks for your order!',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      Get.offAll(() => const HomeView());
    } catch (e) {
      EasyLoading.dismiss();
      print('Error placing order: $e');
      Get.snackbar(
        'Error',
        'Something went wrong!',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } else {
    EasyLoading.dismiss();
    Get.snackbar(
      'Not Logged In',
      'Please log in to place your order.',
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
