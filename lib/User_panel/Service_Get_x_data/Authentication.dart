import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../screens/Home_page/home_view.dart';
import '../Registration/Sign_up/register_page.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential? userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "email": email,
        "uid": userCredential.user!.uid,
      }, SetOptions(merge: true));
      Get.offAll(() => const HomeView());
      Get.snackbar(
        'Good',
        'Sign In successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> createdAccount(String email, String password) async {
    try {
      UserCredential? userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> forgetWithEmailandPassword(String email) async {
    try {
      EasyLoading.show(status: 'please wait..');
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      Get.snackbar(
        'Request sent successfull',
        'Password reeesr link sent to:\n$email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deletedAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await user!.reauthenticateWithCredential(credential);
    await user!.delete();
    await _firebaseAuth.signOut();
  }

  Future<void> resetpasswordfromcrrentpassword({
    required String email,
    required String newpassword,
    required String currentpassword,
  }) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: currentpassword);
    await user!.reauthenticateWithCredential(credential);
    await user!.updatePassword(newpassword);
  }

  Future<void> updateusername({required String username}) async {
    await user!.updateDisplayName(username);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    Get.offAll(() => RegisterPage());
  }

  User? getcurrentuser() {
    return _firebaseAuth.currentUser;
  }
}
