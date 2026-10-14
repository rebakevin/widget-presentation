import 'package:flutter/material.dart';

String _grade(int correct) => switch (correct) {
      3 => 'A - Perfect!',
      2 => 'B - Great job',
      1 => 'C - Not bad',
      _ => 'F - Try again',
    };

Future<void> showResultDialog(
  BuildContext context, {
  required int correct,
  required int trials,
  required VoidCallback onPlayAgain,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('Game over'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_grade(correct),
              style: Theme.of(ctx).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Correct: $correct   Trials: $trials'),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx);
            onPlayAgain();
          },
          child: const Text('Play again'),
        ),
      ],
    ),
  );
}
