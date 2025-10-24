// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stacked/stacked.dart';

import '../../../Locator/app.locator.dart';
import '../../Service_Get_x_data/Authentication.dart';
import '../../screens/ADDMIN_VIEW/Addmin_view.dart';
import '../../screens/Fire_base_service/addmin&userdata.dart';
import '../../screens/Home_page/home_view.dart';

class SigninViewModel extends BaseViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signIn(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final Addminuserdata addminuserdata = Get.put(Addminuserdata());
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      await locator<Authentication>().signInWithEmailandPassword(
        email,
        password,
      );

      var userdata =
          await addminuserdata.getUserData(firebaseAuth.currentUser!.uid);

      if (userdata.isNotEmpty) {
        var userData = userdata[0].data() as Map<String, dynamic>;

        if (userData['addmin'] == true) {
          Get.offAll(() => const AddminView());
          Get.snackbar(
            'Home View',
            'Successfully signed in as regular user',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue.shade900,
            colorText: Colors.white,
          );
        } else {
          Get.offAll(() => const HomeView());
          Get.snackbar(
            'Admin View',
            'Successfully signed in as admin',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue.shade900,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'User data not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade900,
          colorText: Colors.white,
        );
      }

      if (password != email) {
        Get.snackbar(
          'Error',
          'Please check your Email & password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade900,
          colorText: Colors.white,
        );
      }

      passwordController.clear();
    } catch (e) {
      if (password.isEmpty || email.isEmpty) {
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
      print('Error:::::::::::::::$e');
    }
  }
}
