class Game {
  final String name;
  final List<int>? imageBytes;
  final String imageName;
  final double? profit;
  final int? timeInSeconds;

  const Game({
    required this.name,
    this.imageBytes = const [],
    required this.imageName,
    this.profit,
    this.timeInSeconds,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageBytes': imageBytes,
      'imageName': imageName,
      'profit': profit ?? 0,
      'timeInSeconds': timeInSeconds ?? 0,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'] as String,
      imageName: json['imageName'] as String,
      imageBytes: List<int>.from(json['imageBytes'].map((byte) => byte)),
      profit: json['profit'],
      timeInSeconds: json['timeInSeconds'],
    );
  }
}