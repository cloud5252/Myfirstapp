import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../User_panel/Get-x_controllers/google_controller.dart';
import '../User_panel/Service_Get_x_data/Authentication.dart';
import '../User_panel/Service_Get_x_data/google_auth.dart';
import '../User_panel/screens/Add_To_Cart/Add_to_view_model.dart';
import '../User_panel/screens/Fire_base_service/auth_service.dart';
import '../User_panel/screens/Intro/Component/intro_4_page.dart';
import '../User_panel/screens/Item_view/Cart_view_model.dart';
import '../User_panel/screens/Profile/profile_view_model.dart';
import '../User_panel/Registration/Sign_up/register_view_model.dart';
import '../User_panel/screens/splash_screens/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: Intro4Page),
  ],
  dependencies: [
    // LazySingleton(classType: NavigationService),
    LazySingleton(classType: AddToViewModel),
    LazySingleton(classType: GoogleAuth),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: AuthServices),
    LazySingleton(classType: ProfileViewModel),
    LazySingleton(classType: RegisterViewModel),
    LazySingleton(classType: Authentication),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: GoogleController),
  ],
)
class AppSetup {}
