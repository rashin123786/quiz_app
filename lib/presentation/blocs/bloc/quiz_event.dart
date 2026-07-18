part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  @override
  List<Object?> get props => [];
}

class QuizStarted extends QuizEvent {
  const QuizStarted();
}

class QuizQuestionChanged extends QuizEvent {
  final int index;
  const QuizQuestionChanged(this.index);
  @override
  List<Object?> get props => [index];
}

class QuizAnswerSelected extends QuizEvent {
  final int questionIndex;
  final int answerIndex;
  const QuizAnswerSelected({
    required this.questionIndex,
    required this.answerIndex,
  });
  @override
  List<Object?> get props => [questionIndex, answerIndex];
}

class QuizNextPressed extends QuizEvent {
  const QuizNextPressed();
}

class QuizPreviousPressed extends QuizEvent {
  const QuizPreviousPressed();
}

class QuizSubmitted extends QuizEvent {
  const QuizSubmitted();
}

class QuizRetakePressed extends QuizEvent {
  const QuizRetakePressed();
}
