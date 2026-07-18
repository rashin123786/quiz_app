import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../blocs/bloc/quiz_bloc.dart';

class QuizNavButtons extends StatelessWidget {
  const QuizNavButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is! QuizLoaded) return const SizedBox.shrink();

        final isLast = state.isLast;
        final allAnswered =
            state.selectedAnswers.length == state.totalQuestions;

        return Row(
          children: [
            // Previous button
            if (!state.isFirst) ...[
              OutlinedButton.icon(
                onPressed: () =>
                    context.read<QuizBloc>().add(const QuizPreviousPressed()),
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: Text(
                  'Previous',
                  style: TextStyle(fontSize: context.rfs(14)),
                ),
              ),
              const SizedBox(width: 12),
            ],

            const Spacer(),

            // Next or Submit
            if (isLast && allAnswered)
              ElevatedButton.icon(
                onPressed: () {
                  context.read<QuizBloc>().add(const QuizSubmitted());
                  final s = context.read<QuizBloc>().state as QuizLoaded;
                  context.push(
                    '/result',
                    extra: {'score': s.score, 'total': s.totalQuestions},
                  );
                },
                icon: const Icon(Icons.check_rounded, size: 18),
                label: Text(
                  'Submit Quiz',
                  style: TextStyle(fontSize: context.rfs(14)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.correct,
                ),
              )
            else if (!isLast)
              ElevatedButton.icon(
                onPressed: () =>
                    context.read<QuizBloc>().add(const QuizNextPressed()),
                icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: Text(
                  'Next',
                  style: TextStyle(fontSize: context.rfs(14)),
                ),
              )
            else
              // Last question but not all answered
              ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.lock_outline_rounded, size: 18),
                label: Text(
                  'Answer all questions',
                  style: TextStyle(fontSize: context.rfs(13)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.text3,
                ),
              ),
          ],
        );
      },
    );
  }
}
