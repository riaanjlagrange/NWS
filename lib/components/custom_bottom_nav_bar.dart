import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color:
            theme.bottomNavigationBarTheme.backgroundColor ??
            theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: theme.shadowColor.withOpacity(0.1)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: theme.colorScheme.primary.withOpacity(0.1),
            hoverColor: theme.colorScheme.primary.withOpacity(0.05),
            gap: 8,
            activeColor: theme.colorScheme.onPrimary,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 300),
            tabBackgroundColor: theme.colorScheme.primary,
            color: theme.iconTheme.color ?? theme.colorScheme.onSurface,
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.play_arrow, text: "Videos"),
              GButton(icon: Icons.photo, text: "Kata"),
              GButton(icon: Icons.face, text: "Profile"),
            ],
            selectedIndex: currentIndex,
            onTabChange: onTabSelected,
          ),
        ),
      ),
    );
  }
}
