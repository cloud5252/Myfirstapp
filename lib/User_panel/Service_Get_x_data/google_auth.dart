// ignore_for_file: unused_local_variable, camel_case_types

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  // Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  //   // final googledevicetoken googledevicetoken = Get.put(googledevicetoken());
  //   try {
  //     // Google sign-in process
  //     // final GoogleSignInAccount? gUser = await googleSignIn.;
  //     // final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //         // accessToken: gAuth.accessToken,
  //         // idToken: gAuth.idToken,
  //         );

  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     final user = userCredential.user;

  //     // final RegisterViewModel registerPage = RegisterViewModel();

  //     // if (user != null) {
  //     //   Models models = Models(
  //     //     uid: user.uid,
  //     //     username: user.displayName.toString(),
  //     //     email: user.email.toString(),
  //     //     phone: registerPage.phonecontroller.text.trim(),
  //     //     userimage: user.photoURL.toString(),
  //     //     // userdivicetoken: googledevicetoken.deviceToken.toString(),
  //     //     country: registerPage.citycontroller.text.trim(),
  //     //     useraddress: '',
  //     //     street: '',
  //     //     isaddmin: false,
  //     //     isactive: true,
  //     //     createdon: DateTime.now(),
  //     //     city: '',
  //     //   );
  //     //   await firestore
  //     //       .collection("users")
  //     //       .doc(userCredential.user!.email)
  //     //       .set(models.toMap());
  //     //   EasyLoading.dismiss();

  //     // }
  //     // await _firestore.collection("users").doc(userCredential.user!.email).set({
  //     //   "email": user.email,
  //     //   "uid": user.uid,
  //     //   "username": user.email!.split('@')[0],
  //     //   "bio": 'empty bio',
  //     //   "about": 'Hey now users',
  //     //   "status": "sent",
  //     //   "Name": "admin"
  //     // }, SetOptions(merge: true));

  //     return userCredential;
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     print("\nmessages for error: $e");
  //     HelperDialogs.showsnackbar(context, 'Check your Internet !');
  //     return null;
  //   }
  // }
}

String? deviceToken;

class googledevicetoken extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      deviceToken = token;
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade300,
        colorText: Colors.white,
      );
    }
  }
}
