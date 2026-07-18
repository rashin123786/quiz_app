import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class ExplanationCard extends StatelessWidget {
  final String explanation;
  final bool isCorrect;

  const ExplanationCard({
    super.key,
    required this.explanation,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.correct : AppColors.incorrect;
    final bgColor = isCorrect ? AppColors.correctBg : AppColors.incorrectBg;
    final borderColor = isCorrect
        ? AppColors.correctBorder
        : AppColors.incorrectBorder;
    final label = isCorrect ? 'Correct!' : 'Incorrect!';
    final icon = isCorrect
        ? Icons.check_circle_outline_rounded
        : Icons.highlight_off_rounded;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1.0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.rfs(14),
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Divider
            Divider(color: borderColor, thickness: 1, height: 0),

            const SizedBox(height: 10),

            // Explanation label
            Text(
              'Explanation',
              style: TextStyle(
                fontSize: context.rfs(11),
                fontWeight: FontWeight.w600,
                color: color.withValues(alpha: 0.7),
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 6),

            // Explanation text
            Text(
              explanation,
              style: TextStyle(
                fontSize: context.rfs(13.5),
                color: AppColors.text1,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
