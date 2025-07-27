import 'package:flutter/material.dart';
import '../../../data/models/challenge_model.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback? onTap;

  const ChallengeCard({
    super.key,
    required this.challenge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: challenge.isCompleted
                  ? LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.1),
                        Colors.green.withOpacity(0.05)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : challenge.isExpired
                      ? LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.1),
                            Colors.grey.withOpacity(0.05)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getTypeColor(challenge.type).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          challenge.icon,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  challenge.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(challenge.status),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _getStatusText(challenge.status),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            challenge.description,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Progress Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '${challenge.currentProgress}/${challenge.targetValue}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: 8,
                            width: MediaQuery.of(context).size.width *
                                0.7 *
                                challenge.progressPercentage,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: challenge.isCompleted
                                    ? [Colors.green, Colors.green[700]!]
                                    : [
                                        _getTypeColor(challenge.type),
                                        _getTypeColor(challenge.type)
                                            .withOpacity(0.7)
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(challenge.progressPercentage * 100).toInt()}% Complete',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (challenge.isCompleted)
                            Icon(Icons.check_circle,
                                color: Colors.green, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Bottom Info Row
                Row(
                  children: [
                    if (challenge.pointsReward > 0) ...[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.amber.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star,
                                color: Colors.amber[700], size: 16),
                            SizedBox(width: 4),
                            Text(
                              '${challenge.pointsReward} pts',
                              style: TextStyle(
                                color: Colors.amber[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                    ],
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getTypeColor(challenge.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color:
                                _getTypeColor(challenge.type).withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,
                              color: _getTypeColor(challenge.type), size: 16),
                          SizedBox(width: 4),
                          Text(
                            _getTimeRemaining(),
                            style: TextStyle(
                              color: _getTypeColor(challenge.type),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getTypeColor(challenge.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        challenge.typeString.toUpperCase(),
                        style: TextStyle(
                          color: _getTypeColor(challenge.type),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(ChallengeType type) {
    switch (type) {
      case ChallengeType.daily:
        return Colors.blue;
      case ChallengeType.weekly:
        return Colors.orange;
      case ChallengeType.monthly:
        return Colors.purple;
      case ChallengeType.special:
        return Colors.red;
    }
  }

  Color _getStatusColor(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.active:
        return Colors.blue;
      case ChallengeStatus.completed:
        return Colors.green;
      case ChallengeStatus.expired:
        return Colors.grey;
      case ChallengeStatus.upcoming:
        return Colors.orange;
    }
  }

  String _getStatusText(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.active:
        return 'ACTIVE';
      case ChallengeStatus.completed:
        return 'COMPLETED';
      case ChallengeStatus.expired:
        return 'EXPIRED';
      case ChallengeStatus.upcoming:
        return 'UPCOMING';
    }
  }

  String _getTimeRemaining() {
    if (challenge.isCompleted) {
      return 'Completed';
    }

    if (challenge.isExpired) {
      return 'Expired';
    }

    final now = DateTime.now();
    final difference = challenge.endDate.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays}d left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m left';
    } else {
      return 'Ending soon';
    }
  }
}
