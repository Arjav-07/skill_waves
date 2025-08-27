import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:skill_waves/core/store.dart';
import 'package:skill_waves/pages/login_page.dart';
import 'package:skill_waves/pages/signup.dart';
import 'package:skill_waves/utils/routes.dart';
import 'package:skill_waves/widget/themes.dart';

void main() {
  runApp(VxState(store: MyStore(), child: const MyApp()));
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
        '/': (context) => const LoginPage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.SignUpPageRoute: (context) => const SignupPage(),
      },
    );
  }
}
