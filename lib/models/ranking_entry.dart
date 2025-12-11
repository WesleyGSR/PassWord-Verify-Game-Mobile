class RankingEntry {
  final String nickname;
  final int completionTime; // seconds
  final DateTime completedAt;

  RankingEntry({
    required this.nickname,
    required this.completionTime,
    required this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'completionTime': completionTime,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory RankingEntry.fromMap(Map<String, dynamic> map) {
    return RankingEntry(
      nickname: map['nickname'],
      completionTime: map['completionTime'],
      completedAt: DateTime.parse(map['completedAt']),
    );
  }
}
