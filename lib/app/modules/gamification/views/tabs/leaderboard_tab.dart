import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/gamification_controller.dart';
import '../../widgets/leaderboard_card.dart';

class LeaderboardTab extends StatelessWidget {
  final GamificationController controller;

  const LeaderboardTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      // Show loading state if leaderboard content is not loaded yet
      if (!controller.leaderboardLoaded.value) {
        return _buildLoadingState();
      }

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
              'Loading leaderboard...',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
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

  void _showUserProfile(BuildContext context, entry) {
    // Implementation for user profile
  }
}
