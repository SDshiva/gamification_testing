import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gamification_controller.dart';
import '../../home/widgets/user_profile_card.dart';
import '../../home/widgets/achievement_card.dart';
import '../../home/widgets/badge_card.dart';
import '../../home/widgets/challenge_card.dart';
import '../../home/widgets/leaderboard_card.dart';

class GamificationView extends GetView<GamificationController> {
  const GamificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // User Profile Section
            SliverToBoxAdapter(
              child: Obx(() {
                final user = controller.currentUser.value;
                if (user == null) {
                  return SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return UserProfileCard(user: user);
              }),
            ),

            // Bottom Navigation Style Tabs
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04, vertical: 8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(() => Row(
                      children: [
                        Expanded(
                          child: _buildMobileTabButton(
                            context,
                            'Challenges',
                            Icons.emoji_events_outlined,
                            Icons.emoji_events,
                            0,
                            controller.selectedTabIndex.value == 0,
                          ),
                        ),
                        Expanded(
                          child: _buildMobileTabButton(
                            context,
                            'Achievements',
                            Icons.military_tech_outlined,
                            Icons.military_tech,
                            1,
                            controller.selectedTabIndex.value == 1,
                          ),
                        ),
                        Expanded(
                          child: _buildMobileTabButton(
                            context,
                            'Badges',
                            Icons.workspace_premium_outlined,
                            Icons.workspace_premium,
                            2,
                            controller.selectedTabIndex.value == 2,
                          ),
                        ),
                        Expanded(
                          child: _buildMobileTabButton(
                            context,
                            'Leaderboard',
                            Icons.leaderboard_outlined,
                            Icons.leaderboard,
                            3,
                            controller.selectedTabIndex.value == 3,
                          ),
                        ),
                      ],
                    )),
              ),
            ),

            // Content Area - Now scrollable
            SliverToBoxAdapter(
              child: Container(
                constraints: BoxConstraints(
                  minHeight:
                      screenHeight * 0.6, // Ensure minimum height for content
                ),
                child: Obx(() {
                  switch (controller.selectedTabIndex.value) {
                    case 0:
                      return _buildChallengesTab(context);
                    case 1:
                      return _buildAchievementsTab(context);
                    case 2:
                      return _buildBadgesTab(context);
                    case 3:
                      return _buildLeaderboardTab(context);
                    default:
                      return _buildChallengesTab(context);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        // Show different FABs based on current tab
        switch (controller.selectedTabIndex.value) {
          case 0: // Challenges
            return FloatingActionButton.extended(
              onPressed: () => _showQuickActionsBottomSheet(context),
              icon: Icon(Icons.flash_on),
              label: Text('Quick Actions'),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            );
          default:
            return FloatingActionButton(
              onPressed: () => controller.simulateActivity(),
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            );
        }
      }),
    );
  }

  Widget _buildMobileTabButton(BuildContext context, String title,
      IconData outlinedIcon, IconData filledIcon, int index, bool isSelected) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 400;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding:
            EdgeInsets.symmetric(vertical: 12, horizontal: isCompact ? 4 : 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                isSelected ? filledIcon : outlinedIcon,
                key: ValueKey(isSelected),
                color: isSelected ? Colors.white : Colors.grey[600],
                size: isCompact ? 18 : 20,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: isCompact ? 9 : 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesTab(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // Header with stats
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildQuickStat('🎯', 'Active',
                    '${controller.activeChallenges.length}', Colors.blue),
              ),
              Container(width: 1, height: 30, color: Colors.grey[300]),
              Expanded(
                child: _buildQuickStat('✅', 'Completed',
                    '${controller.completedChallenges.length}', Colors.green),
              ),
              Container(width: 1, height: 30, color: Colors.grey[300]),
              Expanded(
                child:
                    _buildQuickStat('⭐', 'Points Today', '65', Colors.orange),
              ),
            ],
          ),
        ),

        // Challenges List
        Obx(() {
          final challenges = controller.activeChallenges;
          if (challenges.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: _buildEmptyState(
                Icons.emoji_events,
                'No Active Challenges',
                'New challenges will appear here',
              ),
            );
          }

          return Column(
            children: challenges.map((challenge) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: ChallengeCard(
                  challenge: challenge,
                  onTap: () => _showChallengeDetails(context, challenge),
                ),
              );
            }).toList(),
          );
        }),

        // Add some bottom padding for FAB
        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildAchievementsTab(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                        text:
                            'Unlocked (${controller.unlockedAchievements.length})'),
                    Tab(
                        text:
                            'Locked (${controller.lockedAchievements.length})'),
                  ],
                ),
                Container(
                  height:
                      screenHeight * 0.5, // Give fixed height for TabBarView
                  child: TabBarView(
                    children: [
                      _buildAchievementsList(
                          controller.unlockedAchievements, true),
                      _buildAchievementsList(
                          controller.lockedAchievements, false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 100), // Bottom padding for FAB
      ],
    );
  }

  Widget _buildAchievementsList(List achievements, bool isUnlocked) {
    if (achievements.isEmpty) {
      return _buildEmptyState(
        isUnlocked ? Icons.military_tech : Icons.lock,
        isUnlocked
            ? 'No achievements unlocked yet'
            : 'All achievements unlocked!',
        isUnlocked
            ? 'Complete challenges to unlock achievements'
            : 'Great job!',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return AchievementCard(
          achievement: achievements[index],
          onTap: () => _showAchievementDetails(context, achievements[index]),
        );
      },
    );
  }

  Widget _buildBadgesTab(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'Earned (${controller.earnedBadges.length})'),
                    Tab(
                        text:
                            'Available (${controller.availableBadges.length})'),
                  ],
                ),
                Container(
                  height:
                      screenHeight * 0.5, // Give fixed height for TabBarView
                  child: TabBarView(
                    children: [
                      _buildBadgesGrid(controller.earnedBadges, true),
                      _buildBadgesGrid(controller.availableBadges, false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 100), // Bottom padding for FAB
      ],
    );
  }

  Widget _buildBadgesGrid(List badges, bool isEarned) {
    if (badges.isEmpty) {
      return _buildEmptyState(
        isEarned ? Icons.workspace_premium : Icons.check_circle,
        isEarned ? 'No badges earned yet' : 'All badges earned!',
        isEarned ? 'Complete achievements to earn badges' : 'Congratulations!',
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final crossAxisCount = screenWidth > 600 ? 3 : 2; // Responsive grid

        return GridView.builder(
          padding: EdgeInsets.all(screenWidth * 0.04),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: badges.length,
          itemBuilder: (context, index) {
            return BadgeCard(
              badge: badges[index],
              onTap: () => _showBadgeDetails(context, badges[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildLeaderboardTab(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // Top 3 Podium
        Container(
          margin: EdgeInsets.all(screenWidth * 0.04),
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber[100] ?? Colors.amber.shade100,
                Colors.amber[50] ?? Colors.amber.shade50
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: _buildPodium(),
        ),

        // Full Leaderboard
        Obx(() {
          final leaderboard = controller.leaderboard;
          if (leaderboard.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: _buildEmptyState(
                Icons.leaderboard,
                'No leaderboard data',
                'Rankings will appear here',
              ),
            );
          }

          return Column(
            children: leaderboard.map((entry) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: LeaderboardCard(
                  entry: entry,
                  onTap: () => _showUserProfile(context, entry),
                ),
              );
            }).toList(),
          );
        }),

        // Add some bottom padding for FAB
        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildPodium() {
    return Obx(() {
      final leaderboard = controller.leaderboard;
      if (leaderboard.length < 3) return SizedBox.shrink();

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd Place - Check bounds
          if (leaderboard.length > 1)
            _buildPodiumPosition(leaderboard[1], 2, 60,
                Colors.grey[400] ?? Colors.grey.shade400),
          // 1st Place - Check bounds
          if (leaderboard.isNotEmpty)
            _buildPodiumPosition(leaderboard[0], 1, 80,
                Colors.amber[400] ?? Colors.amber.shade400),
          // 3rd Place - Check bounds
          if (leaderboard.length > 2)
            _buildPodiumPosition(leaderboard[2], 3, 50,
                Colors.brown[400] ?? Colors.brown.shade400),
        ],
      );
    });
  }

  Widget _buildPodiumPosition(entry, int position, double height, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: color, width: 3),
          ),
          child: Center(
            child: Text(
              (entry?.userAvatar?.isNotEmpty == true) ? entry.userAvatar : '👤',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          entry?.userName ?? 'Unknown',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                position == 1
                    ? '🥇'
                    : position == 2
                        ? '🥈'
                        : '🥉',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 2),
              Text(
                '${entry?.points ?? 0}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStat(String icon, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text(icon, style: TextStyle(fontSize: 16))),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildEmptyState(IconData icon, String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showQuickActionsBottomSheet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300] ?? Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Quick Actions',
              style: TextStyle(
                  fontSize: screenWidth > 600 ? 24 : 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    context,
                    Icons.add,
                    'Add Points',
                    () => controller.addPoints(25, reason: 'quick action'),
                    Colors.blue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionButton(
                    context,
                    Icons.whatshot,
                    'Update Streak',
                    () => controller.simulateActivity(),
                    Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    context,
                    Icons.trending_up,
                    'Challenge +10',
                    () => controller.simulateChallengeProgress(
                        'daily_points', 10),
                    Colors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionButton(
                    context,
                    Icons.military_tech,
                    'Complete Daily',
                    () => controller.completeChallenge('daily_points'),
                    Colors.purple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Add safe area padding at bottom
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(BuildContext context, IconData icon,
      String label, VoidCallback onTap, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        onTap();
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: screenWidth > 600 ? 36 : 32),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth > 600 ? 14 : 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showChallengeDetails(BuildContext context, challenge) {
    // Implementation for challenge details
  }

  void _showAchievementDetails(BuildContext context, achievement) {
    // Implementation for achievement details
  }

  void _showBadgeDetails(BuildContext context, badge) {
    // Implementation for badge details
  }

  void _showUserProfile(BuildContext context, entry) {
    // Implementation for user profile
  }
}
