import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'Delete_acc_view_model.dart';

class DeleteAccView extends StatelessWidget {
  const DeleteAccView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteAccViewModel>.reactive(
      viewModelBuilder: () => DeleteAccViewModel(),
      builder: (context, viewmodel, child) {
        return const Scaffold();
      },
    );
  }
}
