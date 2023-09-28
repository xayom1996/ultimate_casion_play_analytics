import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/constants.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/line_chart.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/statistics_game_container.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  int getCountGames(List<Session> sessionsFromPeriod) {
    if (sessionsFromPeriod.isEmpty) {
      return 0;
    }
    return (countGames(sessionsFromPeriod) / sessionsFromPeriod.length).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return BlocBuilder<SessionsCubit, SessionsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 44,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: statisticPeriods.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 20 : 0,
                                right: 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<SessionsCubit>().changePeriod(statisticPeriods[index]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(40)),
                                    color: state.period != statisticPeriods[index]
                                        ? AppColors.white
                                        : AppColors.miniBlack,
                                  ),
                                  child: FittedBox(
                                    child: Center(
                                      child: Text(statisticPeriods[index],
                                          style: AppTextStyles.font14.copyWith(
                                            color: state.period == statisticPeriods[index]
                                              ? AppColors.white
                                              : AppColors.miniBlack,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.all(Radius.circular(19))),
                          child: LineChartSample2(
                            data: state.getPeriodData(),
                            spots: state.spots,
                            maxY: state.maxY,
                            lastBalance: state.lastBalance,
                            percentDifference: state.percentDifference,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          decoration: const BoxDecoration(
                            color: AppColors.mainBlue,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.read<SettingsCubit>().profitToString(sessionsProfit(state.sessionsFromPeriod)),
                                style: AppTextStyles.font24.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Result',
                                style: AppTextStyles.font16.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.sessionsFromPeriod.length.toString(),
                                      style: AppTextStyles.font24,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Sessions',
                                      style: AppTextStyles.font16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      countGames(state.sessionsFromPeriod).toString(),
                                      style: AppTextStyles.font24,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Games',
                                      style: AppTextStyles.font16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Average per session',
                                    style: AppTextStyles.font16,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '${getCountGames(state.sessionsFromPeriod)} games',
                                    style: AppTextStyles.font24,
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Image.asset(
                                "assets/images/average_per_session_image.png",
                                alignment: Alignment.bottomRight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Games',
                              style: AppTextStyles.font20,
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            for (var game in statisticsGames(state.sessionsFromPeriod))
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.0),
                                child: StatisticsGameContainer(
                                  title: game['name'],
                                  description: '${game['count']} times played',
                                  profit: context.read<SettingsCubit>().profitToString(game['profit']),
                                  image: game['image'],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}
