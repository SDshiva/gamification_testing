import 'package:get/get.dart';

class GamificationService extends GetxService {
  static GamificationService get to => Get.find<GamificationService>();

  // Business logic only - no data storage
  // Controller holds the data directly

  // Core gamification methods that work with controller data
  Future<void> addPoints(int points, {String? reason}) async {
    // This will be implemented to work with controller data
    // For now, just show notification
    Get.snackbar(
      'Points Earned!',
      '+$points points${reason != null ? ' for $reason' : ''}',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> updateStreak() async {
    // Business logic for streak updates
    // Will work with controller data
  }

  Future<void> completeChallenge(String challengeId) async {
    // Business logic for challenge completion
    Get.snackbar(
      'Challenge Completed!',
      'You completed a challenge!',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }

  // Helper methods
  int calculateLevel(int totalPoints) {
    // Simple level calculation: 100 points per level
    return (totalPoints / 100).floor() + 1;
  }

  int calculateCurrentLevelProgress(int totalPoints, int level) {
    final pointsForCurrentLevel = (level - 1) * 100;
    return totalPoints - pointsForCurrentLevel;
  }

  int calculateRequiredPointsForNextLevel(int level) {
    return level * 100;
  }

  void showLevelUpNotification(int newLevel) {
    Get.snackbar(
      'Level Up!',
      '🎉 Congratulations! You reached level $newLevel!',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 4),
    );
  }

  // Public methods for testing and demo
  Future<void> simulateActivity() async {
    await addPoints(25, reason: 'daily activity');
    await updateStreak();
  }

  Future<void> simulateChallengeProgress(
      String challengeId, int progress) async {
    // Business logic for challenge progress
    // Will be implemented with controller data
  }
}
