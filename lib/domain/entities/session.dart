import 'package:ultimate_casino_play_analytics/domain/entities/game.dart';

class Session {
  final int id;
  final String date;
  final String casinoName;
  final double balance;
  final int spendTimeInSeconds;
  final List<Game>? games;

  const Session({
    required this.id,
    required this.date,
    required this.casinoName,
    required this.balance,
    required this.spendTimeInSeconds,
    this.games = const <Game>[],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'casinoName': casinoName,
      'balance': balance,
      'spendTimeInSeconds': spendTimeInSeconds,
      'games': games!.map((e) => e.toJson()).toList(),
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] ?? 0,
      date: json['date'],
      casinoName: json['casinoName'],
      balance: json['balance'],
      spendTimeInSeconds: json['spendTimeInSeconds'],
      games: List<Game>.from(json['games'].map((game) => Game.fromJson(game))),
    );
  }

  Session copyWith({
    int? id,
    String? date,
    String? casinoName,
    double? balance,
    int? spendTimeInSeconds,
    List<Game>? games,
  }) {
    return Session(
      id: id ?? this.id,
      date: date ?? this.date,
      casinoName: casinoName ?? this.casinoName,
      balance: balance ?? this.balance,
      spendTimeInSeconds: spendTimeInSeconds ?? this.spendTimeInSeconds,
      games: games ?? this.games,
    );
  }

  double profit({String? currency = '\$'}) {
    double profit = 0;
    for (var i = 0; i < games!.length; i++) {
      profit += games![i].profit ?? 0;
    }

    return profit;
  }

  List<int> getImageBytes() {
    List<int> imageBytes = [];
    Map<String, int> countGames = {};
    int maxCount = 0;
    for(var game in games ?? []) {
      if (countGames[game.name] != null) {
        countGames[game.name] = (countGames[game.name] as int) + 1;
      } else {
        countGames[game.name] = 1;
      }
      if ((countGames[game.name] as int) > maxCount) {
        imageBytes = game.imageBytes;
        maxCount = countGames[game.name] as int;
      }
    }

    return imageBytes;
  }
}