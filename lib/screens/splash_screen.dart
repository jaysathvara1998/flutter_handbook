import 'package:flutter/material.dart';
import 'package:flutter_handbook/core/constants/color_constants.dart';
import 'package:flutter_handbook/core/constants/route_constants.dart';
import 'package:flutter_handbook/core/utils/navigation_util.dart';
import 'package:flutter_handbook/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      NavigationUtil.goToPath(Routes.home);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final primaryColor = brightness == Brightness.light
        ? ColorConstants.primaryLight
        : ColorConstants.primaryDark;

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 120,
                color: primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Flutter Handbook',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: primaryColor,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your Complete Flutter Guide',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
