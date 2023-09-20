part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final List<Session> sessions;
  final List<Session> sessionsFromPeriod;
  final List<Game> games;
  final String period;

  const SessionsState({
    this.sessions = const [],
    this.sessionsFromPeriod = const [],
    this.games = const [],
    this.period = 'All time',
  });

  @override
  List<Object> get props => [sessions, sessionsFromPeriod, games, period];

  SessionsState copyWith({
    List<Session>? sessions,
    List<Session>? sessionsFromPeriod,
    List<Game>? games,
    String? period,
  }) {
    return SessionsState(
      sessions: sessions ?? this.sessions,
      sessionsFromPeriod: sessionsFromPeriod ?? this.sessionsFromPeriod,
      games: games ?? this.games,
      period: period ?? this.period,
    );
  }
}