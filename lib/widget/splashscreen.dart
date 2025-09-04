import 'package:flutter/material.dart';
import 'package:skill_waves/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Logo scale and rotation animation
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Fade out animation
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Start logo animation immediately
    _logoController.forward();
    
    // Wait for 2.5 seconds total (logo animation + delay)
    await Future.delayed(const Duration(milliseconds: 2500));
    
    // Start fade out animation
    _fadeController.forward();
    
    // Wait for fade animation to complete then navigate
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Same as login page
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E293B),
                Color(0xFF0F172A),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoAnimation.value,
                      child: Transform.rotate(
                        angle: _logoAnimation.value * 0.5, // Slight rotation
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6366F1),
                                Color(0xFF8B5CF6),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.waves,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // App Name with fade in animation
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value,
                      child: const Text(
                        "SkillWaves",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 8),
                
                // Tagline
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value * 0.7,
                      child: const Text(
                        "Ride the Wave of Learning",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Loading indicator
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value,
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}