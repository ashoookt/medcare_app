import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //Navigation
        Positioned(
          bottom: 0,
          child: SizedBox(
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('lib/images/navigation.png', fit: BoxFit.cover),
          ),
        ),

        //Home
        Positioned(
          left: 90,
          bottom: 22,
          child: GestureDetector(
            onTap: () {},
            child: Image.asset('lib/images/Home.png', width: 36, height: 36),
          ),
        ),

        //Notes
        Positioned(
          right: 90,
          bottom: 22,
          child: GestureDetector(
            onTap: () {},
            child: Image.asset('lib/images/Notes.png', width: 36, height: 36),
          ),
        ),

        //ButtonPlus
        Positioned(
          bottom: 20,
          child: GestureDetector(
            onTap: () {},
            child: Image.asset(
              'lib/images/ButtonPlus.png',
              width: 105,
              height: 105,
            ),
          ),
        ),
      ],
    );
  }
}
