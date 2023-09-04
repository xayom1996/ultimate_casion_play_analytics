import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CustomButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          color: AppColors.miniBlack,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.font14.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
