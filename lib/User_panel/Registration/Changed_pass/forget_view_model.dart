import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../../Locator/app.locator.dart';
import '../../Service_Get_x_data/Authentication.dart';

class ForgetViewModel extends BaseViewModel {
  final emailControllers = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void forgetpassword() async {
    String email = emailControllers.text.trim();

    try {
      await locator<Authentication>().forgetWithEmailandPassword(
        email,
      );

      if (email.isEmpty) {
        Get.snackbar(
          'Error',
          'Please check your Email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade900,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (email.isEmpty) {
        Get.snackbar(
          'Error',
          'Please check your Textfields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade900,
          colorText: Colors.white,
        );
      }
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );
    }
  }

  // Sign-out
}
