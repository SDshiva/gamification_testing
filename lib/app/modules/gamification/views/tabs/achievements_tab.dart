import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../localization/localization_keys.dart';
import '../../controllers/gamification_controller.dart';
import '../../widgets/achievement_card.dart';

class AchievementsTab extends StatelessWidget {
  final GamificationController controller;

  const AchievementsTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      // Show loading state if achievements content is not loaded yet
      if (!controller.achievementsLoaded.value) {
        return _buildLoadingState();
      }

      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: 8),
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
                              '${LocalizationKeys.unlocked.tr} (${controller.unlockedAchievements.length})'),
                      Tab(
                          text:
                              '${LocalizationKeys.locked.tr} (${controller.lockedAchievements.length})'),
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
    });
  }

  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Loading achievements...',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsList(List achievements, bool isUnlocked) {
    if (achievements.isEmpty) {
      return _buildEmptyState(
        isUnlocked ? Icons.military_tech : Icons.lock,
        isUnlocked
            ? LocalizationKeys.noAchievementsUnlocked.tr
            : LocalizationKeys.allAchievementsUnlocked.tr,
        isUnlocked
            ? LocalizationKeys.completeChallengesUnlock.tr
            : LocalizationKeys.greatJob.tr,
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

  void _showAchievementDetails(BuildContext context, achievement) {
    // Implementation for achievement details
  }
}
