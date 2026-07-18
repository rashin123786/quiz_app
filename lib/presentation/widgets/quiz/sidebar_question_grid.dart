import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/bloc/quiz_bloc.dart';

class SidebarQuestionGrid extends StatelessWidget {
  const SidebarQuestionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is! QuizLoaded) return const SizedBox.shrink();

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(state.totalQuestions, (index) {
            final isAnswered = state.selectedAnswers.containsKey(index);
            final isCurrent = index == state.currentIndex;

            Color bg;
            Color textColor;

            if (isCurrent) {
              bg = AppColors.primary;
              textColor = Colors.white;
            } else if (isAnswered) {
              bg = AppColors.primaryLight;
              textColor = AppColors.primary;
            } else {
              bg = AppColors.surface;
              textColor = AppColors.text2;
            }

            return GestureDetector(
              onTap: () =>
                  context.read<QuizBloc>().add(QuizQuestionChanged(index)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isCurrent
                        ? AppColors.primary
                        : isAnswered
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : AppColors.border,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
