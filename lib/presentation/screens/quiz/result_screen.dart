import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../blocs/bloc/quiz_bloc.dart';
import '../../widgets/result/score_circle.dart';
import '../../widgets/result/state_card.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0 : (score / total * 100).round();
    final isPassed = percent >= 60;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        automaticallyImplyLeading: false,
        title: Text(
          'Quiz Complete',
          style: TextStyle(
            fontSize: context.rfs(17),
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
      ),
      body: Center(
        child: ContentConstraint(
          maxWidth: 520,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Score circle
                ScoreCircle(score: score, total: total, percent: percent),

                const SizedBox(height: 32),

                // Result message
                Text(
                  isPassed ? '🎉 Well done!' : 'Keep practising!',
                  style: TextStyle(
                    fontSize: context.rfs(24),
                    fontWeight: FontWeight.w700,
                    color: AppColors.text1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isPassed
                      ? 'You passed the quiz with a great score.'
                      : 'You scored below 60%. Review and try again.',
                  style: TextStyle(
                    fontSize: context.rfs(15),
                    color: AppColors.text2,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Stats row
                StatsRow(score: score, total: total, percent: percent),

                const SizedBox(height: 40),

                // Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<QuizBloc>().add(const QuizRetakePressed());
                      context.go('/quiz');
                    },
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(
                      'Retake Quiz',
                      style: TextStyle(fontSize: context.rfs(15)),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/quiz'),
                    icon: const Icon(Icons.visibility_rounded, size: 18),
                    label: Text(
                      'Review Answers',
                      style: TextStyle(fontSize: context.rfs(15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
