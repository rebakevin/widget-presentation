import 'dart:math' as math;

import 'package:flutter/material.dart';

enum ShapeType { circle, square, triangle, star, rectangle }

const targetShapes = [ShapeType.circle, ShapeType.square, ShapeType.triangle];

Color _colorOf(ShapeType t) => switch (t) {
      ShapeType.circle => Colors.redAccent,
      ShapeType.square => Colors.teal,
      ShapeType.triangle => Colors.orange,
      ShapeType.star => Colors.amber,
      ShapeType.rectangle => Colors.purple,
    };

/// Draws a shape filled (solid) or as an outline (placeholder).
class ShapeIcon extends StatelessWidget {
  const ShapeIcon(this.type, {super.key, this.size = 64, this.outline = false});

  final ShapeType type;
  final double size;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _ShapePainter(type, outline),
    );
  }
}

class _ShapePainter extends CustomPainter {
  _ShapePainter(this.type, this.outline);

  final ShapeType type;
  final bool outline;

  @override
  void paint(Canvas canvas, Size s) {
    final color = outline ? Colors.grey.shade500 : _colorOf(type);
    final paint = Paint()
      ..color = color
      ..style = outline ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;
    final w = s.width, h = s.height;
    final pad = outline ? 2.0 : 0.0;

    switch (type) {
      case ShapeType.circle:
        canvas.drawCircle(Offset(w / 2, h / 2), w / 2 - pad, paint);
      case ShapeType.square:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(pad, pad, w - 2 * pad, h - 2 * pad),
            const Radius.circular(6),
          ),
          paint,
        );
      case ShapeType.rectangle:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(pad, h * 0.25, w - 2 * pad, h * 0.5),
            const Radius.circular(6),
          ),
          paint,
        );
      case ShapeType.triangle:
        canvas.drawPath(
          Path()
            ..moveTo(w / 2, pad)
            ..lineTo(w - pad, h - pad)
            ..lineTo(pad, h - pad)
            ..close(),
          paint,
        );
      case ShapeType.star:
        final path = Path();
        final c = Offset(w / 2, h / 2);
        final outer = w / 2, inner = w / 4.2;
        for (var i = 0; i < 10; i++) {
          final r = i.isEven ? outer : inner;
          final a = -math.pi / 2 + i * math.pi / 5;
          final p = c + Offset(math.cos(a), math.sin(a)) * r;
          i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
        }
        canvas.drawPath(path..close(), paint);
    }
  }

  @override
  bool shouldRepaint(_ShapePainter old) =>
      old.type != type || old.outline != outline;
}
