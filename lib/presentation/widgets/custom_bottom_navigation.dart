import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/navigation/navigation_cubit.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            color: AppColors.miniBlack,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  context.read<NavigationCubit>().getNavBarItem(NavbarItem.sessions);
                },
                child: Column(
                  children: [
                    AppSvgAssetIcon(
                      asset: AppIcons.sessions,
                      color: state.navbarItem == NavbarItem.sessions
                        ? AppColors.white
                        : AppColors.gray,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Sessions',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: state.navbarItem == NavbarItem.sessions
                          ? AppColors.white
                          : AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<NavigationCubit>().getNavBarItem(NavbarItem.statistics);
                },
                child: Column(
                  children: [
                    AppSvgAssetIcon(
                      asset: AppIcons.statistics,
                      color: state.navbarItem == NavbarItem.statistics
                        ? AppColors.white
                        : AppColors.gray,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Statistics',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: state.navbarItem == NavbarItem.statistics
                          ? AppColors.white
                          : AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<NavigationCubit>().getNavBarItem(NavbarItem.settings);
                },
                child: Column(
                  children: [
                    AppSvgAssetIcon(
                      asset: AppIcons.settings,
                      color: state.navbarItem == NavbarItem.settings
                        ? AppColors.white
                        : AppColors.gray,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Settings',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: state.navbarItem == NavbarItem.settings
                          ? AppColors.white
                          : AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
