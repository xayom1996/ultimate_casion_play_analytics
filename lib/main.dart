import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/di/app_module.dart';
import 'package:ultimate_casino_play_analytics/app/di/inject.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/root_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_creation_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/sessions_page.dart';

import 'presentation/pages/onboarding_page.dart';

void main() async {
  // Initialize dependencies before running the app
  await injectDependencies();

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
          create: (_) => getIt.get<SettingsCubit>(),
        ),
        BlocProvider<NavigationCubit>(
          create: (_) => getIt.get<NavigationCubit>(),
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
