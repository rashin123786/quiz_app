import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../config/injection/injection.dart';
import '../../presentation/blocs/bloc/quiz_bloc.dart';
import '../../presentation/screens/quiz/quiz_screen.dart';
import '../../presentation/screens/quiz/result_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/quiz',
  routes: [
    ShellRoute(
      builder: (context, state, child) => BlocProvider(
        create: (_) => sl<QuizBloc>()..add(const QuizStarted()),
        child: child,
      ),
      routes: [
        GoRoute(path: '/quiz', builder: (context, state) => const QuizScreen()),
        GoRoute(
          path: '/result',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ResultScreen(
              score: extra?['score'] as int? ?? 0,
              total: extra?['total'] as int? ?? 0,
            );
          },
        ),
      ],
    ),
  ],
);
