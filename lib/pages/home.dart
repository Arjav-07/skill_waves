import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_waves/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  final List<Widget> _pages = [
    const Center(child: Text("Dashboard Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Inbox Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Wallet Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Settings Page", style: TextStyle(fontSize: 20))),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Icons.dashboard, "label": "Dashboard"},
    {"icon": Icons.inbox, "label": "Inbox"},
    {"icon": Icons.account_balance_wallet, "label": "Wallet"},
    {"icon": Icons.settings, "label": "Settings"},
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(int index) {
    bool isSelected = _selectedIndex == index;
    var item = _navItems[index];

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(30),
              )
            : null,
        child: Row(
          children: [
            Icon(
              item['icon'],
              size: 24,
              color: isSelected ? Colors.deepPurple : Colors.grey[400],
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                item['label'],
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  // Custom page transition widget
  Widget _animatedPage(Widget child, int index) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final inAnimation = Tween<Offset>(
                begin: Offset(index > _selectedIndex ? 1 : -1, 0), end: Offset.zero)
            .animate(animation);
        final fade = Tween<double>(begin: 0, end: 1).animate(animation);

        return SlideTransition(
          position: inAnimation,
          child: FadeTransition(opacity: fade, child: child),
        );
      },
      child: SizedBox(
        key: ValueKey<int>(_selectedIndex),
        width: double.infinity,
        height: double.infinity,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Skill Waves - LearnStream"),
        backgroundColor: Colors.deepPurple,
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
            ..._navItems.asMap().entries.map((entry) {
              int idx = entry.key;
              var item = entry.value;
              return ListTile(
                leading: Icon(item['icon']),
                title: Text(item['label']),
                onTap: () {
                  Navigator.pop(context);
                  _onNavItemTapped(idx);
                },
              );
            }).toList(),
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
      body: _animatedPage(_pages[_selectedIndex], _selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_navItems.length, (index) => _buildNavItem(index)),
        ),
      ),
    );
  }
}
