enum AchievementType {
  points,
  streak,
  challenge,
  social,
  special,
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final AchievementType type;
  final int requiredValue;
  final int pointsReward;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final String? badgeId;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    required this.requiredValue,
    this.pointsReward = 0,
    this.isUnlocked = false,
    this.unlockedAt,
    this.badgeId,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    AchievementType? type,
    int? requiredValue,
    int? pointsReward,
    bool? isUnlocked,
    DateTime? unlockedAt,
    String? badgeId,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      requiredValue: requiredValue ?? this.requiredValue,
      pointsReward: pointsReward ?? this.pointsReward,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      badgeId: badgeId ?? this.badgeId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'type': _getAchievementTypeString(type),
      'requiredValue': requiredValue,
      'pointsReward': pointsReward,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'badgeId': badgeId,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      type: AchievementType.values.firstWhere(
        (e) => _getAchievementTypeStringStatic(e) == json['type'],
        orElse: () => AchievementType.points,
      ),
      requiredValue: json['requiredValue'],
      pointsReward: json['pointsReward'] ?? 0,
      isUnlocked: json['isUnlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'])
          : null,
      badgeId: json['badgeId'],
    );
  }

  static String _getAchievementTypeStringStatic(AchievementType type) {
    switch (type) {
      case AchievementType.points:
        return 'points';
      case AchievementType.streak:
        return 'streak';
      case AchievementType.challenge:
        return 'challenge';
      case AchievementType.social:
        return 'social';
      case AchievementType.special:
        return 'special';
    }
  }

  String _getAchievementTypeString(AchievementType type) {
    switch (type) {
      case AchievementType.points:
        return 'points';
      case AchievementType.streak:
        return 'streak';
      case AchievementType.challenge:
        return 'challenge';
      case AchievementType.social:
        return 'social';
      case AchievementType.special:
        return 'special';
    }
  }
}
