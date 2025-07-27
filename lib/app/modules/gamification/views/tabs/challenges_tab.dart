import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/gamification_controller.dart';
import '../../../home/widgets/challenge_card.dart';

class ChallengesTab extends StatelessWidget {
  final GamificationController controller;

  const ChallengesTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
