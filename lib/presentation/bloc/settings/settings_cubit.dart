import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ultimate_casino_play_analytics/app/constants.dart';
import 'package:ultimate_casino_play_analytics/app/utils.dart';
import 'package:http/http.dart' as http;

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

  void changeCurrency(String currency, {SettingsStatus? status = SettingsStatus.changed}) async {
    double newDollarRatio = 1;
    if (currency != '\$ USD') {
      final response = await http.get(Uri.parse(exchangeApiUrl));
      if (response.statusCode == 200) {
        try {
          String currencyCode = currency
              .split(' ')
              .last;
          var body = json.decode(response.body) as Map<String, dynamic>;
          newDollarRatio = body['data'][currencyCode].toDouble();
        } catch (_) {
          newDollarRatio = 1;
        }
      }
    }

    emit(state.copyWith(
      currency: currency,
      status: status,
      dollarRatio: newDollarRatio,
    ));

    saveToDb();
  }

  void changeBalance(double balance, {SettingsStatus? status = SettingsStatus.changed}) async {
    emit(state.copyWith(
      balance: balance,
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

  String getPrice(double price) {
    String currencySign = state.currency.split(' ').first;
    return '$currencySign${formatPrice(state.getActualPrice(price))}';
  }

  String profitToString(double profit) {
    return '${profit > 0 ? '+' : profit != 0 ? '-' : ''}${getPrice(profit.abs())}';
  }
}
