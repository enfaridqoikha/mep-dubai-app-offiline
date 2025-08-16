class Choice {
  final String id;
  final String text;
  final bool isCorrect;
  const Choice({required this.id, required this.text, required this.isCorrect});
  factory Choice.fromJson(Map<String, dynamic> json) =>
      Choice(id: json['id'], text: json['text'], isCorrect: json['isCorrect'] ?? false);
  Map<String, dynamic> toJson() => {'id': id, 'text': text, 'isCorrect': isCorrect};
}

class Question {
  final String id;
  final String text;
  final List<Choice> choices;
  final String topic;
  final String ref;
  final String? explanation;
  const Question({
    required this.id,
    required this.text,
    required this.choices,
    required this.topic,
    required this.ref,
    this.explanation,
  });
  factory Question.fromJson(Map<String, dynamic> json) {
    final cs = (json['choices'] as List).map((e) => Choice.fromJson(e)).toList();
    return Question(
      id: json['id'], text: json['text'], choices: cs,
      topic: json['topic'] ?? '', ref: json['ref'] ?? '', explanation: json['explanation'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id, 'text': text, 'choices': choices.map((e) => e.toJson()).toList(),
    'topic': topic, 'ref': ref, 'explanation': explanation
  };
}
