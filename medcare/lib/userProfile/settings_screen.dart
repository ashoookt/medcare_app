import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'termsService_screen.dart';
import 'privacyPolicy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D3B24),
              Color.fromARGB(255, 63, 95, 77),
              Color(0xFF0A1E14),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.grey),
            ),

            const SizedBox(height: 15),
            const Text(
              'Ashi Gloria',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'ashigloria@lorma.edu',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 35),

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    settingTile(
                      Icons.person,
                      'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    const Divider(thickness: 1, height: 1),
                    const SizedBox(height: 25),

                    settingTile(
                      Icons.notifications,
                      'Notifications',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    const Divider(thickness: 1, height: 1),
                    const SizedBox(height: 25),

                    settingTile(
                      Icons.article,
                      'Terms of Service',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsOfServiceScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),
                    const Divider(thickness: 1, height: 1),
                    const SizedBox(height: 25),

                    settingTile(
                      Icons.article,
                      'Privacy Policy',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacypolicyScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),
                    const Divider(thickness: 1, height: 1),
                    const SizedBox(height: 25),

                    const Spacer(),

                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 28,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      onTap: () {
                        // TODO: Add logout logic
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget settingTile(
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.grey[800], size: 24),
        ),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right, size: 26),
        onTap: onTap,
      ),
    );
  }
}
