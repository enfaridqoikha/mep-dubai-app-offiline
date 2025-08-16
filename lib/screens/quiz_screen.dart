import 'dart:async';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/question_service.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _svc = QuestionService();
  List<Question> _questions = [];
  int _i = 0;
  int _score = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final qs = await _svc.loadAll();
    setState(() {
      _questions = qs.take(50).toList(); // 50 per attempt
      _loading = false;
    });
  }

  void _onAnswer(bool correct) {
    if (correct) _score++;
    if (_i + 1 < _questions.length) {
      setState(() => _i++);
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Exam complete'),
      content: Text('Your score: $_score / ${_questions.length}'),
      actions: [
        TextButton(onPressed: () { Navigator.of(ctx).pop(); Navigator.of(context).pop(); }, child: const Text('Back')),
        FilledButton(onPressed: () { Navigator.of(ctx).pop(); setState(() { _i=0; _score=0; _loading=true; }); _load(); }, child: const Text('Retry')),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final q = _questions[_i];
    return Scaffold(
      appBar: AppBar(title: Text('Question ${_i+1}/${_questions.length}')),
      body: Padding(padding: const EdgeInsets.all(16), child: QuestionCard(question: q, onAnswer: _onAnswer)),
    );
  }
}
