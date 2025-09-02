import 'package:flutter/material.dart';
import 'package:skill_waves/widget/app_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = true;
  bool _location = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F23),
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Account'),
            const SizedBox(height: 12),
            _buildCardItem(
              icon: Icons.person,
              title: 'Profile',
              subtitle: 'Update your profile information',
              onTap: () {},
            ),
            _buildCardItem(
              icon: Icons.lock,
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Preferences'),
            const SizedBox(height: 12),
            _buildSwitchItem(
              icon: Icons.notifications,
              title: 'Notifications',
              value: _notifications,
              onChanged: (val) {
                setState(() => _notifications = val);
              },
            ),
            _buildSwitchItem(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              value: _darkMode,
              onChanged: (val) {
                setState(() => _darkMode = val);
              },
            ),
            _buildSwitchItem(
              icon: Icons.location_on,
              title: 'Location Services',
              value: _location,
              onChanged: (val) {
                setState(() => _location = val);
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('More'),
            const SizedBox(height: 12),
            _buildCardItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get assistance and FAQs',
              onTap: () {},
            ),
            _buildCardItem(
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCardItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2D2D42)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D42)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6366F1),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }
}
