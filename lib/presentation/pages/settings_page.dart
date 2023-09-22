import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/constants.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your currency',
                        style: AppTextStyles.font16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var currency in currencies) ...[
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<SettingsCubit>()
                                        .changeCurrency(currency);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(29)),
                                      color: state.currency == currency
                                          ? AppColors.miniBlack
                                          : AppColors.white,
                                    ),
                                    child: FittedBox(
                                      child: Center(
                                        child: Text(currency,
                                            style: AppTextStyles.font14.copyWith(
                                              color: state.currency == currency
                                                  ? AppColors.white
                                                  : AppColors.miniBlack,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 22),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Row(
                          children: [
                            const AppSvgAssetIcon(asset: AppIcons.share),
                            const SizedBox(width: 8),
                            Text(
                              'Share App',
                              style: AppTextStyles.font16.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 22),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Row(
                          children: [
                            const AppSvgAssetIcon(asset: AppIcons.privacyPolicy),
                            const SizedBox(width: 8),
                            Text(
                              'Privacy Policy',
                              style: AppTextStyles.font16.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 22),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Row(
                          children: [
                            const AppSvgAssetIcon(asset: AppIcons.questionMark),
                            const SizedBox(width: 8),
                            Text(
                              'Terms of use',
                              style: AppTextStyles.font16.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 22),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Row(
                          children: [
                            const AppSvgAssetIcon(asset: AppIcons.support),
                            const SizedBox(width: 8),
                            Text(
                              'Support',
                              style: AppTextStyles.font16.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
