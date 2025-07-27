import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gamification_controller.dart';
import 'quick_action_button.dart';

class QuickActionsBottomSheet extends StatelessWidget {
  final GamificationController controller;

  const QuickActionsBottomSheet({
    super.key,
    required this.controller,
  });

  static void show(BuildContext context, GamificationController controller) {
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
        child: QuickActionsBottomSheet(controller: controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
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
              child: QuickActionButton(
                icon: Icons.add,
                label: 'Add Points',
                onTap: () {
                  controller.addPoints(25, reason: 'quick action');
                  Get.back();
                },
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.whatshot,
                label: 'Update Streak',
                onTap: () {
                  controller.simulateActivity();
                  Get.back();
                },
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.trending_up,
                label: 'Challenge +10',
                onTap: () {
                  controller.simulateChallengeProgress('daily_points', 10);
                  Get.back();
                },
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.military_tech,
                label: 'Complete Daily',
                onTap: () {
                  controller.completeChallenge('daily_points');
                  Get.back();
                },
                color: Colors.purple,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Add safe area padding at bottom
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}
