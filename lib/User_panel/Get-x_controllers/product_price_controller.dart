import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductPriceController extends GetxController {
  RxDouble totalprice = 0.0.obs;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    fetchproductPrice();
    super.onInit();
    print("Fetching prices from Firebase...");
  }

  void fetchproductPrice() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(user!.uid)
        .collection('cartOrders')
        .snapshots()
        .listen((snapshot) {
      double sum = 0.0;

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final total = data['totalprice'];

        // Only process if totalprice is valid
        if (total != null &&
            (total is num || double.tryParse(total.toString()) != null)) {
          sum += double.parse(total.toString());
        }
      }

      totalprice.value = sum;
      print("Updated total price: $sum");
    });
  }
}
