import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skill_waves/models/chatbot.dart';
import 'package:skill_waves/pages/helpsupport.dart';
import 'package:skill_waves/pages/profileupdate.dart';
import 'firebase_options.dart';

import 'package:skill_waves/pages/login_page.dart';
import 'package:skill_waves/pages/signup.dart';
import 'package:skill_waves/pages/forgotpassword.dart';
import 'package:skill_waves/pages/home.dart';
import 'package:skill_waves/pages/internship.dart';
import 'package:skill_waves/pages/profile.dart';
import 'package:skill_waves/pages/setting.dart';
import 'package:skill_waves/pages/skills.dart';

import 'package:skill_waves/utils/routes.dart';
import 'package:skill_waves/widget/themes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Skill Waves',
      themeMode: ThemeMode.dark,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),

      // You can change this later to a splash screen
      initialRoute: MyRoutes.loginRoute, 

      routes: {
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signUpRoute: (context) => const SignupPage(),
        MyRoutes.forgotPasswordRoute: (context) => const ForgotPasswordPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.skillRoute: (context) => const SkillPage(),
        MyRoutes.internshipRoute: (context) => const InternshipPage(),
        MyRoutes.profileRoute: (context) => const ProfilePage(),
        MyRoutes.settingsRoute: (context) => const SettingsPage(),
        MyRoutes.helpSupportRoute: (context) => const HelpSupportPage(),
        MyRoutes.updateProfileRoute: (context) => const UpdateProfilePage(),
        MyRoutes.chatbotRoute: (context) => const ChatBotPage(),

      },

      // Optional: handle undefined routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("404 - Page Not Found")),
          ),
        );
      },
    );
  }
}
