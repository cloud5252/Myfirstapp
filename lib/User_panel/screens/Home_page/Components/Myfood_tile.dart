import 'package:flutter/material.dart';

import '../../Models/Food_Models.dart';

class MyFoodTilee extends StatelessWidget {
  final Foodd food;
  final void Function()? onTap;
  const MyFoodTilee({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: 110,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          food.foodName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          food.fullprice,
                          style: const TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          food.description,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        food.foodImage,
                        filterQuality: FilterQuality.high,
                        height: 100,
                        width: 100,
                        scale: 0.8,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            height: 100,
                            width: 100,
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        )
      ],
    );
  }
}
