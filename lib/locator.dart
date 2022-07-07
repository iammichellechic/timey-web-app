import 'package:get_it/get_it.dart';
import 'package:timey_web/api_call.dart';

import 'services/dialog_services.dart';
import 'services/navigation_service.dart';
import 'services/timeblocks_api_service.dart';

GetIt locator = GetIt.instance;


void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => TimeBlockDataSource());
  locator.registerLazySingleton(() => SafeApiCall());
  
}
