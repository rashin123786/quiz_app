import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../blocs/bloc/quiz_bloc.dart';
import '../../widgets/quiz/question_selector.dart';
import '../../widgets/quiz/quiz_nav_buttons.dart';
import '../../widgets/quiz/quiz_progress_bar.dart';
import '../../widgets/quiz/sidebar_question_grid.dart';
import '../../widgets/quiz/sidebar_legend.dart';
import '../../widgets/quiz/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.school_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Floreo Quiz',
              style: TextStyle(
                fontSize: context.rfs(17),
                fontWeight: FontWeight.w700,
                color: AppColors.text1,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is QuizError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.incorrect),
              ),
            );
          }

          if (state is QuizLoaded) {
            return ResponsiveLayout(
              mobile: _MobileLayout(),
              desktop: _DesktopLayout(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuizProgressBar(),
          const SizedBox(height: 16),
          const QuestionSelector(),
          const SizedBox(height: 20),
          const QuestionCard(),
          const SizedBox(height: 16),
          const QuizNavButtons(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContentConstraint(
      maxWidth: 1100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar — question number grid
            Container(
              width: 240,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Questions',
                    style: TextStyle(
                      fontSize: context.rfs(13),
                      fontWeight: FontWeight.w700,
                      color: AppColors.text2,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const SidebarQuestionGrid(),
                  const SizedBox(height: 20),
                  const SidebarLegend(),
                ],
              ),
            ),

            const SizedBox(width: 24),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const QuizProgressBar(),
                    const SizedBox(height: 20),
                    const QuestionCard(),
                    const SizedBox(height: 20),
                    const QuizNavButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
