import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  @override
  List<Object?> get props => [id, question, options, correctIndex];
}
