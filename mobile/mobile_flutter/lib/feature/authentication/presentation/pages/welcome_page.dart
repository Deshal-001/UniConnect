import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widget/custom_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Welcome Text Section
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Inter',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sign in or create a new account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),

                      // SVG Image Section
                      SvgPicture.asset(
                        'assets/icons/home_page_icon.svg',
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.8,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),

              // Buttons Section
              Column(
                children: [
                  CustomButton(
                    text: 'Sign in',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.login);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    color: Colors.white,
                    borderColor: Colors.black,
                    fontStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRouter.register);
                    },
                    richTextWidget: RichText(
                      text: const TextSpan(
                        text: 'No account yet? ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(AppSolidColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}