import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';
import 'package:uniconnect_app/core/network/token_controller.dart';
import 'package:uniconnect_app/core/router/app_router.dart';
import '../event/presentation/page/event_list_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PersistentTabController _navBarController = PersistentTabController();

  List<Widget> _buildScreens() => [
        const EventListPage(),
        const EventListPage(),
        // Add other tab pages here
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.event, size: 20),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.event, size: 20),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        // Add other nav bar items here
      ];

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    final hasToken = await TokenController.hasToken();
    if (!mounted) return;
    if (hasToken) {
      Logger().i('Token found, navigating to home');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (newContext) => PersistentTabView(
            newContext,
            controller: _navBarController,
            screens: _buildScreens(),
            items: _navBarsItems(),
            backgroundColor: Colors.grey.shade100,
            navBarHeight: 50,
            navBarStyle: NavBarStyle.style6,
          ),
        ),
      );
    } else {
      Logger().i('No token found, navigating to login');
      Navigator.pushReplacementNamed(context, AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(AppSolidColors.primary),
      body: Center(
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
                fontFamily: 'Lalezar',
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}