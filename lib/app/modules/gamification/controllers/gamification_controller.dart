import 'package:get/get.dart';
import '../../../data/services/gamification_service.dart';
import '../../../data/models/challenge_model.dart';
import '../../../data/models/achievement_model.dart';
import '../../../data/models/badge_model.dart';
import '../../../data/models/leaderboard_model.dart';
import '../../../data/models/user_model.dart';

class GamificationController extends GetxController {
  final GamificationService _gamificationService =
      Get.put(GamificationService());

  // Direct reactive data - no need for double getters
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxList<Achievement> achievements = <Achievement>[].obs;
  final RxList<Badge> badges = <Badge>[].obs;
  final RxList<Challenge> challenges = <Challenge>[].obs;
  final RxList<LeaderboardEntry> leaderboard = <LeaderboardEntry>[].obs;

  final RxInt selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Initialize data directly in controller
    _initializeDemoUser();
    _initializeDemoAchievements();
    _initializeDemoBadges();
    _initializeDemoChallenges();
    _initializeDemoLeaderboard();
  }

  void _initializeDemoUser() {
    currentUser.value = UserModel(
      id: 'user_1',
      name: 'Demo User',
      email: 'demo@example.com',
      avatar: '👤',
      totalPoints: 1250,
      level: 5,
      currentLevelProgress: 250,
      requiredPointsForNextLevel: 500,
      achievements: ['first_points', 'streak_master'],
      badges: ['welcome_badge', 'point_collector'],
      currentStreak: 7,
      longestStreak: 15,
      lastActivity: DateTime.now(),
      createdAt: DateTime.now().subtract(Duration(days: 30)),
    );
  }

  void _initializeDemoAchievements() {
    achievements.addAll([
      Achievement(
        id: 'first_points',
        title: 'First Steps',
        description: 'Earn your first 100 points',
        icon: '🎯',
        type: AchievementType.points,
        requiredValue: 100,
        pointsReward: 50,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(Duration(days: 25)),
        badgeId: 'welcome_badge',
      ),
      Achievement(
        id: 'point_collector',
        title: 'Point Collector',
        description: 'Earn 1000 points',
        icon: '💎',
        type: AchievementType.points,
        requiredValue: 1000,
        pointsReward: 200,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(Duration(days: 10)),
        badgeId: 'point_collector',
      ),
      Achievement(
        id: 'streak_master',
        title: 'Streak Master',
        description: 'Maintain a 7-day streak',
        icon: '🔥',
        type: AchievementType.streak,
        requiredValue: 7,
        pointsReward: 150,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(Duration(days: 2)),
      ),
      Achievement(
        id: 'challenge_champion',
        title: 'Challenge Champion',
        description: 'Complete 10 challenges',
        icon: '🏆',
        type: AchievementType.challenge,
        requiredValue: 10,
        pointsReward: 300,
        isUnlocked: false,
      ),
      Achievement(
        id: 'level_up',
        title: 'Level Up Master',
        description: 'Reach level 10',
        icon: '⭐',
        type: AchievementType.special,
        requiredValue: 10,
        pointsReward: 500,
        isUnlocked: false,
      ),
    ]);
  }

  void _initializeDemoBadges() {
    badges.addAll([
      Badge(
        id: 'welcome_badge',
        name: 'Welcome',
        description: 'Welcome to the gamification system!',
        icon: '🎉',
        rarity: BadgeRarity.common,
        color: '#4CAF50',
        isEarned: true,
        earnedAt: DateTime.now().subtract(Duration(days: 25)),
        achievementId: 'first_points',
      ),
      Badge(
        id: 'point_collector',
        name: 'Point Collector',
        description: 'Excellent point collection skills!',
        icon: '💰',
        rarity: BadgeRarity.rare,
        color: '#FF9800',
        isEarned: true,
        earnedAt: DateTime.now().subtract(Duration(days: 10)),
        achievementId: 'point_collector',
      ),
      Badge(
        id: 'streak_warrior',
        name: 'Streak Warrior',
        description: 'Master of consistency!',
        icon: '⚔️',
        rarity: BadgeRarity.epic,
        color: '#9C27B0',
        isEarned: false,
      ),
      Badge(
        id: 'legendary_champion',
        name: 'Legendary Champion',
        description: 'The ultimate achievement!',
        icon: '👑',
        rarity: BadgeRarity.legendary,
        color: '#FFD700',
        isEarned: false,
      ),
    ]);
  }

  void _initializeDemoChallenges() {
    final now = DateTime.now();
    challenges.addAll([
      Challenge(
        id: 'daily_points',
        title: 'Daily Points Goal',
        description: 'Earn 100 points today',
        icon: '🎯',
        type: ChallengeType.daily,
        targetValue: 100,
        currentProgress: 65,
        pointsReward: 50,
        startDate: DateTime(now.year, now.month, now.day),
        endDate: DateTime(now.year, now.month, now.day, 23, 59, 59),
      ),
      Challenge(
        id: 'weekly_streak',
        title: 'Weekly Streak',
        description: 'Maintain activity for 7 days',
        icon: '🔥',
        type: ChallengeType.weekly,
        targetValue: 7,
        currentProgress: 5,
        pointsReward: 200,
        startDate: now.subtract(Duration(days: now.weekday - 1)),
        endDate: now.add(Duration(days: 7 - now.weekday)),
        badgeReward: 'streak_warrior',
      ),
      Challenge(
        id: 'monthly_master',
        title: 'Monthly Master',
        description: 'Complete 20 activities this month',
        icon: '🏆',
        type: ChallengeType.monthly,
        targetValue: 20,
        currentProgress: 12,
        pointsReward: 500,
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
        achievementReward: 'challenge_champion',
      ),
    ]);
  }

  void _initializeDemoLeaderboard() {
    leaderboard.addAll([
      LeaderboardEntry(
        userId: 'user_2',
        userName: 'Alice Johnson',
        userAvatar: '👩',
        points: 2150,
        level: 8,
        rank: 1,
      ),
      LeaderboardEntry(
        userId: 'user_3',
        userName: 'Bob Smith',
        userAvatar: '👨',
        points: 1890,
        level: 7,
        rank: 2,
      ),
      LeaderboardEntry(
        userId: 'user_1',
        userName: 'Demo User',
        userAvatar: '👤',
        points: 1250,
        level: 5,
        rank: 3,
        isCurrentUser: true,
      ),
      LeaderboardEntry(
        userId: 'user_4',
        userName: 'Carol Davis',
        userAvatar: '👩‍💼',
        points: 980,
        level: 4,
        rank: 4,
      ),
      LeaderboardEntry(
        userId: 'user_5',
        userName: 'David Wilson',
        userAvatar: '👨‍💻',
        points: 750,
        level: 3,
        rank: 5,
      ),
    ]);
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Gamification actions - delegate business logic to service
  Future<void> simulateActivity() async {
    await _gamificationService.simulateActivity();
  }

  Future<void> addPoints(int points, {String? reason}) async {
    await _gamificationService.addPoints(points, reason: reason);
  }

  Future<void> completeChallenge(String challengeId) async {
    await _gamificationService.completeChallenge(challengeId);
  }

  Future<void> simulateChallengeProgress(
      String challengeId, int progress) async {
    await _gamificationService.simulateChallengeProgress(challengeId, progress);
  }

  // Filter methods
  List<Achievement> get unlockedAchievements =>
      achievements.where((Achievement a) => a.isUnlocked).toList();
  List<Achievement> get lockedAchievements =>
      achievements.where((Achievement a) => !a.isUnlocked).toList();
  List<Badge> get earnedBadges =>
      badges.where((Badge b) => b.isEarned).toList();
  List<Badge> get availableBadges =>
      badges.where((Badge b) => !b.isEarned).toList();
  List<Challenge> get activeChallenges => challenges
      .where((Challenge c) => c.status == ChallengeStatus.active)
      .toList();
  List<Challenge> get completedChallenges => challenges
      .where((Challenge c) => c.status == ChallengeStatus.completed)
      .toList();
}
