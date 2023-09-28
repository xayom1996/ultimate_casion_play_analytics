import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/game.dart';
import 'package:ultimate_casino_play_analytics/domain/entities/session.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState());

  void initDb() async {
    var box = await Hive.openBox('testBox');
    var session = box.get('session');
    if (session != null && session['spendTimeInSeconds'] != null) {
      emit(state.copyWith(
        isActive: true,
        session: Session.fromJson(jsonDecode(jsonEncode(session))),
      ));
    }
  }

  void addSession(String date, String casino, double balance) async {
    var box = await Hive.openBox('testBox');
    box.put('session', {
      'date': date,
      'casinoName': casino,
      'balance': balance,
      'spendTimeInSeconds': 0,
      'games': [],
    });

    emit(state.copyWith(
      isActive: true,
      session: Session(
        id: 0,
        date: date,
        casinoName: casino,
        balance: balance,
        spendTimeInSeconds: 0,
      ),
    ));
  }

  void addGame(
      String gameName, List<int> imageBytes, String imageName, double profit) async {
    print(profit);
    Game game = Game(
      name: gameName,
      imageBytes: imageBytes,
      imageName: imageName,
      timeInSeconds: state.session!.spendTimeInSeconds,
      profit: profit,
    );
    List<Game> games = (state.session!.games ?? <Game>[]).toList();
    games.add(game);

    var box = await Hive.openBox('testBox');
    var session = box.get('session');
    session['games'] = games.map((e) => e.toJson()).toList();
    box.put('session', session);

    emit(state.copyWith(
      isActive: true,
      session: state.session!.copyWith(
        games: games,
      )
    ));
  }

  void saveDb(int spendTimeInSeconds) async {
    var box = await Hive.openBox('testBox');
    var session = state.session!.copyWith(
      spendTimeInSeconds: spendTimeInSeconds,
    );
    box.put('session', session.toJson());

    emit(state.copyWith(
      isActive: true,
      session: session,
    ));
  }

  void endSession() async {
    var box = await Hive.openBox('testBox');
    box.delete('session');

    emit(state.copyWith(
      session: null,
      isActive: false,
    ));
  }
}
