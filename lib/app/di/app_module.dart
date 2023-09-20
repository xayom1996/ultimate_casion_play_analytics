import 'package:get_it/get_it.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';


final getIt = GetIt.instance;

void initDependencies() {
  // Repositories

  // Data sources

  // BLoCs
  getIt.registerFactory(() => NavigationCubit());
  getIt.registerFactory(() => SettingsCubit());
  getIt.registerFactory(() => SessionCubit());
  getIt.registerFactory(() => SessionsCubit());
  // SettingsCubit
}
