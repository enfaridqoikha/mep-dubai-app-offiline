import 'package:flutter/material.dart';
import '../models/models.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final void Function(bool correct) onAnswer;
  const QuestionCard({super.key, required this.question, required this.onAnswer});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? _selected;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question.topic, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(widget.question.text, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ...widget.question.choices.map((c) => RadioListTile<String>(
                  value: c.id, groupValue: _selected, title: Text(c.text),
                  onChanged: (v) => setState(() => _selected = v),
                )),
            const Spacer(),
            Row(children: [
              Flexible(child: Text('Ref: ${widget.question.ref}', style: Theme.of(context).textTheme.bodySmall)),
              const Spacer(),
              FilledButton(
                onPressed: _selected == null ? null : () {
                  final correct = widget.question.choices.firstWhere((e) => e.id == _selected!).isCorrect;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(correct ? 'Correct ✅' : 'Incorrect ❌')));
                  widget.onAnswer(correct);
                },
                child: const Text('Submit'),
              )
            ]),
            if (widget.question.explanation != null) ...[
              const SizedBox(height: 12),
              Text('Explanation: ${widget.question.explanation!}', style: Theme.of(context).textTheme.bodySmall),
            ]
          ],
        ),
      ),
    );
  }
}
