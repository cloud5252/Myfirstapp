import 'package:flutter/material.dart';
import 'package:my_first_app/User_panel/Service_Get_x_data/Authentication.dart';
import 'package:my_first_app/User_panel/screens/Orders/Orders_view.dart';

import 'package:stacked/stacked.dart';
import '../../../../Locator/app.locator.dart';
import '../../Profile/profile_view.dart';
import '../../Location/location_view.dart';
import '../../Profile/profile_view_model.dart';
import 'my_drawer_Tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewmodel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewmodel.rebuildUi();
        });

        return Drawer(
          width: 250,
          backgroundColor: Colors.blue.shade200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                    backgroundImage: viewmodel.image != null
                        ? FileImage(viewmodel.image!)
                        : null,
                    radius: 40,
                    child: viewmodel.image == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                          )
                        : null),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  viewmodel.currentuser.email!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              MyDrawerTile(
                text: 'Profile',
                icon: Icons.person,
                ontep: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileView()),
                  );
                },
              ),
              MyDrawerTile(
                text: 'Products',
                icon: Icons.production_quantity_limits,
                ontep: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileView()),
                  );
                },
              ),
              MyDrawerTile(
                text: "Orders",
                icon: Icons.shopping_cart,
                ontep: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrdersView()),
                  );
                },
              ),
              MyDrawerTile(
                text: "Wishlist",
                icon: Icons.favorite,
                ontep: () {
                  Navigator.pop(context);
                },
              ),
              MyDrawerTile(
                text: 'Contects',
                icon: Icons.help,
                ontep: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileView()),
                  );
                },
              ),
              MyDrawerTile(
                text: "Location",
                icon: Icons.location_on_outlined,
                ontep: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationView()),
                  );
                },
              ),
              const Spacer(),
              MyDrawerTile(
                text: "Logout",
                icon: Icons.logout,
                ontep: () => locator<Authentication>().signOut(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
