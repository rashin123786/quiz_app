import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../blocs/bloc/quiz_bloc.dart';

class QuestionSelector extends StatelessWidget {
  const QuestionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is! QuizLoaded) return const SizedBox.shrink();

        final bubbleSize = context.responsive<double>(
          mobile: 36,
          tablet: 38,
          desktop: 40,
        );

        return SizedBox(
          height: bubbleSize + 8,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: state.totalQuestions,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isAnswered = state.selectedAnswers.containsKey(index);
              final isCurrent = index == state.currentIndex;

              return _QuestionBubble(
                number: index + 1,
                isCurrent: isCurrent,
                isAnswered: isAnswered,
                isCorrect: isAnswered ? state.isCorrect(index) : null,
                showResult: state.isSubmitted,
                size: bubbleSize,
                onTap: () =>
                    context.read<QuizBloc>().add(QuizQuestionChanged(index)),
              );
            },
          ),
        );
      },
    );
  }
}

class _QuestionBubble extends StatelessWidget {
  final int number;
  final bool isCurrent;
  final bool isAnswered;
  final bool? isCorrect;
  final bool showResult;
  final double size;
  final VoidCallback onTap;

  const _QuestionBubble({
    required this.number,
    required this.isCurrent,
    required this.isAnswered,
    required this.isCorrect,
    required this.showResult,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;

    if (showResult && isAnswered) {
      bgColor = isCorrect! ? AppColors.correctBg : AppColors.incorrectBg;
      textColor = isCorrect! ? AppColors.correct : AppColors.incorrect;
      border = Border.all(
        color: isCorrect! ? AppColors.correctBorder : AppColors.incorrectBorder,
        width: 1.5,
      );
    } else if (isCurrent) {
      bgColor = AppColors.primary;
      textColor = Colors.white;
      border = null;
    } else if (isAnswered) {
      bgColor = AppColors.primaryLight;
      textColor = AppColors.primary;
      border = Border.all(color: AppColors.primary.withValues(alpha: 0.3));
    } else {
      bgColor = AppColors.selectorUnanswered;
      textColor = AppColors.text2;
      border = null;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(size / 4),
          border: border,
        ),
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 13,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
