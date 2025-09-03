import 'package:flutter/material.dart';
import 'package:skill_waves/utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F0F23),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Skill Waves",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _tile(context, Icons.home_outlined, "Home", MyRoutes.homeRoute),
          _tile(context, Icons.school_outlined, "Skills", MyRoutes.skillRoute),
          _tile(context, Icons.work_outline, "Internships", MyRoutes.internshipRoute),
          _tile(context, Icons.person_outline, "Profile", MyRoutes.profileRoute),
          _tile(context, Icons.settings_outlined, "Settings", MyRoutes.settingsRoute),
          const Divider(color: Colors.white12),
          _tile(context, Icons.logout, "Logout", MyRoutes.loginRoute, replace: true),
        ],
      ),
    );
  }

  ListTile _tile(BuildContext context, IconData icon, String title, String route, {bool replace = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        if (replace) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
