import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_add_game_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_button.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/game_container.dart';

class SessionDetailPage extends StatelessWidget {
  final Session session;
  const SessionDetailPage({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Session',
                            style: AppTextStyles.font32.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(54)),
                              color: AppColors.mainBlue,
                            ),
                            child: Center(
                              child: Text(
                                profitToString(session.balance + session.profit()),
                                style: AppTextStyles.font12.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              color: AppColors.miniBlack,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: AppColors.white,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  printDuration(
                                      Duration(seconds: session.spendTimeInSeconds)),
                                  style: AppTextStyles.font16.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      if (session.games!.isNotEmpty)
                        for (var i = 0;
                        i < session.games!.length;
                        i++) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GameContainer(
                              title: session.games![i].name,
                              profit: session.games![i].profit ?? 0,
                              imageBytes: session.games![i].imageBytes,
                              time:
                              session.games![i].timeInSeconds ?? 0,
                            ),
                          ),
                        ],
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: CustomButton(
                  title: 'Back',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
