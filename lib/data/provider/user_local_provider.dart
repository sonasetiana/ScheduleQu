import 'package:hive/hive.dart';
import 'package:schedule_qu/core/app_configs.dart';

abstract class UserLocalProvider {
  String getUsername();
  void setUsername(String username);
}

class UserLocalProviderImpl extends UserLocalProvider {
  final HiveInterface hive;

  UserLocalProviderImpl({required this.hive});

  @override
  String getUsername() {
    final box = hive.box(AppConfigs.boxUsername);
    return box.get(AppConfigs.boxUsername);
  }

  @override
  void setUsername(String username) {
    final box = hive.box(AppConfigs.boxUsername);
    box.put(AppConfigs.keyUsername, username);
  }
}
