import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/game.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/sessions/sessions_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_button.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_text_field.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/default_adding_page.dart';

class SessionAddGamePage extends StatefulWidget {
  const SessionAddGamePage({Key? key}) : super(key: key);

  @override
  State<SessionAddGamePage> createState() => _SessionAddGamePageState();
}

class _SessionAddGamePageState extends State<SessionAddGamePage> {
  final TextEditingController saveGameNameController = TextEditingController();
  final TextEditingController gameNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController amountBeginController = TextEditingController();
  final TextEditingController amountEndController = TextEditingController();
  String result = 'amount';
  String amount = 'won';
  List<int>? _image;
  String? imageName;
  Game? setGame;
  double currentAmount = 0;

  @override
  void initState() {
    Session? session = context.read<SessionCubit>().state.session;
    currentAmount = context.read<SettingsCubit>().state.getActualPrice(session!.balance + session.profit());
    super.initState();
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    imageName = image!.name.split('.').first;
    _image = await image.readAsBytes();
    setState(() {
      // Navigator.pop(this.context);
    });
  }

  Future getCameraImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    imageName = image!.name.split('.').first;
    _image = await image.readAsBytes();
    setState(() {
      // Navigator.pop(this.context);
    });
  }

  void setGameFromSaved(Game newGame) {
    setState(() {
      setGame = newGame;
      imageName = setGame!.imageName;
      _image = setGame!.imageBytes;
      gameNameController.text = setGame!.name;
      saveGameNameController.text = setGame!.name;
    });
  }

  void openCameraBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 50,
                child: Container(
                  height: 2,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      getCameraImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            'Take the picture',
                            style: AppTextStyles.font14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.photo_camera,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      getImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            'Choose the photo',
                            style: AppTextStyles.font14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.photo_camera_back,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  void openGamesBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 50,
                child: Container(
                  height: 2,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: BlocBuilder<SessionsCubit, SessionsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          for (var game in state.games) ... [
                            InkWell(
                              onTap: () {
                                setGameFromSaved(game);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      game.name,
                                      style: AppTextStyles.font14.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (setGame != null && setGame!.name == game.name)
                                      const Icon(
                                        Icons.check,
                                        color: AppColors.black,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ],
                      );
                    }
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAddingPage(
      title: 'Game adding',
      onConfirm: () {
        var settingsCubit = context.read<SettingsCubit>();
        double? profit;
        if (result == 'amount' && amountController.text.isNotEmpty) {
          profit =
              double.parse(amountController.text) * (amount == 'won' ? 1 : -1);
        }
        if (result == 'calculate' &&
            amountBeginController.text.isNotEmpty &&
            amountEndController.text.isNotEmpty) {
          profit = double.parse(amountEndController.text) -
              double.parse(amountBeginController.text);
        }
        if (gameNameController.text.isEmpty || profit == null) {
          showDialogForEmptyFields(context, 'Please fill all fields',
              'You can not create game with empty fields');
        } else {
          var profitToUsd = settingsCubit.state.priceToUsd(profit);
          var currentAmountToUsd = settingsCubit.state.priceToUsd(currentAmount);
          if (currentAmountToUsd + profitToUsd < 0) {
            showDialogForEmptyFields(context, 'Please change amounts',
                'You lost ${settingsCubit.getPrice(profitToUsd.abs())}, but you have now only ${settingsCubit.getPrice(currentAmountToUsd.abs())}');
          } else {
            context
                .read<SessionCubit>()
                .addGame(gameNameController.text, _image ?? [], imageName ?? '', profitToUsd);
            Navigator.pop(context);
          }
        }
      },
      widgets: Column(
        children: [
          BlocBuilder<SessionsCubit, SessionsState>(
            builder: (context, state) {
              return state.games.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saved games',
                                style: AppTextStyles.font16.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomTextField(
                                controller: saveGameNameController,
                                hintText: 'Casino Royal',
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.black,
                                ),
                                onTap: openGamesBottomSheet,
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    )
                  : const SizedBox.shrink();
            }
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Game name',
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    if (imageName == null) ...[
                      InkWell(
                        onTap: openCameraBottomSheet,
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_camera,
                              color: AppColors.mainBlue,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Add photo',
                              style: AppTextStyles.font16.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: Text(
                          imageName!,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font16.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainBlue,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: gameNameController,
                  hintText: 'Roulette',
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Result',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: 'Amount',
                        isSmall: true,
                        isActive: result == 'amount',
                        onTap: () {
                          setState(() {
                            result = 'amount';
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomButton(
                        title: 'Calculate',
                        isSmall: true,
                        isActive: result == 'calculate',
                        onTap: () {
                          setState(() {
                            result = 'calculate';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          if (result == 'amount') ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Won',
                          isSmall: true,
                          isActive: amount == 'won',
                          onTap: () {
                            setState(() {
                              amount = 'won';
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomButton(
                          title: 'Lost',
                          isSmall: true,
                          isActive: amount == 'lost',
                          onTap: () {
                            setState(() {
                              amount = 'lost';
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: BlocBuilder<SettingsCubit, SettingsState>(
                          builder: (context, state) {
                            return CustomTextField(
                              controller: amountController,
                              hintText: '${state.getCurrencyCode()}1000',
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                              textInputFormatters: [
                                DecimalTextInputFormatter(),
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
          ] else ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount in the beginning',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return CustomTextField(
                        controller: amountBeginController,
                        hintText: '${state.getCurrencyCode()}1000',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        textInputFormatters: [
                          DecimalTextInputFormatter(),
                        ],
                      );
                    }
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount at the end',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return CustomTextField(
                        controller: amountEndController,
                        hintText: '${state.getCurrencyCode()}1000',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        textInputFormatters: [
                          DecimalTextInputFormatter(),
                        ],
                      );
                    }
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
