part of 'settings_cubit.dart';

enum SettingsStatus {
  initial,
  initDb,
  changed,
}

class SettingsState extends Equatable {
  final String currency;
  final double balance;
  final String afterSign;
  final bool hasSign;
  final SettingsStatus status;

  const SettingsState({
    this.currency = '',
    this.balance = 0,
    this.afterSign = '',
    this.hasSign = false,
    this.status = SettingsStatus.initial,
  });

  @override
  List<Object> get props => [currency, balance, afterSign, hasSign, status];

  SettingsState copyWith({
    String? currency,
    double? balance,
    String? afterSign,
    bool? hasSign,
    SettingsStatus? status,
  }) {
    return SettingsState(
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      afterSign: afterSign ?? this.afterSign,
      hasSign: hasSign ?? this.hasSign,
      status: status ?? this.status,
    );
  }
}
