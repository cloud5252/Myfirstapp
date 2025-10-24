import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../Profile/profile_view_model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewmodel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewmodel.rebuildUi();
        });

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 50, top: 40),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: viewmodel.image != null
                        ? FileImage(viewmodel.image!)
                        : null,
                    radius: 45,
                    child: viewmodel.image == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                          )
                        : null,
                  ),
                  Text(
                    viewmodel.currentuser.email!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
