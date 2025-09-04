import 'package:flutter/material.dart';

class SkillDetailPage extends StatelessWidget {
  final String skillName;
  final String description;
  final String level; // Beginner, Intermediate, Advanced

  const SkillDetailPage({
    Key? key,
    required this.skillName,
    required this.description,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.4),
        elevation: 4,
        title: Text(
          skillName,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Difficulty Level
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  skillName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Example Modules / Topics
            const Text(
              "Key Topics Covered",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _topicTile("Introduction & Basics"),
            _topicTile("Hands-on Projects"),
            _topicTile("Advanced Concepts"),
            _topicTile("Career Opportunities"),
            const SizedBox(height: 30),

            // Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Redirecting to course material...")),
                  );
                },
                child: const Text(
                  "Learn More",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _topicTile(String topic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D42)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.deepPurpleAccent),
          const SizedBox(width: 12),
          Text(
            topic,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
