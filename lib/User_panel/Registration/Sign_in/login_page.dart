import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_first_app/Locator/app.locator.dart';
import 'package:stacked/stacked.dart';
import '../../components/My_button.dart';
import '../../components/My_text_field.dart';
import '../../components/google_button.dart';
import '../../screens/Fire_base_service/auth_service.dart';
import '../Changed_pass/Forget_password.dart';
import 'signIn_view_model.dart';
import '../Sign_up/register_page.dart';

class LoginPage extends StatelessWidget {
  // final void Function()? onTap;
  LoginPage({super.key});
  final authServices = locator<AuthServices>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigninViewModel>.nonReactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: Colors.grey,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.blue.shade900,
                  height: 260,
                  width: 400,
                  child: Lottie.asset('assets/splash.json'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: viewmodel.emailController,
                            hintText: "Email",
                            obscurdtext: false,
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: viewmodel.passwordController,
                            hintText: "Password",
                            obscurdtext: false,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Get.to(const ForgetPassword()),
                                child: const Text(
                                  'Forget Password!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          MyButton(
                              text: "Sign In",
                              onTap: () => viewmodel.signIn(
                                    context,
                                  )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child:
                                    Divider(thickness: 2, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Or Continue With'),
                              ),
                              Expanded(
                                child:
                                    Divider(thickness: 2, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GoogleButton(text: "Google Sign In", onTap: () => {}
                              // locator<GoogleAuth>().signInWithGoogle(context),
                              ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Not a member?"),
                              GestureDetector(
                                onTap: () => Get.to(() => RegisterPage()),
                                child: const Text(
                                  " Register Now",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
