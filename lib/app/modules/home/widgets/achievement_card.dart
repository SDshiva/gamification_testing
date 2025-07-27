import 'package:flutter/material.dart';
import '../../../data/models/achievement_model.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback? onTap;

  const AchievementCard({
    super.key,
    required this.achievement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: achievement.isUnlocked ? 4 : 2,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: achievement.isUnlocked ? null : Colors.grey[100],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: achievement.isUnlocked
                          ? _getTypeColor(achievement.type).withOpacity(0.2)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        achievement.icon,
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              achievement.isUnlocked ? null : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: achievement.isUnlocked
                                        ? null
                                        : Colors.grey[600],
                                  ),
                        ),
                        Text(
                          achievement.description,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: achievement.isUnlocked
                                        ? null
                                        : Colors.grey[500],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (achievement.isUnlocked)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Unlocked',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              if (achievement.pointsReward > 0) ...[
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${achievement.pointsReward} points reward',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.amber[700],
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
              if (achievement.isUnlocked && achievement.unlockedAt != null) ...[
                SizedBox(height: 8),
                Text(
                  'Unlocked on ${_formatDate(achievement.unlockedAt!)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(AchievementType type) {
    switch (type) {
      case AchievementType.points:
        return Colors.blue;
      case AchievementType.streak:
        return Colors.orange;
      case AchievementType.challenge:
        return Colors.purple;
      case AchievementType.social:
        return Colors.green;
      case AchievementType.special:
        return Colors.red;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
