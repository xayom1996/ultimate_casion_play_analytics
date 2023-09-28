part of 'settings_cubit.dart';

enum SettingsStatus {
  initial,
  initDb,
  changed,
}

class SettingsState extends Equatable {
  final String currency;
  final double balance;
  final SettingsStatus status;
  final double dollarRatio;

  const SettingsState({
    this.currency = '',
    this.balance = 0,
    this.dollarRatio = 1,
    this.status = SettingsStatus.initial,
  });

  @override
  List<Object> get props => [currency, balance, status];

  String getCurrencyCode() {
    return currency.split(' ').first;
  }

  double getActualPrice(double price) {
    if (-1 < price * dollarRatio && price * dollarRatio < 1) {
      return 0;
    }
    return price * dollarRatio;
  }

  double priceToUsd(double price) {
    return price / dollarRatio;
  }

  SettingsState copyWith({
    String? currency,
    double? balance,
    String? afterSign,
    bool? hasSign,
    SettingsStatus? status,
    double? dollarRatio,
  }) {
    return SettingsState(
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      dollarRatio: dollarRatio ?? this.dollarRatio,
    );
  }
}
