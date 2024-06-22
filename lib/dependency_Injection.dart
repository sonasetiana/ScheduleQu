import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:schedule_qu/data/provider/local/user_local_provider.dart';
import 'package:schedule_qu/data/provider/remote/user_remote_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_configs.dart';
import 'data/repository/user_repository.dart';

class DependencyInjection {
  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final GetIt getIt = GetIt.I;

    getIt.registerSingleton<CollectionReference>(
      FirebaseFirestore.instance.collection(AppConfigs.defaultCollection),
    );

    getIt.registerSingleton<UserLocalProvider>(
      UserLocalProviderImpl(prefs: prefs),
    );

    getIt.registerSingleton<UserRemoteProvider>(
      UserRemoteProviderImpl(
        reference: getIt<CollectionReference>(),
      ),
    );

    getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(
        localProvider: getIt<UserLocalProvider>(),
        remoteProvider: getIt<UserRemoteProvider>(),
      ),
    );
  }
}
