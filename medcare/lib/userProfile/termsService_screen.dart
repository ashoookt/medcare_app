import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
              const SizedBox(height: 50), // 👈 Less sagad arrow+title
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
                        'Terms of Service',
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
              const SizedBox(height: 50), // 👈 Space between title and content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: const Text(
                    '''1. Introduction
Welcome to Medcare. The following Terms of Service shall apply to your use of the app and lay the grounds for your rights and obligations as a user. Every time you access or use the app, you legally agree to the terms. If you don't do so, please avoid using the app.

2. User Eligibility
This application is made for nursing interns, students, and healthcare professionals. You must be 18 years old or have the consent of an educational institution or employer to use this app.

3. User Responsibilities
• You are responsible for the accuracy of all patient data you have entered.
• You will be required to comply with all applicable medical documentation and confidentiality laws, including HIPAA or any other regional health laws.
• Do not share your login credentials with others or allow access to your account by unauthorized individuals.
• Use this app solely for its intended purpose: recording and managing patient medical data in an educational or professional setting.

4. Privacy and Data Security
The application is strict in protecting patient data.
All personal and medical information keyed into the application is encrypted and securely stored.
The maintenance of confidentiality regarding login credentials is the liability of users.
The application does not sell or share personal data with third parties without consent, except where required by law.

5. Restricted Activities
Users are prohibited from:
• Making any false or misleading entry related to patient data.
• Using the app for non-medical, illegal, or unauthorized purposes.
• Attempting to hack, tamper with, or disrupt the operation of the application.

6. Limitations of Liability
The application is a tool to assist medical documentation but does not replace professional judgment.
The developers are not responsible for incorrect entries, omissions, or misuse of data entered into the application.
Users assume full responsibility for complying with medical regulations and institutional policies.

7. Updates and Modifications
The developers of the app reserve the right to update or alter these Terms of Service at any time.
Continued use of the application following changes amounts to acceptance.

8. Denial of Access
The application reserves the right to suspend or terminate a user's access due to violations of these terms.
Users can delete their accounts whenever they wish to stop using the app.

9. Contact Information
In case of any inquiries or comments regarding these Terms of Service, please contact support through the app's help center.
Using this app implies that you have read these terms, understood them, and agreed to comply with them.''',
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
