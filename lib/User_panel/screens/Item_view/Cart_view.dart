import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/User_panel/screens/Models/Rating_Model.dart';
import 'package:stacked/stacked.dart';
import '../Models/Food_Models.dart';
import 'Cart_view_model.dart';
import 'Components/My_button.dart';

class CartView extends StatelessWidget {
  final Foodd food;

  const CartView({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(food: food),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 400,
                    child: Image.network(
                      filterQuality: FilterQuality.high,
                      food.foodImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      border: const Border(
                        top: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        bottom: BorderSide.none,
                      ),
                    ),
                    height: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                food.foodName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    viewModel.showRatingDialog(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '${viewModel.rating}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Text(
                          '\$${food.fullprice}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          food.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        // Review
                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('products')
                              .doc(food.foodId)
                              .collection('reviews')
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('No Reviews Foun!'),
                              );
                            }
                            if (snapshot.data != null) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];

                                  RatingModel ratingModel = RatingModel(
                                    customerName: data['customerName'],
                                    customerId: data['customerId'],
                                    customerPhone: data['customerPhone'],
                                    customerDeviceToken:
                                        data['customerDeviceToken'],
                                    feedback: data['feedback'],
                                    rating: data['rating'],
                                    createdAt: data['createdAt'],
                                  );

                                  return Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child:
                                            Text(ratingModel.customerName[0]),
                                      ),
                                      title: Text(ratingModel.customerName),
                                      subtitle: Text(ratingModel.feedback),
                                      trailing: Text(ratingModel.rating),
                                    ),
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                left: 10,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white70,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: double.infinity,
              ),
              Positioned(
                bottom: 30,
                left: 5,
                right: 5,
                child: MyButtons(
                  text: "Add To Cart",
                  onTap: () async {
                    await viewModel.Addtocartexisting(context, uid: user!.uid);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
