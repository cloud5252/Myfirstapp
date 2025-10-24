import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:get/get_core/src/get_main.dart';
import 'package:stacked/stacked.dart';

import '../../Get-x_controllers/customer_device_Token.dart';
import '../../Get-x_controllers/product_price_controller.dart';
import '../../Service_Get_x_data/place_Order.dart';

class CheckoutScreenViewModel extends BaseViewModel {
  final TextEditingController customerName = TextEditingController();
  final TextEditingController customerPhone = TextEditingController();
  final TextEditingController customerAddress = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Roboto',
    );
  }

  TextStyle textStyles() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade800,
      letterSpacing: 0.5,
      fontFamily: 'Roboto',
    );
  }

  void showCustomBottomSheet() {
    Get.bottomSheet(
        Container(
          height: Get.height * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                16.0,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    height: 55.0,
                    child: TextFormField(
                      controller: customerName,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    height: 55.0,
                    child: TextFormField(
                      controller: customerPhone,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'Phone',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    height: 55.0,
                    child: TextFormField(
                      controller: customerAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: 'Address',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 12,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
                  onPressed: () async {
                    if (customerName.text.isNotEmpty &&
                        customerPhone.text.isNotEmpty &&
                        customerAddress.text.isNotEmpty) {
                      String name = customerName.text;
                      String phone = customerPhone.text;
                      String address = customerAddress.text;
                      String? costomerToken = await getCustomerDeviceToken();
                      placeOrder(
                        costomerName: name,
                        costomerPhone: phone,
                        costomerAddress: address,
                        costomerDeviceToken: costomerToken.toString(),
                      );
                    } else {
                      print('Please fill all detail');
                    }
                  },
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
        elevation: 6);
  }
}
