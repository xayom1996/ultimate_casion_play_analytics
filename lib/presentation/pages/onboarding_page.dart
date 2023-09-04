import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/constants.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/root_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: AppColors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  children: [
                    DisclaimerPage(
                      onTap: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    CheckCurrencyPage(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RootPage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisclaimerPage extends StatelessWidget {
  final Function() onTap;

  const DisclaimerPage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/onboarding_image.png',
            height: 159,
            width: 159,
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            'We are not a casino!',
            style: AppTextStyles.font24,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '''
            You can not play any real money games here!
            We only provide a tool for recording your statistics in the casino. We encourage you to play responsibly and only where it is legal to do so.
            ''',
            style: AppTextStyles.font14.copyWith(
              color: AppColors.miniBlack.withOpacity(0.55),
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          CustomButton(
            title: 'Next',
            onTap: onTap,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Privacy Policy',
                style: AppTextStyles.font12
                    .copyWith(color: AppColors.miniBlack.withOpacity(0.4)),
              ),
              Text(
                'Terms & Conditions',
                style: AppTextStyles.font12
                    .copyWith(color: AppColors.miniBlack.withOpacity(0.4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckCurrencyPage extends StatelessWidget {
  final Function() onTap;

  const CheckCurrencyPage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Please choose your currency',
              style: AppTextStyles.font24,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var currency in currencies.getRange(0, 3)) ...[
                    GestureDetector(
                      onTap: () {
                        context.read<SettingsCubit>().changeCurrency(currency);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 23),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(29)),
                            color: state.currency == currency
                                ? AppColors.miniBlack
                                : AppColors.inActiveCurrencyColor,
                          ),
                          child: Center(
                            child: Text(currency,
                                style: AppTextStyles.font16.copyWith(
                                  color: state.currency == currency
                                      ? AppColors.white
                                      : AppColors.miniBlack,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var currency in currencies.getRange(3, 5)) ...[
                    GestureDetector(
                      onTap: () {
                        context.read<SettingsCubit>().changeCurrency(currency);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 23),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(29)),
                            color: state.currency == currency
                                ? AppColors.miniBlack
                                : AppColors.inActiveCurrencyColor,
                          ),
                          child: Center(
                            child: Text(currency,
                                style: AppTextStyles.font16.copyWith(
                                  color: state.currency == currency
                                      ? AppColors.white
                                      : AppColors.miniBlack,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ]),
            const Spacer(),
            CustomButton(
              title: 'Confirm',
              onTap: onTap,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Privacy Policy',
                  style: AppTextStyles.font12
                      .copyWith(color: AppColors.miniBlack.withOpacity(0.4)),
                ),
                Text(
                  'Terms & Conditions',
                  style: AppTextStyles.font12
                      .copyWith(color: AppColors.miniBlack.withOpacity(0.4)),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
