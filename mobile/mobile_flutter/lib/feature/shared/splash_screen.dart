import 'package:flutter/material.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(AppSolidColors.primary),
      body: Container(
        color: const Color(AppSolidColors.primary),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'UniConnect',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lalezar'
                ),
              ),
              Spacer(),
              // Text(
              //   'Connecting you to the world',
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Colors.white,
              //   ),
              // ),
             
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 20));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
  }
}