import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:schedule_qu/core/firebase_options.dart';
import 'package:schedule_qu/dependency_Injection.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DependencyInjection.init();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}
