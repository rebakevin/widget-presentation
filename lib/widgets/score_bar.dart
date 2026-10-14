import 'package:flutter/material.dart';

class ScoreBar extends StatelessWidget {
  const ScoreBar({
    super.key,
    required this.correct,
    required this.trials,
    required this.maxTrials,
  });

  final int correct;
  final int trials;
  final int maxTrials;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Correct: $correct', style: style),
          Text('Trials: $trials / $maxTrials', style: style),
        ],
      ),
    );
  }
}
