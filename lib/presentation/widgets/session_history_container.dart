import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';

class SessionHistoryContainer extends StatelessWidget {
  final Session session;

  const SessionHistoryContainer(
      {Key? key, required this.session,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 14),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 57,
            width: 57,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(57)),
              color: Color(0xffF4F4F4),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  'assets/images/onboarding_image.png',
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      session.casinoName,
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '(${session.date})',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      profitToString(session.profit()),
                      style: AppTextStyles.font16.copyWith(
                        color: AppColors.dollarColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColors.gray,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      printDuration(
                          Duration(seconds: session.spendTimeInSeconds)),
                      style: AppTextStyles.font12.copyWith(
                        color: AppColors.gray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${session.balance} -> \$${session.balance + session.profit()}',
                      style: AppTextStyles.font12.copyWith(
                        color: AppColors.gray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
