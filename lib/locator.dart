import 'package:get_it/get_it.dart';

import 'services/navigation-service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
