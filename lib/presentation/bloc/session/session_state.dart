part of 'session_cubit.dart';

class SessionState extends Equatable {
  final Session? session;
  final bool isActive;

  const SessionState({this.session, this.isActive = false});

  @override
  List<Object?> get props => [isActive, session];

  SessionState copyWith({
    Session? session,
    bool? isActive,
  }) {
    return SessionState(
      session: session ?? this.session,
      isActive: isActive ?? this.isActive,
    );
  }
}
