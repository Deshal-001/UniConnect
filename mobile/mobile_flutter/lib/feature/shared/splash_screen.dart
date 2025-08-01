import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:lottie/lottie.dart';
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

// ...existing imports...

class _SplashScreenState extends State<SplashScreen> {
  int _selectedIndex = 0;
  bool _showMain = false;
  double _tabSpacing = 0.0;

  final List<Widget> _screens = const [
    EventListPage(),
    EventSearchPage(),
    BookedEventPage(),
    ProfilePage(),
  ];

  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    setState(() {
      _tabSpacing = offset > 100 ? 80 : 0;
    });
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final hasToken = await TokenController.hasToken();
    if (!mounted) return;
    if (hasToken) {
      setState(() => _showMain = true);
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_showMain) {
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

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (_) => false,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _screens,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: LiquidGlassLayer(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 18.0, left: 12, right: 12),
                child: LiquidGlass.inLayer(
                  shape: const LiquidRoundedSuperellipse(
                      borderRadius: Radius.circular(32)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNavTab(Icons.event, "Events", 0),
                          SizedBox(width: _tabSpacing),
                          _buildNavTab(Icons.search, "Search", 1),
                          SizedBox(width: _tabSpacing),
                          _buildNavTab(Icons.bookmark, "Booked", 2),
                          SizedBox(width: _tabSpacing),
                          _buildNavTab(Icons.person, "Profile", 3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTab(IconData icon, String label, int index) {
    final bool selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: LiquidGlass.inLayer(
        shape:
            const LiquidRoundedSuperellipse(borderRadius: Radius.circular(24)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: selected
                // ignore: deprecated_member_use
                ? Colors.white.withOpacity(0.10)
                // ignore: deprecated_member_use
                : Colors.white.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected
                    ? const Color(AppSolidColors.primary)
                    : Colors.grey,
                size: 26,
              ),
              if (selected) ...[
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(AppSolidColors.primary),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
