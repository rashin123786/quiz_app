import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../blocs/bloc/quiz_bloc.dart';
import 'answer_option.dart';
import 'explanation_card.dart';

// ─── Question Card ────────────────────────────────────────────────────────────

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is! QuizLoaded) return const SizedBox.shrink();

        final question = state.currentQuestion;
        final isAnswered = state.hasAnswered;
        final selectedAnswer = state.selectedAnswer;
        final showResult = isAnswered;

        return Card(
          child: Padding(
            padding: EdgeInsets.all(
              context.responsive(mobile: 20.0, desktop: 28.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question number badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Question ${state.currentIndex + 1}',
                    style: TextStyle(
                      fontSize: context.rfs(12),
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Question text
                Text(
                  question.question,
                  style: TextStyle(
                    fontSize: context.rfs(17),
                    fontWeight: FontWeight.w600,
                    color: AppColors.text1,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // Options
                ...List.generate(question.options.length, (i) {
                  return AnswerOption(
                    index: i,
                    text: question.options[i],
                    isSelected: selectedAnswer == i,
                    isCorrect: showResult && i == question.correctIndex,
                    isLocked: isAnswered,
                    showResult: showResult,
                    onTap: () => context.read<QuizBloc>().add(
                      QuizAnswerSelected(
                        questionIndex: state.currentIndex,
                        answerIndex: i,
                      ),
                    ),
                  );
                }),

                // Explanation — shown after answering
                if (isAnswered) ...[
                  const SizedBox(height: 8),
                  ExplanationCard(
                    explanation: question.explanation,
                    isCorrect: state.isCorrect(state.currentIndex),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
