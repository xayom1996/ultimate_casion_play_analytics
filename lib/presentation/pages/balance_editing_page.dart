import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:ultimate_casino_play_analytics/presentation/bloc/settings/settings_cubit.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/balance_widget.dart';
import 'package:ultimate_casino_play_analytics/presentation/widgets/default_adding_page.dart';

class BalanceEditingPage extends StatefulWidget {
  const BalanceEditingPage({Key? key}) : super(key: key);

  @override
  State<BalanceEditingPage> createState() => _BalanceEditingPageState();
}

class _BalanceEditingPageState extends State<BalanceEditingPage> {
  double balance = 0;
  String afterSign = '';
  bool hasSign = false;

  final FocusNode focusNode = FocusNode();
  late TextEditingController controller;

  @override
  void didChangeDependencies() {
    balance = context.read<SettingsCubit>().state.balance * context.read<SettingsCubit>().state.dollarRatio;
    afterSign = afterPriceSign(balance);
    hasSign = hasPriceSign(balance);
    controller = TextEditingController(
        text: balance == 0 ? '0' : balance.toStringAsFixed(2));
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);

    FocusScope.of(context).requestFocus(focusNode);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return DefaultAddingPage(
          title: 'Balance editing',
          onConfirm: () {
            context.read<SettingsCubit>().changeBalance(balance);
            Navigator.pop(context);
          },
          isCentered: true,
          widgets: IntrinsicWidth(
            child: Column(
              children: [
                Text(
                  'Equals to ${state.getCurrencyCode()}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 0,
                  height: 0,
                  child: TextField(
                    focusNode: focusNode,
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputFormatters: [
                      DecimalTextInputFormatter(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value == '') {
                          balance = 0;
                        } else {
                          balance = double.parse(value);
                        }
                        if (value.contains('.')) {
                          afterSign = value.split('.').last;
                          hasSign = true;
                        } else {
                          afterSign = '';
                          hasSign = false;
                        }
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  child: BalanceWidget(
                    balance: balance,
                    afterSign: afterSign,
                    hasSign: hasSign,
                    isEditingPage: true,
                  ),
                ),
                const Divider(
                  color: AppColors.mainBlue,
                  thickness: 2,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
