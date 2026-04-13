import 'package:flutter/material.dart';
import '../theme/berserk_colors.dart';
import '../l10n/app_strings.dart';

class BerserkNavBar extends StatelessWidget {
  const BerserkNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BerserkColors.bg.withOpacity(0.95),
        border: const Border(
          top: BorderSide(
            color: BerserkColors.separator,
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: S.profile,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center_outlined),
            activeIcon: const Icon(Icons.fitness_center),
            label: S.workouts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart),
            activeIcon: const Icon(Icons.show_chart),
            label: S.progress,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: S.settings,
          ),
        ],
      ),
    );
  }
}
