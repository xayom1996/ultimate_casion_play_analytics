import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_casino_play_analytics/app/constants.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/game.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(const SessionsState());

  void createNewSessions() {
    List<Session> sessions = [];
    var dates = [
      '27.09.2023',
      '26.09.2023',
      '25.09.2023',
      '24.09.2023',
      '23.09.2023',
      '10.09.2023',
      '10.08.2023',
      '05.08.2023',
      '01.05.2023',
      '06.03.2023',
    ];
    int id = 0;
    for (var date in dates.reversed) {
      id++;
      int balance = Random().nextInt(1000);
      bool nextBool = Random().nextBool();
      sessions.add(Session(
        id: id,
        date: date,
        casinoName: '121',
        balance: balance.toDouble(),
        spendTimeInSeconds: 500,
        games: [
          Game(
            name: '1212',
            imageName: '',
            imageBytes: [],
            profit: Random().nextInt(balance) * (nextBool ? 1 : -1),
            timeInSeconds: 100,
          ),
        ],
      ));

      id++;
      balance = Random().nextInt(1000);
      nextBool = Random().nextBool();
      sessions.add(Session(
        id: id,
        date: date,
        casinoName: '121',
        balance: balance.toDouble(),
        spendTimeInSeconds: 500,
        games: [
          Game(
            name: '1212',
            imageName: '',
            imageBytes: [],
            profit: Random().nextInt(balance) * (nextBool ? 1 : -1),
            timeInSeconds: 100,
          ),
        ],
      ));
    }
    emit(state.copyWith(
      sessions: sessions,
      games: [],
    ));
    changePeriod(state.period);
  }

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
      emit(state.copyWith(
        sessions: sessions,
        games: games,
      ));
      changePeriod(state.period);
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
    changePeriod(state.period);
  }

  void changePeriod(String period) {
    DateTime periodDate = DateTime.now();
    var now = DateTime.now();
    Map<int, double> spots = {};
    double maxY = 0;

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
      if (period == 'Today') {
        if (DateFormat('dd.MM.yyyy').format(DateTime.now()) == session.date) {
          spots[1] = session.balance + session.profit();
          maxY = max(maxY, session.balance + session.profit());
          newSession.add(session);
        }
      } else if (period == 'Yesterday') {
        if (DateFormat('dd.MM.yyyy').format(DateTime.now().subtract(const Duration(days: 1))) == session.date) {
          spots[1] = session.balance + session.profit();
          maxY = max(maxY, session.balance + session.profit());
          newSession.add(session);
        }
      } else if (period == 'All time') {
        spots[sessionDate.month] = session.balance + session.profit();
        maxY = max(maxY, session.balance + session.profit());
        newSession.add(session);
      } else if (sessionDate.isAfter(periodDate) || sessionDate.isAtSameMomentAs(periodDate)) {
        if (period == 'Week') {
          spots[sessionDate.weekday] = session.balance + session.profit();
          maxY = max(maxY, session.balance + session.profit());
          newSession.add(session);
        } else if (period == 'Month') {
          maxY = max(maxY, session.balance + session.profit());
          spots[sessionDate.day] = session.balance + session.profit();
          newSession.add(session);
        }
      }
    }

    Session? firstSession;
    Session? lastSession;
    DateTime? minDate;
    DateTime? maxDate;
    for (var session in newSession) {
      DateTime sessionDate = DateFormat('dd.MM.yyyy').parse(session.date);
      if (minDate == null || minDate.millisecondsSinceEpoch < sessionDate.millisecondsSinceEpoch ||
          (minDate.millisecondsSinceEpoch == sessionDate.millisecondsSinceEpoch && session.id < firstSession!.id)) {
        minDate = sessionDate;
        firstSession = session;
      }
      if (maxDate == null || maxDate.millisecondsSinceEpoch > sessionDate.millisecondsSinceEpoch
      || (maxDate.millisecondsSinceEpoch == sessionDate.millisecondsSinceEpoch && session.id > lastSession!.id)) {
        maxDate = sessionDate;
        lastSession = session;
      }
    }

    double lastBalance = 0;
    double percentDifference = 0;
    if (lastSession != null) {
      lastBalance = lastSession.balance + lastSession.profit();
      double firstBalance = firstSession!.balance + firstSession.profit();
      if (lastSession.id != firstSession.id && firstBalance != 0) {
        percentDifference = (((lastBalance - firstBalance) / firstBalance) * 100);
      }
    }

    emit(state.copyWith(
      period: period,
      spots: spots,
      maxY: maxY,
      lastBalance: lastBalance,
      percentDifference: percentDifference,
      sessionsFromPeriod: period != 'All time'
          ? newSession
          : state.sessions,
    ));
  }
}
