import 'package:flutter/material.dart';

class PrivacypolicyScreen extends StatelessWidget {
  const PrivacypolicyScreen({super.key});

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
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: const Text(
                    '''1. Introduction    
This Privacy Policy explains how the Nursing Documentation App collects, uses, and protects user data. By using the app, you consent to the collection and use of information as outlined in this policy.

2. Information We Collect    
We collect the following types of information:
Personal Information: Name, email address, and professional details provided during registration.
Medical Data: Patient records, vital signs, and documentation entered by users.
Usage Data: App activity, device information, and log files for performance monitoring.

3. How We Use Your Information   
We use collected data for the following purposes:
To facilitate patient documentation and medical record-keeping.
To provide technical support and improve app performance.
To ensure compliance with healthcare regulations.
To send important notifications related to user tasks and app updates.

4. Data Security     
We take strict measures to protect user data:
All personal and medical data is encrypted during storage and transmission.
Access to user information is restricted to authorized personnel only.
Regular security audits are conducted to prevent unauthorized access.

5. Data Sharing and Disclosure    
We do not sell or share personal information with third parties except in the following cases:
When required by law or regulatory authorities.
With healthcare institutions for compliance and reporting purposes (with user consent).
In the event of system maintenance or security investigations.

6. User Rights and Data Control    
Users have the right to:
Access, update, or delete their personal information.
Request data export for record-keeping purposes.
Withdraw consent and discontinue use of the app.

7. Data Retention    
User data is retained for as long as necessary to provide app functionality and comply with regulations. Users may request deletion of their data, subject to legal and institutional policies.

8. Third-Party Services    
The app may integrate with third-party services for cloud storage, notifications, or analytics. These services comply with relevant data protection laws.

9. Updates to This Policy     
We reserve the right to update this Privacy Policy. Users will be notified of significant changes through in-app notifications or email.

10. Contact Information     
For questions or concerns about this Privacy Policy, please contact support through the apps help center.''',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
