enum BadgeRarity {
  common,
  rare,
  epic,
  legendary,
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String icon;
  final BadgeRarity rarity;
  final String color;
  final bool isEarned;
  final DateTime? earnedAt;
  final String? achievementId;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.rarity = BadgeRarity.common,
    this.color = '#4CAF50',
    this.isEarned = false,
    this.earnedAt,
    this.achievementId,
  });

  Badge copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    BadgeRarity? rarity,
    String? color,
    bool? isEarned,
    DateTime? earnedAt,
    String? achievementId,
  }) {
    return Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      rarity: rarity ?? this.rarity,
      color: color ?? this.color,
      isEarned: isEarned ?? this.isEarned,
      earnedAt: earnedAt ?? this.earnedAt,
      achievementId: achievementId ?? this.achievementId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'rarity': rarityString,
      'color': color,
      'isEarned': isEarned,
      'earnedAt': earnedAt?.toIso8601String(),
      'achievementId': achievementId,
    };
  }

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      rarity: BadgeRarity.values.firstWhere(
        (e) => _getBadgeRarityString(e) == json['rarity'],
        orElse: () => BadgeRarity.common,
      ),
      color: json['color'] ?? '#4CAF50',
      isEarned: json['isEarned'] ?? false,
      earnedAt:
          json['earnedAt'] != null ? DateTime.parse(json['earnedAt']) : null,
      achievementId: json['achievementId'],
    );
  }

  static String _getBadgeRarityString(BadgeRarity rarity) {
    switch (rarity) {
      case BadgeRarity.common:
        return 'common';
      case BadgeRarity.rare:
        return 'rare';
      case BadgeRarity.epic:
        return 'epic';
      case BadgeRarity.legendary:
        return 'legendary';
    }
  }

  String get rarityString {
    switch (rarity) {
      case BadgeRarity.common:
        return 'common';
      case BadgeRarity.rare:
        return 'rare';
      case BadgeRarity.epic:
        return 'epic';
      case BadgeRarity.legendary:
        return 'legendary';
    }
  }
}
