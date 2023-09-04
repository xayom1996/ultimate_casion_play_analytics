import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/di/app_module.dart';

Future<void> injectDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
}
