class LeaderboardEntry {
  final String userId;
  final String userName;
  final String userAvatar;
  final int points;
  final int level;
  final int rank;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.userId,
    required this.userName,
    this.userAvatar = '',
    required this.points,
    required this.level,
    required this.rank,
    this.isCurrentUser = false,
  });

  LeaderboardEntry copyWith({
    String? userId,
    String? userName,
    String? userAvatar,
    int? points,
    int? level,
    int? rank,
    bool? isCurrentUser,
  }) {
    return LeaderboardEntry(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      points: points ?? this.points,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'points': points,
      'level': level,
      'rank': rank,
      'isCurrentUser': isCurrentUser,
    };
  }

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'],
      userName: json['userName'],
      userAvatar: json['userAvatar'] ?? '',
      points: json['points'],
      level: json['level'],
      rank: json['rank'],
      isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }
}
