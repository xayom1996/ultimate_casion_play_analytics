import 'package:flutter/material.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';

class DefaultAddingPage extends StatelessWidget {
  final String title;
  final Function() onConfirm;
  final Widget widgets;
  final bool? isCentered;

  const DefaultAddingPage(
      {Key? key,
      required this.widgets,
      required this.title,
      this.isCentered = false,
      required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
          ),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font16.copyWith(
                          color: AppColors.mainBlue,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font16.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onConfirm,
                      child: Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font16.copyWith(
                          color: AppColors.mainBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            if (isCentered == true)
              const Spacer(flex: 1),
            widgets,
            if (isCentered == true)
              const Spacer(flex: 1),
          ],
        ),
      ),
    ));
  }
}
