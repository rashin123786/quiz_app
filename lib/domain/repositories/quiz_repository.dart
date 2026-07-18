import '../entities/question_entity.dart';

abstract class QuizRepository {
  Future<List<QuestionEntity>> getQuestions();

  Future<void> saveProgress({
    required Map<int, int> selectedAnswers,
    required int currentIndex,
  });

  Future<({Map<int, int> selectedAnswers, int currentIndex})?> loadProgress();

  Future<void> clearProgress();
}
