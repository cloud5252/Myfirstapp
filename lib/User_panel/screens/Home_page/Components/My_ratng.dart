import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';

import '../homr_view_model.dart';

class MyRatng extends StatelessWidget {
  const MyRatng({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.nonReactive(
      viewModelBuilder: () => FavoriteViewModel(),
      builder: (context, viewmodel, child) {
        return RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        );
      },
    );
  }
}
