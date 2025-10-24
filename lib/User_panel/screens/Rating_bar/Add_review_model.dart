import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class AddReviewModel extends BaseViewModel {
  final TextEditingController feedbackcontroller = TextEditingController();
  double productrating = 0.0;
  Addrating(double rating) {
    productrating = rating;
    rebuildUi();
    print('Current Rating :: ');
  }

  String Feedback(String feedback) {
    print('feeeeeedback:::: $feedback');
    feedbackcontroller.clear();
    rebuildUi();
    return feedback;
  }
}
