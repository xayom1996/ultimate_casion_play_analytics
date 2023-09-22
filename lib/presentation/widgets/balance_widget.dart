import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';

class BalanceWidget extends StatelessWidget {
  final double balance;
  final String afterSign;
  final bool hasSign;
  final bool isEditingPage;

  const BalanceWidget({Key? key,
    required this.balance,
    required this.afterSign,
    required this.hasSign,
    this.isEditingPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: isEditingPage == true
              ? simpleFormatPrice(balance.floorToDouble())
              : context.read<SettingsCubit>().getPrice(balance),
          style: AppTextStyles.font32.copyWith(
            color: balance == 0
                ? AppColors.gray
                : AppColors.miniBlack,
          ),
          children: isEditingPage == true
            ? [
                TextSpan(
                  text: ',',
                  style: AppTextStyles.font32.copyWith(
                    color: hasSign == false
                        ? AppColors.gray
                        : AppColors.miniBlack,
                  ),
                ),
                TextSpan(
                  text: afterSign.isEmpty ? '0' : afterSign[0],
                  style: AppTextStyles.font32.copyWith(
                    color: afterSign.isEmpty
                        ? AppColors.gray
                        : AppColors.miniBlack,
                  ),
                ),
                TextSpan(
                  text: afterSign.length <= 1 ? '0' : afterSign[1],
                  style: AppTextStyles.font32.copyWith(
                    color: afterSign.length <= 1
                        ? AppColors.gray
                        : AppColors.miniBlack,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
