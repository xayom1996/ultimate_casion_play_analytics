part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final String currency;

  const SettingsState({
    this.currency = '',
  });

  @override
  List<Object> get props => [currency];

  SettingsState copyWith({
    String? currency,
  }) {
    return SettingsState(
      currency: currency ?? this.currency,
    );
  }
}
