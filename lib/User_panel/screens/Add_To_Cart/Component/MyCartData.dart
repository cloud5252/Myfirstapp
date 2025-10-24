import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/User_panel/Get-x_controllers/product_price_controller.dart';
import 'package:my_first_app/User_panel/screens/Add_To_Cart/Add_to_view_model.dart';
import 'package:stacked/stacked.dart';

class MyCartData extends StatelessWidget {
  const MyCartData({super.key});

  @override
  Widget build(BuildContext context) {
    final priceController = Get.find<ProductPriceController>();
    return ViewModelBuilder<AddToViewModel>.reactive(
      viewModelBuilder: () => AddToViewModel(),
      builder: (context, viewmodel, child) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('cart')
                .doc(viewmodel.user!.uid)
                .collection('cartOrders')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final List<DocumentSnapshot> cartDocs = snapshot.data?.docs ?? [];

              double totalPrice = 0.0;

              if (cartDocs.isNotEmpty) {
                final totalPriceRaw = cartDocs.first['totalprice'];
                totalPrice = double.tryParse(totalPriceRaw.toString()) ?? 0.0;
              }

              // Update GetX controller
              priceController.totalprice.value = totalPrice;

              return GestureDetector(
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Obx(() => Row(
                            children: [
                              const Text(
                                'Total Price:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${priceController.totalprice.value.toStringAsFixed(1)} : PKR',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          viewmodel.fetchTotalPrice();
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CheckOut',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
