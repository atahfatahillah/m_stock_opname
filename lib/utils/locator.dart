import 'package:get_it/get_it.dart';
import 'package:m_stock_opname/services/app_db.dart';

final locator = GetIt.I;

void setupLocator() {
  locator.registerSingletonAsync<AppDB>(
      () async => $FloorAppDB.databaseBuilder('app_database.db').build());

  locator.registerSingletonWithDependencies(() => locator<AppDB>().itemsDao,
      dependsOn: [AppDB]);
}
