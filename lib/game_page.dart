import 'package:flutter/material.dart';

import 'shapes.dart';
import 'widgets/result_dialog.dart';
import 'widgets/score_bar.dart';
import 'widgets/shape_tray.dart';
import 'widgets/target_slot.dart';

const maxTrials = 4;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // Shapes still waiting in the tray. A target is "filled" once its shape leaves.
  List<ShapeType> _tray = ShapeType.values.toList()..shuffle();
  int _correct = 0;
  int _trials = 0;

  void _reset() {
    setState(() {
      _tray = ShapeType.values.toList()..shuffle();
      _correct = 0;
      _trials = 0;
    });
  }

  void _onDrop(ShapeType dragged, ShapeType target) {
    setState(() {
      _trials++;
      if (dragged == target) {
        _correct++;
        _tray.remove(dragged);
      }
    });
    if (_trials == maxTrials) {
      showResultDialog(
        context,
        correct: _correct,
        trials: _trials,
        onPlayAgain: _reset,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape Matching'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _reset),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8EAF6), Color(0xFFF8BBD0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // 1. Drop zones (DragTarget)
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (final t in targetShapes)
                        TargetSlot(
                          type: t,
                          filled: !_tray.contains(t),
                          onDrop: _onDrop,
                        ),
                    ],
                  ),
                ),
              ),
              // 2. Shapes to drag (Draggable inside DraggableScrollableSheet)
              Expanded(child: ShapeTray(shapes: _tray)),
              // 3. Score
              ScoreBar(
                correct: _correct,
                trials: _trials,
                maxTrials: maxTrials,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
