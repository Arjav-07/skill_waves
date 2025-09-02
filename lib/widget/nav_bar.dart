import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const NavBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  late AnimationController _navController;
  late Animation<double> _navAnimation;

  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _navAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _navController, curve: Curves.elasticOut),
    );

    // Delay the nav bar animation
    Future.delayed(const Duration(milliseconds: 800), () {
      _navController.forward();
    });
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.work_outline_rounded, 'label': 'Internships'},
      {'icon': Icons.psychology_rounded, 'label': 'Skills'},
      {'icon': Icons.chat_bubble_outline_rounded, 'label': 'Chat'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _navController, curve: Curves.easeOutBack),
      ),
      child: ScaleTransition(
        scale: _navAnimation,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E).withOpacity(0.9),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: const Color(0xFF2D2D42).withOpacity(0.5),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: navItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isActive = widget.currentIndex == index;
                    
                    return _buildNavItem(
                      icon: item['icon'] as IconData,
                      label: item['label'] as String,
                      isActive: isActive,
                      onTap: () {
                        widget.onItemTapped(index);
                        _navController.forward(from: 0.9);
                        HapticFeedback.lightImpact();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive 
              ? const Color(0xFF6366F1).withOpacity(0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.white60,
              size: isActive ? 24 : 22,
            ),
            if (isActive) const SizedBox(width: 6),
            if (isActive) 
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}