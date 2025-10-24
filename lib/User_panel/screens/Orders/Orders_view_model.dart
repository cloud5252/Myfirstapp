import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class OrdersViewModel extends BaseViewModel {
  User? user = FirebaseAuth.instance.currentUser;
    Future<List<QueryDocumentSnapshot>> fetchAllConfirmedOrders(User user) async {
    final userOrdersSnapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('uid', isEqualTo: user.uid)
        .get();

    List<QueryDocumentSnapshot> allConfirmedOrders = [];

    for (var orderDoc in userOrdersSnapshot.docs) {
      final confirmedOrdersSnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderDoc.id)
          .collection('confirmedOrders')
          .get();

      allConfirmedOrders.addAll(confirmedOrdersSnapshot.docs);
    }

    return allConfirmedOrders;
  }
}
