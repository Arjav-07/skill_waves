import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:skill_waves/pages/login_page.dart';
import 'package:skill_waves/pages/signup.dart' hide login_page;
import 'package:skill_waves/pages/forgotpassword.dart';
import 'package:skill_waves/pages/home.dart';
import 'package:skill_waves/utils/routes.dart';
import 'package:skill_waves/widget/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Waves',
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: MyRoutes.loginRoute,
      routes: {
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.SignUpPageRoute: (context) => const SignupPage(),
        MyRoutes.forgotPasswordRoute: (context) => const ForgotPasswordPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
      },
    );
  }
}
