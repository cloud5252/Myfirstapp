import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../Models/Food.dart';
import '../wishlist_view_model.dart';

class MyCartTile extends StatelessWidget {
  final Food food;

  const MyCartTile(
    this.food, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.nonReactive(
      viewModelBuilder: () => CartViewModel(),
      builder: (context, viewmodel, child) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 900),
          builder: (BuildContext context, double value, Widget? child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, value * 10),
                child: child,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            viewmodel.addToCart(food, context);
                            viewmodel.rebuildUi();
                          },
                          child: const Text("Cart"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
