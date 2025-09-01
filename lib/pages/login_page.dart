import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_waves/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email & password")),
      );
      return;
    }

    try {
      setState(() => isLoading = true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() => isLoading = false);

      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _login,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.forgotPasswordRoute);
              },
              child: const Text("Forgot Password?"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.SignUpPageRoute);
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
