import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/sessions_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/settings_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/statistics_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_bottom_navigation.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IndexedStack(
                    key: const PageStorageKey('Indexed'),
                    index: state.index,
                    children: [
                      const SessionsPage(),
                      const StatisticsPage(),
                      const SettingsPage(),
                    ],
                  ),
                  const Positioned(
                    bottom: 20,
                    child: CustomBottomNavigation(),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
