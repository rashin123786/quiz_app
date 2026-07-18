import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

abstract class QuizLocalDataSource {
  Future<void> saveProgress({
    required Map<int, int> selectedAnswers,
    required int currentIndex,
  });

  Future<({Map<int, int> selectedAnswers, int currentIndex})?> loadProgress();
  Future<void> clearProgress();
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  final SharedPreferences _prefs;

  QuizLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveProgress({
    required Map<int, int> selectedAnswers,
    required int currentIndex,
  }) async {
    final encodable = selectedAnswers.map((k, v) => MapEntry(k.toString(), v));
    await _prefs.setString(
      AppConstants.selectedAnswersKey,
      jsonEncode(encodable),
    );
    await _prefs.setInt(AppConstants.currentQuestionKey, currentIndex);
  }

  @override
  Future<({Map<int, int> selectedAnswers, int currentIndex})?>
  loadProgress() async {
    final answersJson = _prefs.getString(AppConstants.selectedAnswersKey);
    final index = _prefs.getInt(AppConstants.currentQuestionKey);

    if (answersJson == null) return null;

    final decoded = jsonDecode(answersJson) as Map<String, dynamic>;
    final answers = decoded.map((k, v) => MapEntry(int.parse(k), v as int));

    return (selectedAnswers: answers, currentIndex: index ?? 0);
  }

  @override
  Future<void> clearProgress() async {
    await _prefs.remove(AppConstants.selectedAnswersKey);
    await _prefs.remove(AppConstants.currentQuestionKey);
  }
}
