class AppConstants {
  // App Info
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.shiva.gamification_testing';

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  static const Duration dramaticAnimation = Duration(milliseconds: 800);

  // Gamification Settings
  static const int pointsPerActivity = 25;
  static const int streakBonusMultiplier = 2;
  static const int maxLevel = 100;
  static const int pointsPerLevel = 500;
  static const int minPointsForFirstLevel = 100;
  static const int bonusPointsForStreak = 50;

  // UI Settings
  static const double maxMobileWidth = 600.0;
  static const double compactScreenWidth = 400.0;
  static const int maxDisplayItems = 50;
  static const int itemsPerPage = 20;

  // Demo Data Settings
  static const int demoUserLevel = 5;
  static const int demoUserPoints = 1250;
  static const int demoUserStreak = 7;
  static const int demoUserLongestStreak = 15;
  static const int demoLeaderboardSize = 10;
  static const int demoCurrentLevelProgress = 250;
  static const int demoRequiredPointsForNextLevel = 500;

  // Network & API Settings
  static const int connectionTimeout = 30; // seconds
  static const int requestTimeout = 15; // seconds
  static const int maxRetryAttempts = 3;

  // Cache Settings
  static const int cacheExpirationHours = 24;
  static const int maxCacheSize = 50; // MB

  // Notification Settings
  static const int snackbarDurationShort = 2; // seconds
  static const int snackbarDurationLong = 4; // seconds
  static const int toastDuration = 3; // seconds

  // Validation Rules
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int minPasswordLength = 8;
  static const int maxDescriptionLength = 200;

  // Feature Flags (for future use)
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableAnalytics = false;
  static const bool enableOfflineMode = true;
}
