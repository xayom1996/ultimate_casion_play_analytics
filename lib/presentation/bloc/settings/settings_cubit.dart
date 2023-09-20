import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void initDb() async {
    var box = await Hive.openBox('testBox');
    var settings = box.get('settings');
    if (settings != null && settings['currency'] != null) {
      changeCurrency(
        settings['currency'],
        status: SettingsStatus.initDb,
      );
    }
    if (settings != null && settings['balance'] != null) {
      changeBalance(
        settings['balance'],
        status: SettingsStatus.initDb,
      );
    }
    emit(state.copyWith(status: SettingsStatus.initDb));
  }

  void changeCurrency(String currency, {SettingsStatus? status = SettingsStatus.changed}) {
    emit(state.copyWith(
      currency: currency,
      status: status,
    ));

    saveToDb();
  }

  void changeBalance(double balance, {SettingsStatus? status = SettingsStatus.changed}) async {
    String afterSign;
    bool hasSign;

    String value = max(0, balance).toStringAsFixed(2);
    if (value.contains('.') && value != '0.00') {
      afterSign = value.split('.').last;
      hasSign = true;
    } else {
      afterSign = '';
      hasSign = false;
    }

    emit(state.copyWith(
      balance: balance,
      afterSign: afterSign,
      hasSign: hasSign,
      status: status,
    ));

    saveToDb();
  }

  void saveToDb() async {
    var box = await Hive.openBox('testBox');
    box.put('settings', {
      'currency': state.currency,
      'balance': state.balance,
    });
  }
}
