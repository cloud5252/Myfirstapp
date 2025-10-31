// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../Models/Food_Models.dart';

class HomeViewModel extends BaseViewModel {
  final Foodd food;
  late final Foodd foood;
  Future<void> Addtocartexisting(BuildContext context,
      {required String uid, int quantityincreament = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('cartOrders')
        .doc(foood.foodId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentquentity = snapshot['foodquantity'];
      int updataquantity = currentquentity + quantityincreament;
      double totalprice = double.parse(food.fullprice) * updataquantity;

      double roundToTowDecimal(double value) {
        return double.parse(value.toStringAsFixed(2));
      }

      await documentReference.update({
        'foodquantity': updataquantity,
        'totalprice': roundToTowDecimal(totalprice),
      });
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uid).set(
        {
          'uid': uid,
          'createAt': DateTime.now(),
        },
      );
      await documentReference.set({
        ...foood.toMap(),
        'foodquantity': quantityincreament,
        'fullprice': foood.fullprice,
        'totalprice': foood.fullprice,
      });
      print('product added');
      Navigator.pop(context);
    }
  }

  

  double rating = 1.5;
  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate the Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 40.0,
                allowHalfRating: true,
                updateOnDrag: true,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        color: Colors.red,
                      );
                    case 1:
                      return const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.green,
                      );
                    case 2:
                      return const Icon(
                        Icons.sentiment_neutral,
                        color: Colors.blue,
                      );
                    case 3:
                      return const Icon(
                        Icons.sentiment_dissatisfied_rounded,
                        color: Colors.yellow,
                      );
                    case 4:
                      return const Icon(
                        Icons.sentiment_dissatisfied_rounded,
                        color: Colors.green,
                      );
                    default:
                      return const Text('');
                  }
                },
                onRatingUpdate: (ratingw) {
                  rating = ratingw;
                  rebuildUi();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  HomeViewModel({required this.food}) {
    foood = Foodd(
      foodId: food.foodId,
      foodImage: food.foodImage,
      foodName: food.foodName,
      createAt: DateTime.now(),
      updataAt: DateTime.now(),
      category: food.category,
      fullprice: food.fullprice,
      description: food.description,
      foodquentity: food.foodquentity,
      totalprice: food.totalprice,
    );
  }
}
