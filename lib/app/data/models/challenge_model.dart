enum ChallengeType {
  daily,
  weekly,
  monthly,
  special,
}

enum ChallengeStatus {
  active,
  completed,
  expired,
  upcoming,
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final String icon;
  final ChallengeType type;
  final ChallengeStatus status;
  final int targetValue;
  final int currentProgress;
  final int pointsReward;
  final DateTime startDate;
  final DateTime endDate;
  final String? badgeReward;
  final String? achievementReward;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    this.status = ChallengeStatus.active,
    required this.targetValue,
    this.currentProgress = 0,
    this.pointsReward = 0,
    required this.startDate,
    required this.endDate,
    this.badgeReward,
    this.achievementReward,
  });

  double get progressPercentage =>
      currentProgress / targetValue > 1.0 ? 1.0 : currentProgress / targetValue;

  bool get isCompleted => currentProgress >= targetValue;

  bool get isExpired => DateTime.now().isAfter(endDate);

  Challenge copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    ChallengeType? type,
    ChallengeStatus? status,
    int? targetValue,
    int? currentProgress,
    int? pointsReward,
    DateTime? startDate,
    DateTime? endDate,
    String? badgeReward,
    String? achievementReward,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      status: status ?? this.status,
      targetValue: targetValue ?? this.targetValue,
      currentProgress: currentProgress ?? this.currentProgress,
      pointsReward: pointsReward ?? this.pointsReward,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      badgeReward: badgeReward ?? this.badgeReward,
      achievementReward: achievementReward ?? this.achievementReward,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'type': typeString,
      'status': statusString,
      'targetValue': targetValue,
      'currentProgress': currentProgress,
      'pointsReward': pointsReward,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'badgeReward': badgeReward,
      'achievementReward': achievementReward,
    };
  }

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      type: ChallengeType.values.firstWhere(
        (e) => _getChallengeTypeString(e) == json['type'],
        orElse: () => ChallengeType.daily,
      ),
      status: ChallengeStatus.values.firstWhere(
        (e) => _getChallengeStatusString(e) == json['status'],
        orElse: () => ChallengeStatus.active,
      ),
      targetValue: json['targetValue'],
      currentProgress: json['currentProgress'] ?? 0,
      pointsReward: json['pointsReward'] ?? 0,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      badgeReward: json['badgeReward'],
      achievementReward: json['achievementReward'],
    );
  }

  static String _getChallengeTypeString(ChallengeType type) {
    switch (type) {
      case ChallengeType.daily:
        return 'daily';
      case ChallengeType.weekly:
        return 'weekly';
      case ChallengeType.monthly:
        return 'monthly';
      case ChallengeType.special:
        return 'special';
    }
  }

  static String _getChallengeStatusString(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.active:
        return 'active';
      case ChallengeStatus.completed:
        return 'completed';
      case ChallengeStatus.expired:
        return 'expired';
      case ChallengeStatus.upcoming:
        return 'upcoming';
    }
  }

  String get typeString {
    switch (type) {
      case ChallengeType.daily:
        return 'daily';
      case ChallengeType.weekly:
        return 'weekly';
      case ChallengeType.monthly:
        return 'monthly';
      case ChallengeType.special:
        return 'special';
    }
  }

  String get statusString {
    switch (status) {
      case ChallengeStatus.active:
        return 'active';
      case ChallengeStatus.completed:
        return 'completed';
      case ChallengeStatus.expired:
        return 'expired';
      case ChallengeStatus.upcoming:
        return 'upcoming';
    }
  }
}
