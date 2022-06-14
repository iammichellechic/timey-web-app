import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

     final path = Path();
    // (0, 0) // 1. Point
    path.lineTo(0, h); // 2. Point
    path.quadraticBezierTo(
      w * 0.25, // 3. Point
      h - 100, // 3. Point
      w * 0.5, // 4. Point
      h - 50, // 4. Point
    );
    path.quadraticBezierTo(
      w * 0.75, // 5. Point
      h, // 5. Point
      w, // 6. Point
      h - 100, // 6. Point
    );
    path.lineTo(w, 0); // 7. Point
    path.close();
    
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
