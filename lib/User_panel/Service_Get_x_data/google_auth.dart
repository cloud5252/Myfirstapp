import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_User_Models.dart';

class GoogleAuth extends GetxController {
  // Optionally provide clientId/serverClientId here if needed:
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      EasyLoading.show(status: "Loading...");

      // 1) Authenticate (sign-in)
      final GoogleSignInAccount? gUser = await googleSignIn.authenticate();
      if (gUser == null) {
        // user cancelled
        EasyLoading.dismiss();
        return null;
      }

      // 2) Request authorization tokens for scopes we need (email/openid/profile)
      //    Without requesting scopes, newer versions do NOT return accessToken.
      const List<String> scopes = <String>[
        'openid',
        'email',
        'profile',
      ];

      // Try to get a client authorization (may return null if scopes not granted)
      final GoogleSignInClientAuthorization? clientAuth =
          await gUser.authorizationClient.authorizationForScopes(scopes);

      // clientAuth currently exposes an accessToken (see package docs)
      final String? accessToken = clientAuth?.accessToken;

      // On some platforms you may need to request a server auth code instead:
      // final GoogleSignInServerAuthorization? serverAuth =
      //     await gUser.authorizationClient.authorizeServer(scopes);
      // final String? serverAuthCode = serverAuth?.code;

      // If we couldn't get an accessToken, try a user-driven permission flow:
      if (accessToken == null) {
        // This will prompt the user to consent to the requested scopes (if required).
        final GoogleSignInClientAuthorization? granted =
            await gUser.authorizationClient.authorizeScopes(scopes);
        // authorizeScopes() may prompt the user and then return a token
        // (or null if user refuses).
        // use granted?.accessToken after this
        final String? altAccessToken = granted?.accessToken;
        if (altAccessToken != null) {
          // use altAccessToken
        }
      }

      // NOTE: The old google_sign_in package used to return both idToken and accessToken
      // on GoogleSignInAuthentication. In v7+ you should get an accessToken via
      // the authorizationClient. For idToken you might get it from the server flow
      // or the authorization response depending on platform; otherwise exchange
      // a serverAuthCode on your server to get tokens.

      // For Firebase Auth we need an OAuth credential. If you have an idToken & accessToken:
      // final OAuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: accessToken,
      //   idToken: idToken,
      // );
      //
      // If you only have a server auth code, send it to your backend to exchange for tokens,
      // or use a platform-specific approach to obtain an idToken.

      // Example: if accessToken is available, use it (idToken may be null on some platforms)
      if (accessToken == null) {
        EasyLoading.dismiss();
        // handle as needed: show message, or fall back to server auth code flow
        Get.snackbar('Error', 'Could not get access token from Google sign-in');
        return null;
      }

      // Create Firebase credential using access token (idToken optional)
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        // idToken: idTokenIfYouHaveIt,
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
          phone: "",
          userimage: user.photoURL ?? "",
          userdivicetoken: "",
          country: "",
          useraddress: "",
          street: "",
          isaddmin: false,
          isactive: true,
          createdon: DateTime.now(),
          city: "",
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
