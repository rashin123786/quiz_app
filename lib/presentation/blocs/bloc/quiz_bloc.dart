import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/question_entity.dart';
import '../../../domain/usecases/quiz_usecases.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestionsUseCase _getQuestions;
  final SaveProgressUseCase _saveProgress;
  final LoadProgressUseCase _loadProgress;
  final ClearProgressUseCase _clearProgress;

  QuizBloc({
    required GetQuestionsUseCase getQuestions,
    required SaveProgressUseCase saveProgress,
    required LoadProgressUseCase loadProgress,
    required ClearProgressUseCase clearProgress,
  }) : _getQuestions = getQuestions,
       _saveProgress = saveProgress,
       _loadProgress = loadProgress,
       _clearProgress = clearProgress,
       super(QuizInitial()) {
    on<QuizStarted>(_onStarted);
    on<QuizQuestionChanged>(_onQuestionChanged);
    on<QuizAnswerSelected>(_onAnswerSelected);
    on<QuizNextPressed>(_onNext);
    on<QuizPreviousPressed>(_onPrevious);
    on<QuizSubmitted>(_onSubmitted);
    on<QuizRetakePressed>(_onRetake);
  }

  Future<void> _onStarted(QuizStarted event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      final questions = await _getQuestions();
      final saved = await _loadProgress();

      emit(
        QuizLoaded(
          questions: questions,
          currentIndex: saved?.currentIndex ?? 0,
          selectedAnswers: saved?.selectedAnswers ?? {},
        ),
      );
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  void _onQuestionChanged(QuizQuestionChanged event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;
    final s = state as QuizLoaded;
    final updated = s.copyWith(currentIndex: event.index);
    emit(updated);
    _persist(updated);
  }

  void _onAnswerSelected(QuizAnswerSelected event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;
    final s = state as QuizLoaded;

    if (s.selectedAnswers.containsKey(event.questionIndex)) return;

    final updatedAnswers = Map<int, int>.from(s.selectedAnswers)
      ..[event.questionIndex] = event.answerIndex;

    final updated = s.copyWith(selectedAnswers: updatedAnswers);
    emit(updated);
    _persist(updated);
  }

  void _onNext(QuizNextPressed event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;
    final s = state as QuizLoaded;
    if (s.isLast) return;
    add(QuizQuestionChanged(s.currentIndex + 1));
  }

  void _onPrevious(QuizPreviousPressed event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;
    final s = state as QuizLoaded;
    if (s.isFirst) return;
    add(QuizQuestionChanged(s.currentIndex - 1));
  }

  Future<void> _onSubmitted(
    QuizSubmitted event,
    Emitter<QuizState> emit,
  ) async {
    if (state is! QuizLoaded) return;
    final s = state as QuizLoaded;
    final updated = s.copyWith(isSubmitted: true);
    emit(updated);
    _persist(updated);
  }

  Future<void> _onRetake(
    QuizRetakePressed event,
    Emitter<QuizState> emit,
  ) async {
    await _clearProgress();
    add(const QuizStarted());
  }

  Future<void> _persist(QuizLoaded state) async {
    await _saveProgress(
      selectedAnswers: state.selectedAnswers,
      currentIndex: state.currentIndex,
    );
  }
}
