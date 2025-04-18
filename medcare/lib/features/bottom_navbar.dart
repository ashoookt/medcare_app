import 'package:flutter/material.dart';
import 'package:medcare/features/home_screen.dart';
import 'package:medcare/features/notes_screen.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'lib/images/navigation.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Home Button
          Positioned(
            left: 90,
            bottom: 22,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // Navigate to the HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Image.asset(
                  'lib/images/Home.png',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),

          // Notes Button
          Positioned(
            right: 90,
            bottom: 22,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // Navigate to the NotesScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'lib/images/Notes.png',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),

          // Center Add (+) Button
          Positioned(
            bottom: 20,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(52),
                onTap: () {
                  // TODO: Add Plus button functionality
                },
                child: Image.asset(
                  'lib/images/ButtonPlus.png',
                  width: 105,
                  height: 105,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
