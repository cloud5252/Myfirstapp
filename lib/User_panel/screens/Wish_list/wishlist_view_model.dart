import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import '../../Models/Food.dart';

class CartViewModel extends BaseViewModel {
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
            onPressed: () {},
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void addToCart(Food food, BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueGrey.shade100,
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                '${food.name} added to cart!',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove overlay after a delay
    Future.delayed(
      const Duration(seconds: 2),
      () {
        overlayEntry.remove();
      },
    );
  }
}
