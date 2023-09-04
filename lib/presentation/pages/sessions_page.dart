import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_creation_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/session_history_container.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
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
                        Text(
                          '\$ 1 000,34',
                          style: AppTextStyles.font32,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SessionCreationPage()));
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
                Container(
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
                          borderRadius: BorderRadius.all(Radius.circular(64)),
                        ),
                        child: const AppSvgAssetIcon(
                          asset: AppIcons.dice,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Active session',
                                style: AppTextStyles.font16.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                'Today 22:00',
                                style: AppTextStyles.font12.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
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
                const SizedBox(
                  height: 20,
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
                    for (var i = 0; i < 10; i++)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: SessionHistoryContainer(
                          title: 'Casino',
                          date: '22.04.2023',
                          time: '1:30:30',
                          profit: '+\$100',
                        ),
                      ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
