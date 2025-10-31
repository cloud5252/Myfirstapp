import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_User_Models.dart';

class GoogleAuth extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      EasyLoading.show(status: "Loading...");

      // 1) Authenticate (sign-in)
      final GoogleSignInAccount? gUser = await googleSignIn.authenticate();
      if (gUser == null) {
        EasyLoading.dismiss();
        return null;
      }

      const List<String> scopes = <String>[
        'openid',
        'email',
        'profile',
      ];

      final GoogleSignInClientAuthorization? clientAuth =
          await gUser.authorizationClient.authorizationForScopes(scopes);

      final String? accessToken = clientAuth?.accessToken;

      if (accessToken == null) {
        final GoogleSignInClientAuthorization? granted =
            await gUser.authorizationClient.authorizeScopes(scopes);

        final String? altAccessToken = granted?.accessToken;
        if (altAccessToken != null) {
          // use altAccessToken
        }
      }

      if (accessToken == null) {
        EasyLoading.dismiss();

        Get.snackbar('Error', 'Could not get access token from Google sign-in');
        return null;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user == null) {
        EasyLoading.dismiss();
        return null;
      }

      final DocumentSnapshot userDoc =
          await firestore.collection("users").doc(user.uid).get();

      if (!userDoc.exists) {
        Models models = Models(
          uid: user.uid,
          username: user.displayName ?? "User",
          email: user.email ?? "",
          userimage: user.photoURL ?? "",
          userdivicetoken: "",
          useraddress: "",
          street: "",
          isaddmin: false,
          isactive: true,
          createdon: DateTime.now(),
        );

        await firestore
            .collection("users")
            .doc(user.uid)
            .set(models.toMap(), SetOptions(merge: true));
      } else {
        await firestore.collection("users").doc(user.uid).update({
          "userdivicetoken": "",
        });
      }

      EasyLoading.dismiss();
      return userCredential;
    } catch (e) {
      EasyLoading.dismiss();
      print("\nError Logging In: $e");
      return null;
    }
  }
}
