import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class UpdarteUsernameModel extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('users');
   String newValue = '';
  void setNewValue(String value) {
    newValue = value;
    print('::::::::::::  $newValue');
  }

  Future<void> updateUsername({required String username}) async {
    try {
      // await user.updateDisplayName(username);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .update({'username': username});

      print('✅ Username successfully updated in both Auth and Firestore');
    } catch (e) {
      print('❌ Error updating username: $e');
    }
  }
}
