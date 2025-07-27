import 'package:flutter/material.dart';

class MobileTabButton extends StatelessWidget {
  final String title;
  final IconData outlinedIcon;
  final IconData filledIcon;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const MobileTabButton({
    super.key,
    required this.title,
    required this.outlinedIcon,
    required this.filledIcon,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 400;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding:
            EdgeInsets.symmetric(vertical: 12, horizontal: isCompact ? 4 : 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                isSelected ? filledIcon : outlinedIcon,
                key: ValueKey(isSelected),
                color: isSelected ? Colors.white : Colors.grey[600],
                size: isCompact ? 18 : 20,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: isCompact ? 9 : 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
