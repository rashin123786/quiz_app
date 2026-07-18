import '../../domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.question,
    required super.options,
    required super.correctIndex,
    required super.explanation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctIndex: json['correctIndex'] as int,
      explanation: json['explanation'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'options': options,
    'correctIndex': correctIndex,
    'explanation': explanation,
  };
}

class QuestionBank {
  static List<QuestionModel> get questions => [
    const QuestionModel(
      id: 0,
      question:
          'What is the primary programming language used to build Flutter apps?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctIndex: 2,
      explanation:
          'Flutter uses Dart, a language developed by Google. Dart is optimized for building fast apps on any platform and compiles to native ARM or x86 code for mobile/desktop and to JavaScript for the web.',
    ),
    const QuestionModel(
      id: 1,
      question:
          'Which widget in Flutter is used to create a scrollable list of items efficiently?',
      options: [
        'Column',
        'ListView.builder',
        'GridView',
        'SingleChildScrollView',
      ],
      correctIndex: 1,
      explanation:
          'ListView.builder creates items lazily — only building widgets that are currently visible on screen. This makes it highly efficient for long or infinite lists compared to Column, which builds all children at once.',
    ),
    const QuestionModel(
      id: 2,
      question: 'What does the "hot reload" feature in Flutter do?',
      options: [
        'Restarts the entire app from scratch',
        'Injects updated source code into the running app without losing state',
        'Clears the app cache',
        'Rebuilds the entire widget tree',
      ],
      correctIndex: 1,
      explanation:
          'Hot reload injects updated source code into the running Dart VM and rebuilds the widget tree, preserving the current app state. This is different from "hot restart" which restarts the app and resets state.',
    ),
    const QuestionModel(
      id: 3,
      question: 'In Flutter BLoC architecture, what is the role of an Event?',
      options: [
        'It represents the UI output',
        'It holds data to be stored locally',
        'It is an input to the BLoC that triggers state changes',
        'It is the same as a State',
      ],
      correctIndex: 2,
      explanation:
          'Events are inputs to the BLoC. When a user interacts with the UI (e.g., taps a button), an Event is dispatched to the BLoC using bloc.add(). The BLoC processes the event and emits a new State in response.',
    ),
    const QuestionModel(
      id: 4,
      question:
          'Which package is commonly used for dependency injection in Flutter clean architecture?',
      options: ['provider', 'get_it', 'riverpod', 'bloc'],
      correctIndex: 1,
      explanation:
          'get_it is a simple service locator for dependency injection in Flutter. It allows you to register classes and retrieve them anywhere in the app without needing BuildContext, making it ideal for clean architecture setups.',
    ),
    const QuestionModel(
      id: 5,
      question:
          'What is the purpose of the "const" keyword before a Flutter widget?',
      options: [
        'It makes the widget unmutable',
        'It tells Flutter to skip rebuilding the widget if its parameters haven\'t changed',
        'It improves network performance',
        'It converts the widget to a StatefulWidget',
      ],
      correctIndex: 1,
      explanation:
          'Using "const" before a widget constructor tells Flutter that the widget is compile-time constant. Flutter can reuse the same widget instance across rebuilds instead of creating a new one, improving performance especially in large widget trees.',
    ),
    const QuestionModel(
      id: 6,
      question:
          'In Flutter, what is the difference between StatelessWidget and StatefulWidget?',
      options: [
        'StatelessWidget can update its UI; StatefulWidget cannot',
        'StatefulWidget can hold mutable state and rebuild; StatelessWidget cannot',
        'They are identical in function',
        'StatelessWidget is faster but only for web',
      ],
      correctIndex: 1,
      explanation:
          'A StatefulWidget has an associated State object that persists across widget rebuilds and can call setState() to trigger UI updates. A StatelessWidget is immutable — its build method is only called once unless its parent rebuilds it with different parameters.',
    ),
    const QuestionModel(
      id: 7,
      question:
          'Which method must be called to persist data with SharedPreferences?',
      options: [
        'prefs.write()',
        'prefs.commit()',
        'prefs.setString() / prefs.setInt() etc.',
        'prefs.save()',
      ],
      correctIndex: 2,
      explanation:
          'SharedPreferences provides typed setter methods like setString(), setInt(), setBool(), and setDouble(). These return a Future<bool> indicating success. There is no generic write() or save() method — you must use the type-specific methods.',
    ),
    const QuestionModel(
      id: 8,
      question: 'What does GoRouter\'s "redirect" feature allow you to do?',
      options: [
        'Change app themes dynamically',
        'Guard routes and redirect users based on app state (e.g., auth)',
        'Navigate to external URLs',
        'Pre-fetch data before navigating',
      ],
      correctIndex: 1,
      explanation:
          'GoRouter\'s redirect callback runs before navigation completes and can return a different path to redirect to. It\'s commonly used for auth guards — if the user is not logged in and tries to navigate to a protected route, redirect sends them to the login screen.',
    ),
    const QuestionModel(
      id: 9,
      question:
          'What is the Repository pattern\'s main responsibility in clean architecture?',
      options: [
        'To render the UI',
        'To manage BLoC state',
        'To abstract the data source from the domain layer',
        'To handle HTTP requests directly',
      ],
      correctIndex: 2,
      explanation:
          'The Repository pattern acts as a single source of truth that abstracts where data comes from (API, cache, local DB). The domain layer only knows about the repository interface — it doesn\'t care whether data comes from a remote server or local storage. This makes the code testable and maintainable.',
    ),
  ];
}
