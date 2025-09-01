import 'package:flutter/material.dart';

void main() {
  runApp(const LearnStreamApp());
}

class LearnStreamApp extends StatelessWidget {
  const LearnStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnStream',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1724),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFFE6EEF6))),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("LearnStream"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Sign In", style: TextStyle(color: Colors.redAccent)),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Hero Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF071627), Color(0xFF071A25)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Learn anything, anytime",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "Short video lessons, curated playlists and interactive quizzes — organised like a streaming homepage so learning feels familiar and fast.",
                    style: TextStyle(color: Color(0xFF9AA4B2), fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  /// Search Box
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: "Search courses, topics or instructors",
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        child: const Text("Search"),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Text("🔥 Trending: JavaScript in 30 days | 📚 New: Design Thinking Essentials",
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 20),

                  /// Continue Watching
                  Card(
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Continue Watching",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1587620962725-abab7fe55159?auto=format&fit=crop&w=200&q=60",
                                  width: 90,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Intro to UI Design",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text("03:20 / 12:00 • Next: Prototyping",
                                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text("Recommended playlists:",
                              style: TextStyle(color: Colors.grey, fontSize: 12)),
                          const Wrap(
                            spacing: 8,
                            children: [
                              Pill(text: "Web Dev"),
                              Pill(text: "Data Science"),
                              Pill(text: "Design"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Featured Courses
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Featured Courses",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: const [
                      CourseCard(
                          title: "JavaScript Basics",
                          desc: "Build interactive websites with practical examples.",
                          lessons: "Beginner • 12 lessons",
                          img:
                              "https://images.unsplash.com/photo-1526378726155-5a6f6cc5b3d1?auto=format&fit=crop&w=800&q=60"),
                      CourseCard(
                          title: "Responsive Web Design",
                          desc: "Make beautiful sites that work on every screen.",
                          lessons: "Intermediate • 8 lessons",
                          img:
                              "https://images.unsplash.com/photo-1518779578993-ec3579fee39f?auto=format&fit=crop&w=800&q=60"),
                      CourseCard(
                          title: "Intro to Data",
                          desc: "From spreadsheets to insights — starter friendly.",
                          lessons: "Beginner • 10 lessons",
                          img:
                              "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=800&q=60"),
                      CourseCard(
                          title: "Design Thinking",
                          desc: "Empathy, ideation and prototyping techniques.",
                          lessons: "All levels • 6 lessons",
                          img:
                              "https://images.unsplash.com/photo-1526378726155-5a6f6cc5b3d1?auto=format&fit=crop&w=800&q=60"),
                    ],
                  )
                ],
              ),
            ),

            /// Categories
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Browse by Category",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      Pill(text: "Development"),
                      Pill(text: "Design"),
                      Pill(text: "Business"),
                      Pill(text: "Data & AI"),
                      Pill(text: "Personal Growth"),
                      Pill(text: "Language"),
                    ],
                  )
                ],
              ),
            ),

            /// Footer
            Container(
              width: double.infinity,
              color: const Color(0xFF0B1220),
              padding: const EdgeInsets.all(15),
              child: const Text(
                "©️ LearnStream • Built for learning, not just watching. • Terms • Privacy",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),

      /// Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

/// Course Card Widget
class CourseCard extends StatelessWidget {
  final String title, desc, lessons, img;
  const CourseCard({super.key, required this.title, required this.desc, required this.lessons, required this.img});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0B1220),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(img, height: 120, width: double.infinity, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 5),
                Text(lessons, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Pill Widget
class Pill extends StatelessWidget {
  final String text;
  const Pill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFF9AA4B2), fontSize: 13)),
    );
  }
}
