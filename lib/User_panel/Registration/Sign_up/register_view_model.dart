import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_first_app/Locator/app.locator.dart';
import 'package:my_first_app/User_panel/Service_Get_x_data/Authentication.dart';
import 'package:stacked/stacked.dart';
import '../../screens/Home_page/home_view.dart';
import 'Component/My_bottom_sheet.dart';

class RegisterViewModel extends BaseViewModel {
  final namecontroller = TextEditingController();
  final Emailcontroller = TextEditingController();
  final Passwordcontroller = TextEditingController();
  void signUp(BuildContext context) async {
    String password = Passwordcontroller.text.trim();
    String name = namecontroller.text.trim();
    String email = Emailcontroller.text.trim();

    String? token = await FirebaseMessaging.instance.getToken();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please check your Textfields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Please Wait..');
      UserCredential userCredential =
          await locator<Authentication>().createdAccount(email, password);

      await userCredential.user!.sendEmailVerification();
      FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
        "bio": 'empty bio',
        "username": Emailcontroller.text.split('@')[0],
        "email": email,
        "uid": userCredential.user!.uid,
        "isActive": true,
        "createOn": DateTime.now(),
        "DeviceToken": token,
        "status": name,
        "addmin": true,
      });

      Get.to(() => const HomeView());

      EasyLoading.dismiss();

      Get.snackbar(
        'Good',
        'Registration successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
      EasyLoading.dismiss();
      print('Error: ${e.toString()}');
    }
  }

  void initialises() {
    Future.delayed(Duration.zero, () {
      Get.bottomSheet(
          MyBottomSheet(),
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: false,
      );
    });
  }
}
