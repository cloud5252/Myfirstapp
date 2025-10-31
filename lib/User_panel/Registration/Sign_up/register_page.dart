import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/User_panel/Service_Get_x_data/google_auth.dart';
import 'package:stacked/stacked.dart';

import '../../Get-x_controllers/google_controller.dart';
import 'register_view_model.dart';

class registerpagestesting extends BaseViewModel {}

class RegisterPage extends StatelessWidget {
  // final void Function()? onTap;

  RegisterPage({
    super.key,
  });
  final GoogleController googleController = Get.put(GoogleController());
  final GoogleAuth googleAuth = Get.put(GoogleAuth());

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      onViewModelReady: (model) => model.initialises(),
      builder: (context, viewmodel, child) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Positioned(
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(
                    'lib/User_panel/screens/splash_screens/images/sign.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
