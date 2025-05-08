import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uniconnect_app/core/constants/solid_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widget/custom_button.dart';

import '../../../../main.dart';
import '../widgets/language_item.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool languageChange = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.01,
            vertical: screenHeight * 0.02,
          ),
          child: Stack(
            children: [
              languageChange
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 48,
                        width: 110,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(AppSolidColors.primary),
                              width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                MyApp.setLocale(context, const Locale('en'));
                                toggleLanguageList();
                              },
                              child: LanguageItem(
                                assetPath: 'assets/icons/en_flag.svg',
                                languageName: loc.english,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                MyApp.setLocale(context, const Locale('de'));
                                toggleLanguageList();
                              },
                              child: LanguageItem(
                                assetPath: 'assets/icons/de_flag.svg',
                                languageName: loc.german,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 25,
                        width: 110,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(AppSolidColors.primary),
                              width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: toggleLanguageList,
                          child: loc.localeName == 'de'
                              ? LanguageItem(
                                  assetPath: 'assets/icons/de_flag.svg',
                                  languageName: loc.german,
                                )
                              : LanguageItem(
                                  assetPath: 'assets/icons/en_flag.svg',
                                  languageName: loc.english,
                                ),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.08,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              loc.welcomeTitle,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Inter',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              loc.welcomeSubtitle,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
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
                    Column(
                      children: [
                        CustomButton(
                          text: loc.signIn,
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
                            Navigator.pushNamed(context, AppRouter.register);
                          },
                          richTextWidget: RichText(
                            text: TextSpan(
                              text: "${loc.noAccount} ",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: loc.signUp,
                                  style: const TextStyle(
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
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleLanguageList() {
    setState(() {
      languageChange = !languageChange;
    });
  }
}
