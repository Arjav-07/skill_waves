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
  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _navAnimation = CurvedAnimation(
      parent: _navController,
      curve: Curves.elasticOut,
    );

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
      ).animate(CurvedAnimation(parent: _navController, curve: Curves.easeOutBack)),
      child: ScaleTransition(
        scale: _navAnimation,
        child: Container(
          height: 64,
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
            borderRadius: BorderRadius.circular(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: navItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isActive = widget.currentIndex == index;
                  final isHovered = _hoveredIndex == index;

                  return MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = index),
                    onExit: (_) => setState(() => _hoveredIndex = -1),
                    child: _buildNavItem(
                      icon: item['icon'] as IconData,
                      label: item['label'] as String,
                      isActive: isActive,
                      isHovered: isHovered,
                      onTap: () {
                        widget.onItemTapped(index);
                        _navController.forward(from: 0);
                        HapticFeedback.lightImpact();
                      },
                    ),
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
    required bool isHovered,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive 
              ? const Color(0xFF6366F1).withOpacity(0.4) 
              : isHovered 
                  ? const Color(0xFF6366F1).withOpacity(0.2)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(24), // Smoother corners
          border: isHovered && !isActive
              ? Border.all(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  width: 1.5,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isActive 
                    ? Colors.white.withOpacity(0.2)
                    : isHovered
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isActive 
                    ? Colors.white 
                    : isHovered
                        ? Colors.white.withOpacity(0.9)
                        : Colors.white60,
                size: isActive ? 22 : 20,
              ),
            ),
            if (isActive) const SizedBox(width: 8),
            if (isActive)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isActive ? 1.0 : 0.0,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}