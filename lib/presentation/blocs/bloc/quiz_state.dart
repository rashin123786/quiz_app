part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuestionEntity> questions;
  final int currentIndex;
  final Map<int, int> selectedAnswers; // questionIndex → selectedOptionIndex
  final bool isSubmitted;

  const QuizLoaded({
    required this.questions,
    required this.currentIndex,
    required this.selectedAnswers,
    this.isSubmitted = false,
  });

  QuestionEntity get currentQuestion => questions[currentIndex];
  int get totalQuestions => questions.length;
  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == totalQuestions - 1;
  bool get hasAnswered => selectedAnswers.containsKey(currentIndex);
  int? get selectedAnswer => selectedAnswers[currentIndex];

  bool isCorrect(int questionIndex) {
    final selected = selectedAnswers[questionIndex];
    if (selected == null) return false;
    return selected == questions[questionIndex].correctIndex;
  }

  int get score =>
      selectedAnswers.entries.where((e) => isCorrect(e.key)).length;

  double get scorePercent =>
      totalQuestions == 0 ? 0 : (score / totalQuestions) * 100;

  QuizLoaded copyWith({
    List<QuestionEntity>? questions,
    int? currentIndex,
    Map<int, int>? selectedAnswers,
    bool? isSubmitted,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    questions,
    currentIndex,
    selectedAnswers,
    isSubmitted,
  ];
}

class QuizError extends QuizState {
  final String message;
  const QuizError(this.message);
  @override
  List<Object?> get props => [message];
}
