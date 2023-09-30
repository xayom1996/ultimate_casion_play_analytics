import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ultimate_casino_play_analytics/app/di/app_module.dart';
import 'package:ultimate_casino_play_analytics/app/di/inject.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';

import 'presentation/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Initialize dependencies before running the app
  await injectDependencies();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) => getIt.get<SettingsCubit>()..initDb(),
        ),
        BlocProvider<NavigationCubit>(
          create: (_) => getIt.get<NavigationCubit>(),
        ),
        BlocProvider<SessionCubit>(
          create: (_) => getIt.get<SessionCubit>()..initDb(),
        ),
        BlocProvider<SessionsCubit>(
          create: (_) => getIt.get<SessionsCubit>()..initDb(),
        ),
      ],
      child: MaterialApp(
        title: 'Ultimate Casino Play Analytics',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.backgroundPageColor,
        ),
        home: const OnBoardingPage(), // Replace with your initial screen
      ),
    );
  }
}
