import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/quiz_local_datasource.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/usecases/quiz_usecases.dart';
import '../../presentation/blocs/bloc/quiz_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Data sources
  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetQuestionsUseCase(sl()));
  sl.registerLazySingleton(() => SaveProgressUseCase(sl()));
  sl.registerLazySingleton(() => LoadProgressUseCase(sl()));
  sl.registerLazySingleton(() => ClearProgressUseCase(sl()));

  // BLoC
  sl.registerFactory(
    () => QuizBloc(
      getQuestions: sl(),
      saveProgress: sl(),
      loadProgress: sl(),
      clearProgress: sl(),
    ),
  );
}
