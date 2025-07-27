import 'package:flutter/material.dart';
import '../../../data/models/badge_model.dart' as badge_model;

class BadgeCard extends StatelessWidget {
  final badge_model.Badge badge;
  final VoidCallback? onTap;

  const BadgeCard({
    super.key,
    required this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: badge.isEarned ? 4 : 2,
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: badge.isEarned ? null : Colors.grey[100],
            border: badge.isEarned
                ? Border.all(color: _getRarityColor(badge.rarity), width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: badge.isEarned
                      ? _hexToColor(badge.color).withOpacity(0.2)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    badge.icon,
                    style: TextStyle(
                      fontSize: 20,
                      color: badge.isEarned ? null : Colors.grey[600],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Flexible(
                child: Text(
                  badge.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: badge.isEarned ? null : Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: _getRarityColor(badge.rarity).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge.rarityString.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (badge.isEarned) ...[
                SizedBox(height: 4),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 14,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getRarityColor(badge_model.BadgeRarity rarity) {
    switch (rarity) {
      case badge_model.BadgeRarity.common:
        return Colors.grey;
      case badge_model.BadgeRarity.rare:
        return Colors.blue;
      case badge_model.BadgeRarity.epic:
        return Colors.purple;
      case badge_model.BadgeRarity.legendary:
        return Colors.orange;
    }
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
