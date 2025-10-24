import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/User_panel/Registration/Update_user_Name/Update_UserName_view.dart';
import 'package:stacked/stacked.dart';

import 'Components/My_textbox.dart';
import 'Components/profile_image_edit.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viemodel, child) {
        return Scaffold(
          backgroundColor: Colors.blue.shade200,
          body: Stack(
            children: [
              // 🔹 Main Content
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(viemodel.currentuser.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data?.data() == null) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  }

                  // ignore: unused_local_variable
                  final userdata =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 130),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.white, // border color
                              width: 3, // border width
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const ProfileImageEdit(),
                              const SizedBox(height: 20),
                              Text(
                                userdata['username'] ?? 'No Username',
                                // viemodel.currentuser.displayName ??
                                //     'No username',
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                viemodel.currentuser.email!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 350,
                          child: MyTextBox(
                            pressed: (index) {
                              switch (index) {
                                case 0:
                                  Get.to(() => Updateusername());
                                  break;
                                case 1:
                                  // Get.to(() => ChangePasswordView());
                                  break;
                                case 2:
                                  // Get.to(() => DeleteAccountView());
                                  break;
                                case 3:
                                  // Get.to(() => AboutAppView());
                                  break;
                                case 4:
                                  // viemodel.logout();
                                  break;
                              }
                            },

                            // () =>
                            //     viemodel.editfield(context, 'username'),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),

              // 🔹 Back button fixed at top
              Positioned(
                left: 15,
                top: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
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
