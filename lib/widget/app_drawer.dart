import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
  //     backgroundColor: const Color(0xFF1A1A2E),
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         _buildDrawerHeader(),
  //         _buildDrawerItem(
  //           icon: Icons.home_rounded,
  //           title: 'Home',
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.work_outline_rounded,
  //           title: 'Internships',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to internships');
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.psychology_rounded,
  //           title: 'Skills',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to skills');
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.school_rounded,
  //           title: 'Courses',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to courses');
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.chat_bubble_outline_rounded,
  //           title: 'Messages',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to messages');
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.person_outline_rounded,
  //           title: 'Profile',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to profile');
  //           },
  //         ),
  //         const Divider(color: Color(0xFF2D2D42), height: 32),
  //         _buildDrawerItem(
  //           icon: Icons.settings_outlined,
  //           title: 'Settings',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to settings');
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.help_outline_rounded,
  //           title: 'Help & Support',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Navigate to help');
  //           },
  //         ),
  //         _buildDrawerItem(
  //           icon: Icons.logout_rounded,
  //           title: 'Logout',
  //           onTap: () {
  //             Navigator.pop(context);
  //             print('Logout');
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDrawerHeader() {
  //   return DrawerHeader(
  //     decoration: const BoxDecoration(
  //       color: Color(0xFF0F0F23),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           width: 60,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             gradient: const LinearGradient(
  //               colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
  //             ),
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: const Icon(
  //             Icons.waves,
  //             color: Colors.white,
  //             size: 32,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         const Text(
  //           'SkillWaves',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         const Text(
  //           'Welcome back, User!',
  //           style: TextStyle(
  //             color: Colors.white70,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDrawerItem({
  //   required IconData icon,
  //   required String title,
  //   required VoidCallback onTap,
  // }) {
  //   return ListTile(
  //     leading: Icon(
  //       icon,
  //       color: Colors.white70,
  //       size: 24,
  //     ),
  //     title: Text(
  //       title,
  //       style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 16,
  //       ),
  //     ),
  //     onTap: onTap,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}