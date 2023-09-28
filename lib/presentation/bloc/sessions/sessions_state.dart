part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final List<Session> sessions;
  final List<Session> sessionsFromPeriod;
  final List<Game> games;
  final String period;
  final Map<int, double> spots;
  final double maxY;
  final double lastBalance;
  final double percentDifference;

  const SessionsState({
    this.sessions = const [],
    this.sessionsFromPeriod = const [],
    this.games = const [],
    this.period = '',
    this.spots = const {},
    this.maxY = 0,
    this.lastBalance = 0,
    this.percentDifference = 0,
  });

  @override
  List<Object> get props => [sessions, sessionsFromPeriod, games, period, spots, maxY, lastBalance, percentDifference];

  Map<String, dynamic> getPeriodData() {
    if (period == 'Today') {
      return {'lines': [DateFormat('dd.MM.yyyy').format(DateTime.now())], 'count': 1};
    } else if (period == 'Yesterday') {
      return {'lines': [DateFormat('dd.MM.yyyy').format(DateTime.now().subtract(const Duration(days: 1)))], 'count': 1};
    } else if (period == 'Week') {
      return weeks;
    } else if (period == 'Month') {
      return days;
    } else {
      return months;
    }
  }

  SessionsState copyWith({
    List<Session>? sessions,
    List<Session>? sessionsFromPeriod,
    List<Game>? games,
    String? period,
    Map<int, double>? spots,
    double? maxY,
    double? lastBalance,
    double? percentDifference,
  }) {
    return SessionsState(
      sessions: sessions ?? this.sessions,
      sessionsFromPeriod: sessionsFromPeriod ?? this.sessionsFromPeriod,
      games: games ?? this.games,
      period: period ?? this.period,
      spots: spots ?? this.spots,
      maxY: maxY ?? this.maxY,
      lastBalance: lastBalance ?? this.lastBalance,
      percentDifference: percentDifference ?? this.percentDifference,
    );
  }
}