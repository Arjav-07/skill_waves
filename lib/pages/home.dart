import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_waves/models/chatbot.dart';
import 'package:skill_waves/pages/internship.dart';
import 'package:skill_waves/pages/profile.dart';
import 'package:skill_waves/pages/skills.dart';// Make sure this import is correct
import 'package:skill_waves/widget/app_drawer.dart';
import 'package:skill_waves/widget/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();

    // Initialize pages
    _pages = [
      _buildHomeContent(),
      const InternshipPage(),
      const SkillPage(),
      ChatBotPage(isFullScreen: false), // Embedded chatbot
      const ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0F0F23),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content area with padding for navbar
            Padding(
              padding: const EdgeInsets.only(bottom: 16), // Space for nav bar
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _pages[_currentIndex],
              ),
            ),
            
            // Navbar positioned at bottom
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: NavBar(
                currentIndex: _currentIndex,
                onItemTapped: _onNavItemTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------
  // HOME SECTIONS
  // ------------------------

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          _buildHeroSection(),
          _buildMainFeatures(),
          _buildStatsSection(),
          _buildRecentUpdates(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: GestureDetector(
              onTap: _openDrawer,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.waves,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'SkillWaves',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2D2D42)),
              ),
              child: const Icon(Icons.notifications_outlined,
                  color: Colors.white70, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: const Text(
              'Welcome back! 👋',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          SlideTransition(
            position: _slideAnimation,
            child: const Text(
              'Ready to ride the next\nwave of opportunities?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMainFeatures() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: _featureCard(
              title: 'Find Internships',
              subtitle: 'Discover amazing opportunities',
              description: '500+ active internships from top companies',
              icon: Icons.work_outline,
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onTap: () => _onNavItemTapped(1),
            ),
          ),
          const SizedBox(height: 16),
          SlideTransition(
            position: _slideAnimation,
            child: _featureCard(
              title: 'Upgrade Skills',
              subtitle: 'Level up your expertise',
              description: '200+ courses from industry experts',
              icon: Icons.trending_up,
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onTap: () => _onNavItemTapped(2),
            ),
          ),
          const SizedBox(height: 16),
          SlideTransition(
            position: _slideAnimation,
            child: _featureCard(
              title: 'AI Chatbot',
              subtitle: 'Guidance at your fingertips',
              description: 'Ask about skills, careers & more',
              icon: Icons.chat_bubble_outline,
              gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onTap: () {
                // Navigate to full-screen chatbot
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBotPage(isFullScreen: true),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (gradient as LinearGradient).colors.first.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.white70, size: 16),
              ],
            ),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 16)),
            const SizedBox(height: 8),
            Text(description,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D42)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stat('Skills', '12', Icons.psychology),
          _stat('Applications', '8', Icons.send),
          _stat('Completed', '5', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF6366F1), size: 24),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentUpdates() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Updates',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('No recent updates available.',
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}