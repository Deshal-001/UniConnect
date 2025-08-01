import 'package:flutter/material.dart';
import 'package:uniconnect_app/core/widget/title_text.dart';

import '../../core/widget/custom_alert.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logout() {
    CustomAlert.showLogoutConfirm(context);
  }

  void _showTermsAndConditions() {
    CustomAlert.showTermsAndConditions(context);
  }

  void _showPrivacyPolicy() {
    CustomAlert.showPrivacyPolicy(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleTextWidget(title: 'Profile'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 32),
                  const CircleAvatar(
                    radius: 78,
                    backgroundImage: AssetImage('assets/images/pp.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Kavindu Deshal',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Terms and Conditions'),
                    onTap: _showTermsAndConditions,
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('Privacy Policy'),
                    onTap: _showPrivacyPolicy,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout',
                        style: TextStyle(color: Colors.red)),
                    onTap: _logout,
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Delete Account',
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      CustomAlert.showDeleteAccountConfirm(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
