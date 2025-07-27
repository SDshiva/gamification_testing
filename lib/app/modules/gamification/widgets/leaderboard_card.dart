import 'package:flutter/material.dart';
import '../../../data/models/leaderboard_model.dart';

class LeaderboardCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final VoidCallback? onTap;

  const LeaderboardCard({
    super.key,
    required this.entry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: entry.isCurrentUser ? 6 : 2,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: entry.isCurrentUser
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            border: entry.isCurrentUser
                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                : null,
          ),
          child: Row(
            children: [
              // Rank
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getRankColor(entry.rank),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    _getRankDisplay(entry.rank),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: entry.rank <= 3 ? 18 : 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    entry.userAvatar.isNotEmpty ? entry.userAvatar : '👤',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.userName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: entry.isCurrentUser
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Level ${entry.level}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              // Points
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${entry.points}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[700],
                        ),
                  ),
                  Text(
                    'points',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
              if (entry.isCurrentUser) ...[
                SizedBox(width: 8),
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber[600]!; // Gold
      case 2:
        return Colors.grey[400]!; // Silver
      case 3:
        return Colors.brown[400]!; // Bronze
      default:
        return Colors.blue[400]!; // Default
    }
  }

  String _getRankDisplay(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '#$rank';
    }
  }
}
