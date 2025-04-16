import 'package:flutter/material.dart';
import 'dart:math' as math;

class BottomNavbar extends StatelessWidget {
  final VoidCallback onFabPressed;

  const BottomNavbar({Key? key, this.onFabPressed = _defaultFabPressed})
    : super(key: key);

  static void _defaultFabPressed() {
    // Default behavior (does nothing)
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // The black background bar
        Container(height: 60, color: Colors.black),
        // The Diamond FAB floating above
        Positioned(
          bottom: 20, // Pushes it slightly above the navbar
          child: DiamondFAB(onPressed: onFabPressed),
        ),
      ],
    );
  }
}

class DiamondFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const DiamondFAB({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Center(
        child: ClipPath(
          clipper: DiamondClipper(),
          child: Material(
            elevation: 8,
            shadowColor: Colors.black,
            color: const Color(0xFF0F2D1E),
            child: InkWell(
              onTap: onPressed,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F2D1E), Color(0xFF1C4434)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: const Icon(Icons.add, color: Colors.white, size: 32),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
