import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_first_app/User_panel/Models/Order_model.dart';
import 'package:my_first_app/User_panel/Models/Rating_Model.dart';
import 'package:my_first_app/User_panel/screens/Rating_bar/Add_review_model.dart';
import 'package:stacked/stacked.dart';

class AddReviewsView extends StatelessWidget {
  final OrderModel productModel;
  const AddReviewsView({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddReviewModel>.reactive(
      viewModelBuilder: () => AddReviewModel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: Colors.blue.shade200,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade200,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                )),
            centerTitle: true,
            title: const Text(
              'Add Reviews',
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text('Add your rating and review'),
                const SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 6,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (customerRating) {
                    print(customerRating);
                    viewmodel.Addrating(customerRating);
                  },
                ),
                const SizedBox(height: 20),
                const Text('Feedback'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: viewmodel.feedbackcontroller,
                  decoration: const InputDecoration(
                    label: Text(
                      'Add rating',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'Please wait...');
                    String feedback = viewmodel.feedbackcontroller.text.trim();
                    // viewmodel.Feedback(feedback);
                    RatingModel ratingModel = RatingModel(
                      customerName: productModel.customerName,
                      customerId: productModel.customerId,
                      customerPhone: productModel.customerPhone,
                      customerDeviceToken: productModel.customerDeviceToken,
                      feedback: feedback,
                      rating: viewmodel.productrating.toString(),
                      createdAt: DateTime.now(),
                    );
                    viewmodel.feedbackcontroller.clear();
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(productModel.productId)
                        .collection('reviews')
                        .doc(productModel.customerId)
                        .set(ratingModel.toMap());
                    EasyLoading.dismiss();
                    print('Add Rating :::::::');
                  },
                  child: const Text(
                    'Done',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
