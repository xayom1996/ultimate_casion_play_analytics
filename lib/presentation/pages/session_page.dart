import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/app/widgets/app_icons.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_add_game_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_button.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/game_container.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  int spendTimeInSeconds = 0;
  Timer? timer;
  bool isActive = false;

  @override
  void initState() {
    getFromDb();
    startTimer();
    super.initState();
  }

  void getFromDb() async {
    var box = await Hive.openBox('testBox');
    var session = box.get('session');
    if (session != null) {
      setState(() {
        spendTimeInSeconds = session['spendTimeInSeconds'];
      });
    }
  }

  void startTimer() {
    setState(() {
      isActive = true;
      timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          spendTimeInSeconds += 1;
        });
        context.read<SessionCubit>().saveDb(spendTimeInSeconds);
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isActive = false;
      if (timer != null) {
        timer!.cancel();
      }
    });
  }

  void endSession() {
    if (timer == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        if (timer != null) {
          Session session = context.read<SessionCubit>().state.session!;
          context.read<SessionsCubit>().addSession(session);
          context.read<SessionCubit>().endSession();
          context.read<SettingsCubit>().changeBalance(
            session.balance + session.profit(),
          );
          timer!.cancel();
          timer = null;
        }
      });
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<SessionCubit, SessionState>(
                  builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Session',
                              style: AppTextStyles.font32.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            if (isActive == false)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(54)),
                                  color: AppColors.mainBlue,
                                ),
                                child: Center(
                                  child: Text(
                                    profitToString(state.session!.balance + state.session!.profit()),
                                    style: AppTextStyles.font12.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: AppColors.miniBlack,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: AppColors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    printDuration(
                                        Duration(seconds: spendTimeInSeconds)),
                                    style: AppTextStyles.font16.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        if (state.session!.games!.isNotEmpty)
                          for (var i = 0;
                              i < state.session!.games!.length;
                              i++) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GameContainer(
                                title: state.session!.games![i].name,
                                profit: state.session!.games![i].profit ?? 0,
                                imageBytes: state.session!.games![i].imageBytes,
                                time:
                                    state.session!.games![i].timeInSeconds ?? 0,
                              ),
                            ),
                          ],
                        const SizedBox(
                          height: 26,
                        ),
                        if (timer != null && isActive == true)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SessionAddGamePage()));
                            },
                            child: DottedBorder(
                              color: Colors.black,
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              padding: const EdgeInsets.all(36),
                              radius: const Radius.circular(24),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: AppColors.miniBlack,
                                      size: 24,
                                    ),
                                    Text(
                                      'Add game',
                                      style: AppTextStyles.font20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            if (timer != null)
              Positioned(
                bottom: 106,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: CustomButton(
                    icon: AppSvgAssetIcon(
                      asset: isActive ? AppIcons.pause : AppIcons.play,
                    ),
                    title: isActive ? 'Pause' : 'Continue',
                    onTap: () {
                      if (isActive == true) {
                        pauseTimer();
                      } else {
                        startTimer();
                      }
                    },
                  ),
                ),
              ),
            Positioned(
              bottom: 32,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: CustomButton(
                  title: timer != null ? 'End Session' : 'Back',
                  onTap: endSession,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
