import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_waves/pages/home.dart';
import 'package:skill_waves/pages/internship.dart';
import 'package:skill_waves/pages/login_page.dart';
import 'package:skill_waves/pages/setting.dart';
import 'package:skill_waves/pages/skills.dart';
import 'package:skill_waves/pages/profile.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDrawerHeader(),
              _buildDrawerItem(
                icon: Icons.home_rounded,
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (_) => const HomePage())
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.work_outline_rounded,
                title: 'Internships',
                onTap: () {
                  Navigator.pop(context);
                  // Use push instead of pushReplacement to maintain navigation stack
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const InternshipPage())
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.psychology_rounded,
                title: 'Skills',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const SkillPage())
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.person_outline_rounded,
                title: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const ProfilePage())
                  );
                },
              ),
              const Divider(color: Color(0xFF2D2D42), height: 32),
              _buildDrawerItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const SettingsPage())
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help & Support tapped!')),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                onTap: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color(0xFF0F0F23)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.waves, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            'SkillWaves',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Welcome back, User!',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 24),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}

// Add this to your main.dart to set the app-wide AppBar theme
/*
MaterialApp(
  theme: ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1A1A2E),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    // ... other theme properties
  ),
  home: HomePage(),
)
*/