class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final int totalPoints;
  final int level;
  final int currentLevelProgress;
  final int requiredPointsForNextLevel;
  final List<String> achievements;
  final List<String> badges;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastActivity;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar = '',
    this.totalPoints = 0,
    this.level = 1,
    this.currentLevelProgress = 0,
    this.requiredPointsForNextLevel = 100,
    this.achievements = const [],
    this.badges = const [],
    this.currentStreak = 0,
    this.longestStreak = 0,
    required this.lastActivity,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    int? totalPoints,
    int? level,
    int? currentLevelProgress,
    int? requiredPointsForNextLevel,
    List<String>? achievements,
    List<String>? badges,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastActivity,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      totalPoints: totalPoints ?? this.totalPoints,
      level: level ?? this.level,
      currentLevelProgress: currentLevelProgress ?? this.currentLevelProgress,
      requiredPointsForNextLevel:
          requiredPointsForNextLevel ?? this.requiredPointsForNextLevel,
      achievements: achievements ?? this.achievements,
      badges: badges ?? this.badges,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActivity: lastActivity ?? this.lastActivity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'totalPoints': totalPoints,
      'level': level,
      'currentLevelProgress': currentLevelProgress,
      'requiredPointsForNextLevel': requiredPointsForNextLevel,
      'achievements': achievements,
      'badges': badges,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActivity': lastActivity.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'] ?? '',
      totalPoints: json['totalPoints'] ?? 0,
      level: json['level'] ?? 1,
      currentLevelProgress: json['currentLevelProgress'] ?? 0,
      requiredPointsForNextLevel: json['requiredPointsForNextLevel'] ?? 100,
      achievements: List<String>.from(json['achievements'] ?? []),
      badges: List<String>.from(json['badges'] ?? []),
      currentStreak: json['currentStreak'] ?? 0,
      longestStreak: json['longestStreak'] ?? 0,
      lastActivity: DateTime.parse(json['lastActivity']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
