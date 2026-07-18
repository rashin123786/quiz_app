import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class AnswerOption extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isLocked;
  final bool showResult;
  final VoidCallback? onTap;

  const AnswerOption({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isLocked,
    required this.showResult,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, borderColor, textColor, labelBg, labelText) =
        _resolveColors();

    final fontSize = context.rfs(14.5);

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            // Option label (A, B, C, D)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: labelBg,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                _label(index),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: labelText,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Option text
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ),

            // Result icon
            if (showResult && (isSelected || isCorrect)) ...[
              const SizedBox(width: 12),
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isCorrect ? AppColors.correct : AppColors.incorrect,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }

  (Color, Color, Color, Color, Color) _resolveColors() {
    if (showResult) {
      if (isCorrect) {
        return (
          AppColors.correctBg,
          AppColors.correctBorder,
          AppColors.correct,
          AppColors.correct.withValues(alpha: 0.15),
          AppColors.correct,
        );
      }
      if (isSelected && !isCorrect) {
        return (
          AppColors.incorrectBg,
          AppColors.incorrectBorder,
          AppColors.incorrect,
          AppColors.incorrect.withValues(alpha: 0.15),
          AppColors.incorrect,
        );
      }
    }

    if (isSelected) {
      return (
        AppColors.primaryLight,
        AppColors.primary,
        AppColors.primary,
        AppColors.primary.withValues(alpha: 0.15),
        AppColors.primary,
      );
    }

    return (
      AppColors.card,
      AppColors.border,
      AppColors.text1,
      AppColors.surface,
      AppColors.text2,
    );
  }

  String _label(int i) => ['A', 'B', 'C', 'D', 'E'][i];
}
