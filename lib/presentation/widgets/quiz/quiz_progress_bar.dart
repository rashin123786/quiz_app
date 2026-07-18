import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../blocs/bloc/quiz_bloc.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is! QuizLoaded) return const SizedBox.shrink();

        final progress = state.selectedAnswers.length / state.totalQuestions;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${state.currentIndex + 1} of ${state.totalQuestions}',
                  style: TextStyle(
                    fontSize: context.rfs(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.text2,
                  ),
                ),
                Text(
                  '${state.selectedAnswers.length} answered',
                  style: TextStyle(
                    fontSize: context.rfs(13),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}
