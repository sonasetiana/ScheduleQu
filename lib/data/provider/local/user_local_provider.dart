import 'dart:convert';

import 'package:schedule_qu/core/app_configs.dart';
import 'package:schedule_qu/data/models/collection_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalProvider {
  CollectionModel? getCollectionModel();
  Future<void> saveCollection(CollectionModel collection);
}

class UserLocalProviderImpl extends UserLocalProvider {
  final SharedPreferences prefs;

  UserLocalProviderImpl({required this.prefs});

  @override
  Future<void> saveCollection(CollectionModel collection) async {
    await prefs.setString(
      AppConfigs.keySubCollection,
      jsonEncode(
        collection.toJson(),
      ),
    );
  }

  @override
  CollectionModel? getCollectionModel() {
    String? json = prefs.getString(AppConfigs.keySubCollection);
    return json != null ? CollectionModel.fromJson(jsonDecode(json)) : null;
  }
}
