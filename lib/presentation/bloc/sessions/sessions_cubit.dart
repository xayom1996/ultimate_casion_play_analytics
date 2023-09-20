import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/game.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(const SessionsState());

  void initDb() async {
    var box = await Hive.openBox('testBox');
    if (box.get('sessions') != null) {
      List<Session> sessions = box
          .get('sessions')
          .map<Session>((e) => Session.fromJson(jsonDecode(jsonEncode(e))))
          .toList();
      List<Game> games = [];
      for (var session in sessions) {
        for (var game in session.games ?? []) {
          int idx = games.indexWhere((element) => element.name == game.name);
          if (idx == -1) {
            games.add(game);
          }
        }
      }
      print(games);
      emit(state.copyWith(
        sessions: sessions,
        games: games,
      ));
    }
  }

  void addSession(Session session) async {
    List<Session> sessions = state.sessions.map((session) => session).toList();
    int newId = 0;
    if (sessions.isNotEmpty) {
      newId = sessions.last.id + 1;
    }

    sessions.add(session.copyWith(id: newId));

    var box = await Hive.openBox('testBox');
    box.put('sessions', sessions.map((e) => e.toJson()).toList());

    emit(state.copyWith(
      sessions: sessions,
    ));
  }

  void changePeriod(String period) {
    DateTime periodDate = DateTime.now();
    var now = DateTime.now();
    if (period == 'Today') {
      periodDate = now.subtract(const Duration(days: 1));
    } else if (period == 'Yesterday') {
      periodDate = now.subtract(const Duration(days: 2));
    } else if (period == 'Week') {
      periodDate = DateTime.now().subtract(const Duration(days: 8));
    } else if (period == 'Month') {
      periodDate = DateTime.now().subtract(const Duration(days: 32));
    }

    List<Session> newSession = [];
    for (final session in state.sessions) {
      DateTime sessionDate = DateFormat('dd.MM.yyyy').parse(session.date);
      if (sessionDate.isAfter(periodDate) || sessionDate.isAtSameMomentAs(periodDate)) {
        newSession.add(session);
      }
    }

    emit(state.copyWith(
      period: period,
      sessionsFromPeriod: period != 'All time'
          ? newSession
          : state.sessions,
    ));
  }
}
