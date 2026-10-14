import 'package:flutter/material.dart';

import '../shapes.dart';

/// Bottom sheet holding the draggable shapes.
class ShapeTray extends StatelessWidget {
  const ShapeTray({super.key, required this.shapes});

  final List<ShapeType> shapes;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.35,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Drag a shape up!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: [for (final t in shapes) _DraggableShape(t)],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DraggableShape extends StatelessWidget {
  const _DraggableShape(this.type);

  final ShapeType type;

  @override
  Widget build(BuildContext context) {
    return Draggable<ShapeType>(
      data: type,
      feedback: Material(
        color: Colors.transparent,
        child: Transform.scale(scale: 1.2, child: ShapeIcon(type)),
      ),
      childWhenDragging: Opacity(opacity: 0.25, child: ShapeIcon(type)),
      child: ShapeIcon(type),
    );
  }
}
