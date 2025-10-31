import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_first_app/Locator/app.locator.dart';
import 'package:my_first_app/User_panel/screens/Home_page/home_view.dart';
import '../Service_Get_x_data/auth_User_Models.dart';
import '../Registration/Sign_up/register_view_model.dart';

class GoogleController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final registerPage = locator<RegisterViewModel>();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _isGoogleInitialized = false;

  Future<void> _ensureInitialized() async {
    if (!_isGoogleInitialized) {
      await _googleSignIn.initialize();
      _isGoogleInitialized = true;
    }
  }

  Future<void> getGoogleAccount() async {
    try {
      await _ensureInitialized();
      await _googleSignIn.signOut();

      final gUser =
          await _googleSignIn.authenticate(scopeHint: ['email', 'profile']);
      // ignore: unnecessary_null_comparison
      if (gUser == null) return;

      final gAuth = gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.idToken,
      );
      String? token = await FirebaseMessaging.instance.getToken();
      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final users = userCred.user;
      debugPrint("Signed in as: ${userCred.user?.email}");
      final Models model = Models(
        uid: users!.uid,
        username: users.displayName ?? 'No Name',
        email: users.email ?? '',
        userimage: users.photoURL ?? '',
        userdivicetoken: token.toString(),
        useraddress: '',
        street: '',
        isaddmin: false,
        isactive: true,
        createdon: DateTime.now(),
       
      );

      await _firestore.collection("users").doc(users.email).set(model.toMap());

      EasyLoading.dismiss();
      Get.off(() => const HomeView());

      Get.snackbar(
        "Success",
        "Signed in with Google successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      debugPrint("Auth error: $e");
    }
  }
}
