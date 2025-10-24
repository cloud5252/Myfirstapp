import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/User_panel/Get-x_controllers/product_price_controller.dart';

import 'package:stacked/stacked.dart';

import '../checkout_screen/checkout_screen_view.dart';

class AddToViewModel extends BaseViewModel {
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

  final User? user = FirebaseAuth.instance.currentUser;

  List<Map<String, dynamic>> cartItemsRaw = [];

  Future<double> fetchTotalPrice() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user!.uid)
          .collection('cartOrders')
          .get();

      if (snapshot.docs.isEmpty) {
        Get.snackbar(
          '',
          '',
          titleText: const Center(
            child: Text(
              'Item is Not Available',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        return 0.0;
      }

      final totalPriceRaw = snapshot.docs.first['totalprice'];
      Get.to(() => const CheckoutScreenView());
      return double.tryParse(totalPriceRaw.toString()) ?? 0.0;
    } catch (e) {
      print('Error fetching cartOrders: $e');
      Get.snackbar(
        '',
        '',
        titleText: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return 0.0;
    }
  }

  void showdailog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Deleted All Items'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              // delete logic
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}

class cloud extends BaseViewModel {}
