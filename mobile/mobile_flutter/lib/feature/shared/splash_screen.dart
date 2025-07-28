import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';
import 'package:uniconnect_app/core/network/token_controller.dart';
import 'package:uniconnect_app/core/router/app_router.dart';
import 'package:uniconnect_app/feature/event/presentation/page/booked_event_page.dart';
import 'package:uniconnect_app/feature/shared/profile_screen.dart';
import '../event/presentation/page/event_list_page.dart';
import '../event/presentation/page/event_search_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<Widget> buildScreens() => [
      const EventListPage(),
      const EventSearchPage(),
      const BookedEventPage(),
      const ProfilePage()
    ];

List<PersistentBottomNavBarItem> navBarsItems() => [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.event, size: 20),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search, size: 25),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark, size: 25),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person, size: 25),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];

class _SplashScreenState extends State<SplashScreen> {
  final PersistentTabController _navBarController = PersistentTabController();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
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
            screens: buildScreens(),
            items: navBarsItems(),
            backgroundColor: Colors.grey.shade100,
            navBarHeight: 50,
            navBarStyle: NavBarStyle.style6,
          ),
        ),
      );
    } else {
      Logger().i('No token found, navigating to login');
      Navigator.pushReplacementNamed(context, AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppSolidColors.primary),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'UniConnect',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lalezar',
              ),
            ),
            Lottie.asset(
              'assets/animations/loadingfinal.json',
              width: 100,
              height: 100,
              fit: BoxFit.scaleDown,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
