import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';

class CustomButton extends StatelessWidget {
  final AppSvgAssetIcon? icon;
  final String title;
  final Function() onTap;
  final bool? isSmall;
  final bool? isActive;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.icon,
    this.isSmall = false,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isSmall == true ? 12 : 20),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(isSmall == true ? 40 : 29)),
          color: icon == null
              ? isActive == true
                ? AppColors.miniBlack
                : AppColors.inActiveButtonColor
              : AppColors.mainBlue.withOpacity(0.10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: icon,
              ),
            Text(
              title,
              style: AppTextStyles.font14.copyWith(
                fontWeight: isSmall == true
                    ? FontWeight.w400
                    : FontWeight.w600,
                color: icon == null
                    ? isActive == true
                      ? AppColors.white
                      : AppColors.miniBlack
                    : AppColors.mainBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
