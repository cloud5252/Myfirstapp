import 'package:flutter/material.dart';
import 'package:my_first_app/User_panel/screens/checkout_screen/checkout_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class ConformedOrders extends StatelessWidget {
  final Function()? ontep;
  const ConformedOrders({super.key, required this.ontep});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutScreenViewModel>.nonReactive(
      viewModelBuilder: () => CheckoutScreenViewModel(),
      builder: (context, viewmodel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: ontep,
            child: Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Conformed Orders',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
