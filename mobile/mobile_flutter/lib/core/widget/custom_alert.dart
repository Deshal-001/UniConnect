import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uniconnect_app/core/network/token_controller.dart';

import '../constants/solid_colors.dart';

class CustomAlert {
  static Future<Object?> showSuccess(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Center(
              child: SizedBox(
                width: 220,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Center(
                    child: Text(
                      'Success!',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: Lottie.asset(
                    'assets/animations/Success_Check.json',
                    width: 80,
                    height: 80,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    );
  }

  static Future<Object?> showError(BuildContext context, String errorCode) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Center(
              child: SizedBox(
                width: 220,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: Center(
                    child: Text(
                      errorCode == '2006'
                          ? 'Not Allowed!'
                          : errorCode == '2007'
                              ? 'Already Booked!'
                              : 'Error!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: errorCode == '2007'
                            ? const Color(AppSolidColors.primary)
                            : Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: errorCode == '2007'
                      ? Lottie.asset(
                          'assets/animations/Success_Check.json',
                          width: 80,
                          height: 80,
                          fit: BoxFit.scaleDown,
                        )
                      : Lottie.asset(
                          'assets/animations/error.json',
                          width: 80,
                          height: 80,
                          fit: BoxFit.scaleDown,
                        ),
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    );
  }

  static Future<void> showTermsAndConditions(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Center(
              child: SizedBox(
                width: 400,
                height: 600,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Terms and Conditions',
                      style: TextStyle(
                        color: Color(AppSolidColors.primary),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: const SingleChildScrollView(
                    child: Text(
                      '1. Use of this app is intended for students, staff, and alumni of the university only.\n\n'
                      '2. By booking or attending events, you agree to abide by all university policies and codes of conduct.\n\n'
                      '3. Event details, times, and locations are subject to change. Please check for updates regularly.\n\n'
                      '4. Personal information collected is used solely for event management and will not be shared with third parties except as required by law.\n\n'
                      '5. The university reserves the right to deny access to events or remove users from the app for inappropriate behavior or misuse.\n\n'
                      '6. All content, logos, and materials in this app are property of the university and may not be reproduced without permission.\n\n'
                      '7. By using this app, you accept these terms. If you do not agree, please discontinue use immediately.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    );
  }

  static Future<bool?> showLogoutConfirm(BuildContext context) {
    return showGeneralDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Center(
              child: SizedBox(
                width: 300,
                height: 500,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/laoding3.json',
                        width: 80,
                        height: 80,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Are you sure you want to log out?',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            // backgroundColor: const Color(AppSolidColors.primary),
                            foregroundColor:
                                const Color(AppSolidColors.primary),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            TokenController.deleteTokens();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home',
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text('Logout',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    );
  }

  static Future<bool?> showDeleteAccountConfirm(BuildContext context) {
    return showGeneralDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Center(
              child: SizedBox(
                width: 300,
                height: 500,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Center(
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/laoding3.json', 
                        width: 80,
                        height: 80,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Are you sure you want to delete your account? This action cannot be undone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color(AppSolidColors.primary),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            TokenController.deleteTokens();
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    );
  }
static Future<void> showPrivacyPolicy(BuildContext context) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: Center(
            child: SizedBox(
              width: 400,
              height: 600,
              child: AlertDialog(
                shape: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                title: const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Privacy Policy',
                    style: TextStyle(
                      color: Color(AppSolidColors.primary),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content: const SingleChildScrollView(
                  child: Text(
                    '1. We respect your privacy and are committed to protecting your personal information.\n\n'
                    '2. Information collected through this app is used solely for event management and communication purposes.\n\n'
                    '3. We do not share your personal data with third parties except as required by law or university policy.\n\n'
                    '4. You may request deletion of your data at any time by contacting support.\n\n'
                    '5. By using this app, you consent to the collection and use of your information as described in this policy.',
                    textAlign: TextAlign.left,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink();
    },
  );
}
}
