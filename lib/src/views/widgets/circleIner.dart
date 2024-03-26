import 'package:flutter/material.dart';

class NestedCirclesPainter extends CustomPainter {
  final double posX;
  final double posY;
  final double radiusParent;
  final double radiusChild;
  Color? color;
  NestedCirclesPainter({
    required this.posX,
    required this.posY,
    required this.radiusParent,
    required this.radiusChild,
    this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.white12
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / posX, size.height / posY);

    final outerRadius = size.width / radiusParent;
    final innerRadius = size.width / radiusChild;

    canvas.drawCircle(center, outerRadius, paint);
    canvas.drawCircle(center, innerRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
