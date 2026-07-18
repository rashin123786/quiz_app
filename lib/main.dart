import 'package:flutter/material.dart';
import 'package:quiz_app/config/injection/injection.dart';
import 'package:quiz_app/config/routes/app_router.dart';
import 'package:quiz_app/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Floreo Quiz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: appRouter,
    );
  }
}
