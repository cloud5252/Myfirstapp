// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../User_panel/Service_Get_x_data/Authentication.dart';
import '../User_panel/Service_Get_x_data/google_auth.dart';
import '../User_panel/screens/Add_To_Cart/Add_to_view_model.dart';
import '../User_panel/screens/Fire_base_service/auth_service.dart';
import '../User_panel/screens/Profile/profile_view_model.dart';
import '../User_panel/Registration/Sign_up/register_view_model.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AddToViewModel());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => GoogleAuth());
  locator.registerLazySingleton(() => RegisterViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => Authentication());
}
