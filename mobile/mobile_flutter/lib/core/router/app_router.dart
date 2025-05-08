import 'package:flutter/material.dart';
import 'package:uniconnect_app/feature/authentication/presentation/pages/welcome_page.dart';
import 'package:uniconnect_app/feature/authentication/presentation/pages/login_page.dart';
import 'package:uniconnect_app/feature/shared/splash_screen.dart';

import '../../feature/authentication/presentation/pages/sign_up_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contact = '/contact';


  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const WelcomePage(),
    login: (context) => const LoginPage(),
    register: (context) => const SignUpPage(),
    // profile: (context) => const ProfilePage(),
    // settings: (context) => const SettingsPage(),
    // about: (context) => const AboutPage(),
    // contact: (context) => const ContactPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
     if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(
          builder: routes[settings.name]!, settings: settings);
    } else {
      return _errorRoute('No route defined for ${settings.name}');
    }}
  
    static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home Screen',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SplashScreen()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  


  

  
