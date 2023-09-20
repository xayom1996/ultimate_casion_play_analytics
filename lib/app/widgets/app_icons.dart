import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const AppSvgAsset dice = AppSvgAsset('assets/icons/dice.svg');
  static const AppSvgAsset arrowRight = AppSvgAsset('assets/icons/arrow_right.svg');
  static const AppSvgAsset roundedPlus = AppSvgAsset('assets/icons/rounded_plus.svg');
  static const AppSvgAsset privacyPolicy = AppSvgAsset('assets/icons/privacy_policy.svg');
  static const AppSvgAsset questionMark = AppSvgAsset('assets/icons/question_mark.svg');
  static const AppSvgAsset share = AppSvgAsset('assets/icons/share.svg');
  static const AppSvgAsset support = AppSvgAsset('assets/icons/support.svg');
  static const AppSvgAsset statistics = AppSvgAsset('assets/icons/statistics.svg');
  static const AppSvgAsset sessions = AppSvgAsset('assets/icons/sessions.svg');
  static const AppSvgAsset settings = AppSvgAsset('assets/icons/settings.svg');
  static const AppSvgAsset star = AppSvgAsset('assets/icons/star.svg');
  static const AppSvgAsset pause = AppSvgAsset('assets/icons/pause.svg');
  static const AppSvgAsset play = AppSvgAsset('assets/icons/play.svg');
  static const AppSvgAsset check = AppSvgAsset('assets/icons/check.svg');
}

class AppSvgAsset{
  final String path;

  const AppSvgAsset(this.path);
}

class AppSvgAssetIcon extends StatelessWidget {
  final AppSvgAsset asset;
  final Color? color;
  final double? width;
  final double? height;

  const AppSvgAssetIcon({Key? key,
    required this.asset,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset.path,
      color: color,
      width: width,
      height: height,
    );
  }
}

class AppSvgAssetImage extends AppSvgAssetIcon {
  const AppSvgAssetImage({Key? key,
  required super.asset,
  super.color,
  super.width,
  super.height,
}) : super(key: key);
}
