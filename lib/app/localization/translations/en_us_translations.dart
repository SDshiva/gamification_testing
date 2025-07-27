import 'package:get/get.dart';

class EnglishTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Common
          'loading': 'Loading...',
          'error': 'Error',
          'success': 'Success',
          'cancel': 'Cancel',
          'ok': 'OK',
          'retry': 'Retry',
          'close': 'Close',
          'save': 'Save',
          'delete': 'Delete',

          // App Info
          'app_name': 'Gamification Testing',
          'app_title': 'Gamification!!',

          // Home Screen
          'welcome_title': 'Welcome to Gamification!',
          'welcome_subtitle':
              'Experience achievements, badges, challenges,\nand compete on the leaderboard!',
          'start_gamification': 'Start Gamification',
          'how_it_works': 'How it Works',
          'quick_demo': 'Quick Demo',
          'tutorial_message':
              'This would show a quick tutorial of the gamification features',

          // Navigation
          'preparing_experience': 'Preparing gamification experience',

          // Gamification - Quick Actions
          'quick_actions': 'Quick Actions',
          'add_points': 'Add Points',
          'update_streak': 'Update Streak',
          'challenge_progress': 'Challenge +10',
          'complete_daily': 'Complete Daily',

          // Tabs
          'challenges': 'Challenges',
          'achievements': 'Achievements',
          'badges': 'Badges',
          'leaderboard': 'Leaderboard',

          // Status & States
          'unlocked': 'Unlocked',
          'locked': 'Locked',
          'completed': 'Completed',
          'in_progress': 'In Progress',
          'earned': 'Earned',
          'available': 'Available',
          'active': 'Active',
          'inactive': 'Inactive',

          // User Profile
          'level': 'Level',
          'points': 'Points',
          'streak': 'Streak',
          'next_level': 'Next Level',
          'current_streak': 'Current Streak',
          'longest_streak': 'Longest Streak',
          'total_points': 'Total Points',

          // Achievements
          'first_steps': 'First Steps',
          'first_steps_desc': 'Earn your first 100 points',
          'point_collector': 'Point Collector',
          'point_collector_desc': 'Earn 1000 points',
          'streak_master': 'Streak Master',
          'streak_master_desc': 'Maintain a 7-day streak',
          'challenge_champion': 'Challenge Champion',
          'challenge_champion_desc': 'Complete 10 challenges',

          // Challenges
          'daily_points': 'Daily Points',
          'daily_points_desc': 'Earn 50 points today',
          'weekly_challenge': 'Weekly Challenge',
          'weekly_challenge_desc': 'Complete 5 activities this week',
          'monthly_goal': 'Monthly Goal',
          'monthly_goal_desc': 'Reach 1000 points this month',

          // Badges
          'welcome_badge': 'Welcome Badge',
          'welcome_badge_desc': 'Welcome to the platform!',
          'streak_warrior': 'Streak Warrior',
          'streak_warrior_desc': 'Maintained a 7-day streak',
          'point_master': 'Point Master',
          'point_master_desc': 'Earned 1000+ points',

          // Leaderboard
          'top_performers': 'Top Performers',
          'your_rank': 'Your Rank',
          'rank': 'Rank',
          'player': 'Player',
          'score': 'Score',

          // Time & Dates
          'today': 'Today',
          'yesterday': 'Yesterday',
          'this_week': 'This Week',
          'this_month': 'This Month',
          'days_ago': 'days ago',
          'hours_ago': 'hours ago',
          'minutes_ago': 'minutes ago',
          'just_now': 'Just now',

          // Notifications & Messages
          'congratulations': 'Congratulations!',
          'achievement_unlocked': 'Achievement Unlocked!',
          'badge_earned': 'Badge Earned!',
          'challenge_completed': 'Challenge Completed!',
          'points_added': 'Points Added!',
          'streak_updated': 'Streak Updated!',
          'level_up': 'Level Up!',

          // Actions & Buttons
          'view_all': 'View All',
          'see_more': 'See More',
          'show_less': 'Show Less',
          'refresh': 'Refresh',
          'share': 'Share',
          'settings': 'Settings',

          // Error Messages
          'generic_error': 'Something went wrong. Please try again.',
          'network_error':
              'No internet connection. Please check your connection.',
          'data_load_error': 'Failed to load data. Please refresh.',
          'action_failed_error': 'Action failed. Please try again.',

          // Empty States
          'no_achievements': 'No achievements yet',
          'no_badges': 'No badges earned yet',
          'no_challenges': 'No active challenges',
          'no_leaderboard': 'Leaderboard not available',
          'no_data': 'No data available',

          // Placeholders
          'search_placeholder': 'Search...',
          'name_placeholder': 'Enter your name',
          'email_placeholder': 'Enter your email',
        }
      };
}
