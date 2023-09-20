import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const Color mainBlue = Color(0xff3D52D5);
  static const Color mainBlack = Color(0xff383F49);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color gray = Color(0xffA9AEBD);
  static const Color miniBlack = Color(0xff121212);
  static const Color inActiveCurrencyColor = Color(0xffEEF0F3);
  static const Color inActiveButtonColor = Color(0xffEEF0F3);
  static const Color backgroundPageColor = Color(0xffF0F2F8);
  static const Color dollarColor = Color(0xff49B790);
}


class AppTextStyles {
  const AppTextStyles();

  static TextStyle get font12 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.miniBlack,
  );

  static TextStyle get font14 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.miniBlack,
  );

  static TextStyle get font16 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.miniBlack,
  );

  static TextStyle get font20 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.miniBlack,
  );

  static TextStyle get font24 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.miniBlack,
  );

  static TextStyle get font32 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.miniBlack,
  );

  static TextStyle get font40 => const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: AppColors.miniBlack,
  );
}

