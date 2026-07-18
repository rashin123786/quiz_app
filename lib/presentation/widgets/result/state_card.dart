import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/responsive.dart';

import '../../../core/theme/app_theme.dart';

class StatsRow extends StatelessWidget {
  final int score;
  final int total;
  final int percent;

  const StatsRow({
    super.key,
    required this.score,
    required this.total,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final wrong = total - score;

    return Row(
      children: [
        _StatCard(
          label: 'Correct',
          value: '$score',
          color: AppColors.correct,
          bg: AppColors.correctBg,
        ),
        const SizedBox(width: 12),
        _StatCard(
          label: 'Incorrect',
          value: '$wrong',
          color: AppColors.incorrect,
          bg: AppColors.incorrectBg,
        ),
        const SizedBox(width: 12),
        _StatCard(
          label: 'Total',
          value: '$total',
          color: AppColors.primary,
          bg: AppColors.primaryLight,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color bg;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: context.rfs(24),
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: context.rfs(12),
                color: color.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
