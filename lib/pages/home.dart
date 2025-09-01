import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_waves/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  final List<Widget> _pages = [
    const Center(child: Text("Home Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Profile Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Settings Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Wallet Page", style: TextStyle(fontSize: 20))),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        size: 28,
        color: _selectedIndex == index ? Colors.teal : Colors.grey[400],
      ),
      onPressed: () => _onNavItemTapped(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows FAB to float above the bottom app bar
      appBar: AppBar(
        title: const Text("Skill Waves - LearnStream"),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? "User"),
              accountEmail: Text(user?.email ?? "No Email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  (user?.displayName?.substring(0, 1) ?? "U").toUpperCase(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00BFA6), Color(0xFF1DE9B6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                _onNavItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                _onNavItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                _onNavItemTapped(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Wallet"),
              onTap: () {
                Navigator.pop(context);
                _onNavItemTapped(3);
              },
            ),
            const Spacer(),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],

      // Floating curved nav bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onNavItemTapped(3), // Wallet Page
        backgroundColor: Colors.teal,
        child: const Icon(Icons.attach_money, size: 28),
        elevation: 4,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Creates notch for FAB
        notchMargin: 6,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.person, 1),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(Icons.settings, 2),
              _buildNavItem(Icons.list, 3), // Optional extra icon
            ],
          ),
        ),
      ),
    );
  }
}
