import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/balance_editing_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_creation_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_detail_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/balance_widget.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/session_history_container.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return BlocBuilder<SessionsCubit, SessionsState>(
              builder: (context, sessionsState) {
                return BlocBuilder<SessionCubit, SessionState>(
                  builder: (context, sessionState) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your Balance',
                                      style: AppTextStyles.font16.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.gray,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BalanceEditingPage()));
                                      },
                                      child: BlocBuilder<SettingsCubit, SettingsState>(
                                          builder: (context, state) {
                                        return BalanceWidget(
                                          balance: state.balance,
                                          afterSign: afterPriceSign(state.getActualPrice(state.balance)),
                                          hasSign: hasPriceSign(state.getActualPrice(state.balance)),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (sessionState.isActive == false) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const SessionCreationPage()));
                                    } else {
                                      showDialogForEmptyFields(
                                          context,
                                          'Please end active session',
                                          'You can not create new session when you have active session');
                                    }
                                  },
                                  child: const AppSvgAssetIcon(
                                    asset: AppIcons.roundedPlus,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (sessionState.isActive == false && sessionsState.sessions.isEmpty) ... [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height / 3.5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const AppSvgAssetIcon(
                                        asset: AppIcons.sessions,
                                        color: AppColors.mainBlack,
                                        height: 36,
                                        width: 36,
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        'No sessions created yet',
                                        style: AppTextStyles.font20.copyWith(
                                          color: AppColors.mainBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ] else ... [
                              if (sessionState.isActive == true)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const SessionPage()));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                          color: AppColors.mainBlue,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(0),
                                          )),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: const BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(64)),
                                            ),
                                            child: const AppSvgAssetIcon(
                                              asset: AppIcons.dice,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Active session',
                                                    style:
                                                    AppTextStyles.font16.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    Jiffy.parse(sessionState.session!.date, pattern: 'dd.MM.yyyy').fromNow(),
                                                    style:
                                                    AppTextStyles.font12.copyWith(
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)),
                                                ),
                                                child: const AppSvgAssetIcon(
                                                  asset: AppIcons.arrowRight,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              Text(
                                'Session history',
                                style: AppTextStyles.font20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  for (var session in sessionsState.sessions)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SessionDetailPage(session: session)));
                                        },
                                        child: SessionHistoryContainer(
                                          session: session,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }
                );
              }
            );
          }
        ),
      ),
    );
  }
}
