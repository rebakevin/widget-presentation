import 'package:flutter/material.dart';

import '../shapes.dart';

/// A DragTarget placeholder that accepts a dragged shape.
class TargetSlot extends StatelessWidget {
  const TargetSlot({
    super.key,
    required this.type,
    required this.filled,
    required this.onDrop,
  });

  final ShapeType type;
  final bool filled;
  final void Function(ShapeType dragged, ShapeType target) onDrop;

  @override
  Widget build(BuildContext context) {
    return DragTarget<ShapeType>(
      onWillAcceptWithDetails: (_) => !filled,
      onAcceptWithDetails: (d) => onDrop(d.data, type),
      builder: (context, candidate, rejected) {
        return Container(
          width: 88,
          height: 88,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: candidate.isNotEmpty ? Colors.indigo.shade50 : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ShapeIcon(type, outline: !filled),
        );
      },
    );
  }
}
