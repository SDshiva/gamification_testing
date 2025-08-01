import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../localization/localization_keys.dart';
import '../../controllers/gamification_controller.dart';
import '../../widgets/challenge_card.dart';

class ChallengesTab extends StatelessWidget {
  final GamificationController controller;

  const ChallengesTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      // Show loading state if challenges content is not loaded yet
      if (!controller.challengesLoaded.value) {
        return _buildLoadingState();
      }

      return Column(
        children: [
          // Header with stats
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: 8),
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
                  child: _buildQuickStat('🎯', LocalizationKeys.active.tr,
                      '${controller.activeChallenges.length}', Colors.blue),
                ),
                Container(width: 1, height: 30, color: Colors.grey[300]),
                Expanded(
                  child: _buildQuickStat('✅', LocalizationKeys.completed.tr,
                      '${controller.completedChallenges.length}', Colors.green),
                ),
                Container(width: 1, height: 30, color: Colors.grey[300]),
                Expanded(
                  child: _buildQuickStat(
                      '⭐',
                      '${LocalizationKeys.points.tr} ${LocalizationKeys.today.tr}',
                      '65',
                      Colors.orange),
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
                  LocalizationKeys.noChallenges.tr,
                  LocalizationKeys.newChallengesHere.tr,
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
            // SizedBox(height: 16),
            // Text(
            //   'Loading challenges...',
            //   style: TextStyle(color: Colors.grey[600]),
            // ),
          ],
        ),
      ),
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

  void _showChallengeDetails(BuildContext context, challenge) {
    // Implementation for challenge details
  }
}
