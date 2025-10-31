import 'package:flutter/material.dart';
import 'package:my_first_app/Locator/app.locator.dart';
import 'package:stacked/stacked.dart';
import '../../screens/Fire_base_service/auth_service.dart';
import 'signIn_view_model.dart';

class LoginPage extends StatelessWidget {
  // final void Function()? onTap;
  LoginPage({super.key});
  final authServices = locator<AuthServices>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(
                    'lib/User_panel/screens/splash_screens/images/sign.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
