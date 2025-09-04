import 'package:flutter/material.dart';
import 'package:skill_waves/widget/app_drawer.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, String>> faqs = [
    {
      "question": "How can I apply for internships?",
      "answer":
          "You can browse the available internships in the app and click on 'Apply' to submit your application."
    },
    {
      "question": "Is Skill Waves free to use?",
      "answer":
          "Yes! Skill Waves is completely free for students. Companies may have premium options."
    },
    {
      "question": "Can I update my profile later?",
      "answer":
          "Absolutely. You can edit your profile anytime from the Profile section in the app."
    },
    {
      "question": "Do you provide certification?",
      "answer":
          "Yes, after completing verified internships or bootcamps, you will receive a certificate."
    },
    {
      "question": "How can I contact support?",
      "answer":
          "You can email us at support@skillwaves.com or use the 'Contact Us' option inside the app."
    },
  ];

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
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F23),
        elevation: 0,
        title: const Text(
          "HELP & SUPPORT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...faqs.map((faq) => _buildFaqItem(faq['question']!, faq['answer']!)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Need Help?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Find answers to common questions or reach out to our support team.",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D42)),
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.white54,
          iconColor: Colors.white,
          title: Text(
            question,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                answer,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
