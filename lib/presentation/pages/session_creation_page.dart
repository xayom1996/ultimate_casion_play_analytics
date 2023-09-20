import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/app/di/app_module.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/session/session_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/pages/session_page.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/custom_text_field.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/default_adding_page.dart';

class SessionCreationPage extends StatefulWidget {
  const SessionCreationPage({Key? key}) : super(key: key);

  @override
  State<SessionCreationPage> createState() => _SessionCreationPageState();
}

class _SessionCreationPageState extends State<SessionCreationPage> {
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd.MM.yyyy').format(DateTime.now()));
  final TextEditingController casinoController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  @override
  void initState() {
    double balance = context.read<SettingsCubit>().state.balance;
    balanceController = TextEditingController(text: balance == 0 ? '': balance.toStringAsFixed(2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAddingPage(
      title: 'Session creation',
      onConfirm: () {
        if (dateController.text.isEmpty ||
            casinoController.text.isEmpty ||
            balanceController.text.isEmpty) {
          showDialogForEmptyFields(context, 'Please fill all fields',
              'You can not create session with empty fields');
        } else {
          context.read<SessionCubit>().addSession(
                dateController.text,
                casinoController.text,
                double.parse(balanceController.text),
              );
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SessionPage()));
        }
      },
      widgets: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: dateController,
                  hintText: 'Date',
                  isDatePicker: true,
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
                  'Casino',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: casinoController,
                  hintText: 'Casino Royal',
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
                  'Balance',
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: balanceController,
                  hintText: '\$1000',
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  textInputFormatters: [
                    DecimalTextInputFormatter(),
                    // TextInputFormatter.withFunction(
                    //       (oldValue, newValue) {
                    //     if (newValue.text.length == 1) {
                    //       if (newValue.text == '\$') {
                    //         return const TextEditingValue(text: '');
                    //       } else {
                    //         return TextEditingValue(
                    //             text: '\$${newValue.text}',
                    //             selection: const TextSelection.collapsed(offset: 2));
                    //       }
                    //     } else {
                    //       return newValue;
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
