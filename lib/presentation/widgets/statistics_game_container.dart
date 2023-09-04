import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';

class StatisticsGameContainer extends StatelessWidget {
  final String title;
  final String description;
  final String profit;

  const StatisticsGameContainer(
      {Key? key,
      required this.title,
      required this.description,
      required this.profit})
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: AppTextStyles.font16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                description,
                style: AppTextStyles.font12.copyWith(
                  color: const Color(0xffB1B1B1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                profit,
                style: AppTextStyles.font16.copyWith(
                  color: AppColors.dollarColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}