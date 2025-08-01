import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../localization/localization_keys.dart';
import '../../controllers/gamification_controller.dart';
import '../../widgets/badge_card.dart';

class BadgesTab extends StatelessWidget {
  final GamificationController controller;

  const BadgesTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      // Show loading state if badges content is not loaded yet
      if (!controller.badgesLoaded.value) {
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
                              '${LocalizationKeys.earned.tr} (${controller.earnedBadges.length})'),
                      Tab(
                          text:
                              '${LocalizationKeys.available.tr} (${controller.availableBadges.length})'),
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
              'Loading badges...',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesGrid(List badges, bool isEarned) {
    if (badges.isEmpty) {
      return _buildEmptyState(
        isEarned ? Icons.workspace_premium : Icons.check_circle,
        isEarned
            ? LocalizationKeys.noBadgesEarned.tr
            : LocalizationKeys.allBadgesEarned.tr,
        isEarned
            ? LocalizationKeys.completeAchievementsBadges.tr
            : LocalizationKeys.congratulations.tr,
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

  void _showBadgeDetails(BuildContext context, badge) {
    // Implementation for badge details
  }
}
