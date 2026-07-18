import '../entities/question_entity.dart';
import '../repositories/quiz_repository.dart';

class GetQuestionsUseCase {
  final QuizRepository _repository;
  GetQuestionsUseCase(this._repository);

  Future<List<QuestionEntity>> call() => _repository.getQuestions();
}

class SaveProgressUseCase {
  final QuizRepository _repository;
  SaveProgressUseCase(this._repository);

  Future<void> call({
    required Map<int, int> selectedAnswers,
    required int currentIndex,
  }) =>
      _repository.saveProgress(
        selectedAnswers: selectedAnswers,
        currentIndex: currentIndex,
      );
}

class LoadProgressUseCase {
  final QuizRepository _repository;
  LoadProgressUseCase(this._repository);

  Future<({Map<int, int> selectedAnswers, int currentIndex})?> call() =>
      _repository.loadProgress();
}

class ClearProgressUseCase {
  final QuizRepository _repository;
  ClearProgressUseCase(this._repository);

  Future<void> call() => _repository.clearProgress();
}
