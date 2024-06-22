import 'package:schedule_qu/core/app_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalProvider {
  String? getUsername();
  Future<void> setUsername(String username);
}

class UserLocalProviderImpl extends UserLocalProvider {
  final SharedPreferences prefs;

  UserLocalProviderImpl({required this.prefs});

  @override
  String? getUsername() {
    return prefs.getString(AppConfigs.keyUsername);
  }

  @override
  Future<void> setUsername(String username) async {
    await prefs.setString(AppConfigs.keyUsername, username);
  }
}
