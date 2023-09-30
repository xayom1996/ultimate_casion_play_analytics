import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/app/theme/theme.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/game.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r'^\d*(\.\d{0,2})?');
    final String newString = regEx.stringMatch(newValue.text) ?? '';
    return newString == newValue.text ? newValue : oldValue;
  }
}

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r'^([0-9]{2})\.([0-9]{2})\.([0-9]{4})$');
    final String newString = regEx.stringMatch(newValue.text) ?? '';
    return newString == newValue.text ? newValue : oldValue;
  }
}

String formatPrice(num price) {
  return NumberFormat.compact().format(price).replaceAll(',', ' ');
}

String simpleFormatPrice(num price) {
  return NumberFormat().format(price).replaceAll(',', ' ');
}

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

void showDialogForEmptyFields(
    BuildContext context, String title, String description) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "Okay",
                style: AppTextStyles.font16.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff007AFF),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

int countGames(List<Session> sessions) {
  int sum = 0;
  for (var session in sessions) {
    sum += session.games!.length;
  }

  return sum;
}

double sessionsProfit(List<Session> sessions) {
  double profit = 0;
  for (var session in sessions) {
    profit += session.profit();
  }

  return profit;
}

List statisticsGames(List<Session> sessions) {
  Map<String, dynamic> uniqueGames = {};
  for (var session in sessions) {
    for (var game in session.games ?? []) {
      Map<String, dynamic> uniqueGame = {};

      if (uniqueGames.containsKey(game.name)) {
        uniqueGames[game.name]['count'] += 1;
        uniqueGames[game.name]['profit'] += game.profit ?? 0;
      } else {
        uniqueGame['name'] = game.name;
        uniqueGame['image'] = game.imageBytes;
        uniqueGame['profit'] = game.profit;
        uniqueGame['count'] = 1;
        uniqueGames[game.name] = uniqueGame;
      }
    }
  }

  return uniqueGames.values.toList();
}

bool hasPriceSign(double price) {
  String value = max(0, price).toStringAsFixed(2).replaceAll('.00', '');
  return (value.contains('.') && value != '0.00');
}

String afterPriceSign(double price) {
  String value = max(0, price).toStringAsFixed(2).replaceAll('.00', '');
  if (value.contains('.') && value != '0.00') {
    return value.split('.').last;
  } else {
    return '';
  }
}