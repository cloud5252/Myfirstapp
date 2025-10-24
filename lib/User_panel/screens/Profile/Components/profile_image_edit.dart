import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../profile_view_model.dart';

class ProfileImageEdit extends StatelessWidget {
  const ProfileImageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewmodel, child) {
        return Stack(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: viewmodel.image != null
                      ? DecorationImage(
                          image: FileImage(viewmodel.image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: viewmodel.image == null
                    ? const Center(
                        child: Text(
                          '😊',
                          style: TextStyle(fontSize: 80),
                        ),
                      )
                    : null,
              ),
            ),
            Positioned(
              top: 60,
              right: 95,
              child: IconButton(
                  onPressed: () {
                    viewmodel.pickImage();
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.edit,
                      ),
                    ),
                  )),
            )
          ],
        );
      },
    );
  }
}
