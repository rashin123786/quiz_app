import '../../domain/entities/question_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_local_datasource.dart';
import '../models/question_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource _localDataSource;

  QuizRepositoryImpl(this._localDataSource);

  @override
  Future<List<QuestionEntity>> getQuestions() async {
    return QuestionBank.questions;
  }

  @override
  Future<void> saveProgress({
    required Map<int, int> selectedAnswers,
    required int currentIndex,
  }) => _localDataSource.saveProgress(
    selectedAnswers: selectedAnswers,
    currentIndex: currentIndex,
  );

  @override
  Future<({Map<int, int> selectedAnswers, int currentIndex})?> loadProgress() =>
      _localDataSource.loadProgress();

  @override
  Future<void> clearProgress() => _localDataSource.clearProgress();
}
