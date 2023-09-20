import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';

class BalanceWidget extends StatefulWidget {
  final double balance;
  final String afterSign;
  final bool hasSign;

  const BalanceWidget({Key? key,
    required this.balance,
    required this.afterSign,
    required this.hasSign,
  }) : super(key: key);

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: '\$',
          style: AppTextStyles.font40.copyWith(
            color: widget.balance == 0
                ? AppColors.gray
                : AppColors.miniBlack,
          ),
          children: [
            TextSpan(
              text: formatPrice(widget.balance.toInt()),
              style: AppTextStyles.font40.copyWith(
                color: widget.balance == 0
                    ? AppColors.gray
                    : AppColors.miniBlack,
              ),
            ),
            TextSpan(
              text: ',',
              style: AppTextStyles.font40.copyWith(
                color: widget.hasSign == false
                    ? AppColors.gray
                    : AppColors.miniBlack,
              ),
            ),
            TextSpan(
              text: widget.afterSign.isEmpty ? '0' : widget.afterSign[0],
              style: AppTextStyles.font40.copyWith(
                color: widget.afterSign.isEmpty
                    ? AppColors.gray
                    : AppColors.miniBlack,
              ),
            ),
            TextSpan(
              text: widget.afterSign.length <= 1 ? '0' : widget.afterSign[1],
              style: AppTextStyles.font40.copyWith(
                color: widget.afterSign.length <= 1
                    ? AppColors.gray
                    : AppColors.miniBlack,
              ),
            ),
          ]
      ),
    );
  }
}
