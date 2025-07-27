import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../localization/localization_keys.dart';
import '../controllers/gamification_controller.dart';
import 'tabs/challenges_tab.dart';
import 'tabs/achievements_tab.dart';
import 'tabs/badges_tab.dart';
import 'tabs/leaderboard_tab.dart';
import '../widgets/mobile_tab_button.dart';
import '../widgets/quick_actions_bottom_sheet.dart';
import '../widgets/user_profile_card.dart';

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
                          child: MobileTabButton(
                            title: LocalizationKeys.challenges.tr,
                            outlinedIcon: Icons.emoji_events_outlined,
                            filledIcon: Icons.emoji_events,
                            index: 0,
                            isSelected: controller.selectedTabIndex.value == 0,
                            onTap: () => controller.selectedTabIndex.value = 0,
                          ),
                        ),
                        Expanded(
                          child: MobileTabButton(
                            title: LocalizationKeys.achievements.tr,
                            outlinedIcon: Icons.military_tech_outlined,
                            filledIcon: Icons.military_tech,
                            index: 1,
                            isSelected: controller.selectedTabIndex.value == 1,
                            onTap: () => controller.selectedTabIndex.value = 1,
                          ),
                        ),
                        Expanded(
                          child: MobileTabButton(
                            title: LocalizationKeys.badges.tr,
                            outlinedIcon: Icons.workspace_premium_outlined,
                            filledIcon: Icons.workspace_premium,
                            index: 2,
                            isSelected: controller.selectedTabIndex.value == 2,
                            onTap: () => controller.selectedTabIndex.value = 2,
                          ),
                        ),
                        Expanded(
                          child: MobileTabButton(
                            title: LocalizationKeys.leaderboard.tr,
                            outlinedIcon: Icons.leaderboard_outlined,
                            filledIcon: Icons.leaderboard,
                            index: 3,
                            isSelected: controller.selectedTabIndex.value == 3,
                            onTap: () => controller.selectedTabIndex.value = 3,
                          ),
                        ),
                      ],
                    )),
              ),
            ),

            // Content Area - Now scrollable with loading state
            SliverToBoxAdapter(
              child: Container(
                constraints: BoxConstraints(
                  minHeight:
                      screenHeight * 0.6, // Ensure minimum height for content
                ),
                child: Obx(() {
                  // Show loading indicator while data is being loaded
                  if (controller.isLoading.value) {
                    return _buildLoadingSkeleton();
                  }

                  switch (controller.selectedTabIndex.value) {
                    case 0:
                      return ChallengesTab(controller: controller);
                    case 1:
                      return AchievementsTab(controller: controller);
                    case 2:
                      return BadgesTab(controller: controller);
                    case 3:
                      return LeaderboardTab(controller: controller);
                    default:
                      return ChallengesTab(controller: controller);
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
              onPressed: () =>
                  QuickActionsBottomSheet.show(context, controller),
              icon: Icon(Icons.flash_on),
              label: Text(LocalizationKeys.quickActions.tr),
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

  Widget _buildLoadingSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Loading shimmer cards
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.only(bottom: 16),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(Get.context!).primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
