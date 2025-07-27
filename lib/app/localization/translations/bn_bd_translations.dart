import 'package:get/get.dart';

class BengaliTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'bn_BD': {
          // Common
          'loading': 'লোড হচ্ছে...',
          'error': 'ত্রুটি',
          'success': 'সফল',
          'cancel': 'বাতিল',
          'ok': 'ঠিক আছে',
          'retry': 'আবার চেষ্টা করুন',
          'close': 'বন্ধ করুন',
          'save': 'সংরক্ষণ',
          'delete': 'মুছে ফেলুন',

          // App Info
          'app_name': 'গেমিফিকেশন টেস্টিং',
          'app_title': 'গেমিফিকেশন!!',

          // Home Screen
          'welcome_title': 'গেমিফিকেশনে স্বাগতম!',
          'welcome_subtitle':
              'অর্জন, ব্যাজ, চ্যালেঞ্জের অভিজ্ঞতা নিন\nএবং লিডারবোর্ডে প্রতিযোগিতা করুন!',
          'start_gamification': 'গেমিফিকেশন শুরু করুন',
          'how_it_works': 'এটি কীভাবে কাজ করে',
          'quick_demo': 'দ্রুত ডেমো',
          'tutorial_message':
              'এটি গেমিফিকেশন বৈশিষ্ট্যগুলির একটি দ্রুত টিউটোরিয়াল দেখাবে',

          // Navigation
          'preparing_experience': 'গেমিফিকেশন অভিজ্ঞতা প্রস্তুত করা হচ্ছে',

          // Gamification - Quick Actions
          'quick_actions': 'দ্রুত কার্যক্রম',
          'add_points': 'পয়েন্ট যোগ করুন',
          'update_streak': 'স্ট্রিক আপডেট করুন',
          'challenge_progress': 'চ্যালেঞ্জ +১০',
          'complete_daily': 'দৈনিক সম্পূর্ণ করুন',

          // Tabs
          'challenges': 'চ্যালেঞ্জসমূহ',
          'achievements': 'অর্জনসমূহ',
          'badges': 'ব্যাজসমূহ',
          'leaderboard': 'লিডারবোর্ড',

          // Status & States
          'unlocked': 'আনলক হয়েছে',
          'locked': 'লক করা',
          'completed': 'সম্পন্ন',
          'in_progress': 'চলমান',
          'earned': 'অর্জিত',
          'available': 'উপলব্ধ',
          'active': 'সক্রিয়',
          'inactive': 'নিষ্ক্রিয়',

          // User Profile
          'level': 'স্তর',
          'points': 'পয়েন্ট',
          'streak': 'স্ট্রিক',
          'next_level': 'পরবর্তী স্তর',
          'current_streak': 'বর্তমান স্ট্রিক',
          'longest_streak': 'দীর্ঘতম স্ট্রিক',
          'total_points': 'মোট পয়েন্ট',

          // Achievements
          'first_steps': 'প্রথম পদক্ষেপ',
          'first_steps_desc': 'আপনার প্রথম ১০০ পয়েন্ট অর্জন করুন',
          'point_collector': 'পয়েন্ট সংগ্রাহক',
          'point_collector_desc': '১০০০ পয়েন্ট অর্জন করুন',
          'streak_master': 'স্ট্রিক মাস্টার',
          'streak_master_desc': '৭ দিনের স্ট্রিক বজায় রাখুন',
          'challenge_champion': 'চ্যালেঞ্জ চ্যাম্পিয়ন',
          'challenge_champion_desc': '১০টি চ্যালেঞ্জ সম্পূর্ণ করুন',

          // Challenges
          'daily_points': 'দৈনিক পয়েন্ট',
          'daily_points_desc': 'আজ ৫০ পয়েন্ট অর্জন করুন',
          'weekly_challenge': 'সাপ্তাহিক চ্যালেঞ্জ',
          'weekly_challenge_desc': 'এই সপ্তাহে ৫টি কার্যক্রম সম্পূর্ণ করুন',
          'monthly_goal': 'মাসিক লক্ষ্য',
          'monthly_goal_desc': 'এই মাসে ১০০০ পয়েন্টে পৌঁছান',

          // Badges
          'welcome_badge': 'স্বাগত ব্যাজ',
          'welcome_badge_desc': 'প্ল্যাটফর্মে স্বাগতম!',
          'streak_warrior': 'স্ট্রিক যোদ্ধা',
          'streak_warrior_desc': '৭ দিনের স্ট্রিক বজায় রেখেছেন',
          'point_master': 'পয়েন্ট মাস্টার',
          'point_master_desc': '১০০০+ পয়েন্ট অর্জন করেছেন',

          // Leaderboard
          'top_performers': 'শীর্ষ পারফরমারগণ',
          'your_rank': 'আপনার র‍্যাঙ্ক',
          'rank': 'র‍্যাঙ্ক',
          'player': 'খেলোয়াড়',
          'score': 'স্কোর',

          // Time & Dates
          'today': 'আজ',
          'yesterday': 'গতকাল',
          'this_week': 'এই সপ্তাহ',
          'this_month': 'এই মাস',
          'days_ago': 'দিন আগে',
          'hours_ago': 'ঘন্টা আগে',
          'minutes_ago': 'মিনিট আগে',
          'just_now': 'এইমাত্র',

          // Notifications & Messages
          'congratulations': 'অভিনন্দন!',
          'achievement_unlocked': 'অর্জন আনলক হয়েছে!',
          'badge_earned': 'ব্যাজ অর্জিত!',
          'challenge_completed': 'চ্যালেঞ্জ সম্পন্ন!',
          'points_added': 'পয়েন্ট যোগ হয়েছে!',
          'streak_updated': 'স্ট্রিক আপডেট হয়েছে!',
          'level_up': 'লেভেল আপ!',

          // Actions & Buttons
          'view_all': 'সব দেখুন',
          'see_more': 'আরো দেখুন',
          'show_less': 'কম দেখুন',
          'refresh': 'রিফ্রেশ',
          'share': 'শেয়ার',
          'settings': 'সেটিংস',

          // Error Messages
          'generic_error': 'কিছু ভুল হয়েছে। আবার চেষ্টা করুন।',
          'network_error': 'ইন্টারনেট সংযোগ নেই। আপনার সংযোগ পরীক্ষা করুন।',
          'data_load_error': 'ডেটা লোড করতে ব্যর্থ। রিফ্রেশ করুন।',
          'action_failed_error': 'কার্যক্রম ব্যর্থ। আবার চেষ্টা করুন।',

          // Empty States
          'no_achievements': 'এখনো কোনো অর্জন নেই',
          'no_badges': 'এখনো কোনো ব্যাজ অর্জিত হয়নি',
          'no_challenges': 'কোনো সক্রিয় চ্যালেঞ্জ নেই',
          'no_leaderboard': 'লিডারবোর্ড উপলব্ধ নেই',
          'no_data': 'কোনো ডেটা উপলব্ধ নেই',

          // Placeholders
          'search_placeholder': 'খোঁজ করুন...',
          'name_placeholder': 'আপনার নাম লিখুন',
          'email_placeholder': 'আপনার ইমেইল লিখুন',
        }
      };
}
