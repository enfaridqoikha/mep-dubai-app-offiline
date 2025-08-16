import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import '../models/models.dart';

class QuestionService {
  final _rand = Random();

  Future<List<Question>> loadAll() async {
    final manifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> map = json.decode(manifest);
    final paths = map.keys.where((k) => k.startsWith('assets/questions/') && k.endsWith('.json')).toList();

    final List<Question> all = [];
    for (final p in paths) {
      final txt = await rootBundle.loadString(p);
      final List data = json.decode(txt);
      all.addAll(data.map((e) => Question.fromJson(e)).toList());
    }

    all.addAll(_generateParamQuestions(20));
    all.shuffle(_rand);
    return all;
  }

  List<Question> _generateParamQuestions(int count) {
    final List<Question> qs = [];
    for (int i = 0; i < count; i++) {
      final double length = 15 + _rand.nextInt(36); // 15..50 m
      final double loadKW = 2 + _rand.nextInt(10); // 2..11 kW
      final double pf = [0.85, 0.9, 0.95][_rand.nextInt(3)];
      final double v = 230;
      final double ib = (loadKW * 1000) / (v * pf);
      final double vdLimit = 0.05; // 5% typical for final circuits
      final double maxDrop = v * vdLimit;
      final double mvaperampperm = 0.018; // example figure for copper 2-core @ 50Hz (illustrative)
      final double drop = ib * mvaperampperm * length;
      final double answer = (drop <= maxDrop) ? ib : ib * 1.25;
      final double rounded = (answer / 5).ceil() * 5;

      final choices = [
        Choice(id: 'A', text: '${(rounded - 10).clamp(5, 200)} A', isCorrect: false),
        Choice(id: 'B', text: '${(rounded - 5).clamp(5, 200)} A', isCorrect: false),
        Choice(id: 'C', text: '${rounded.toStringAsFixed(0)} A', isCorrect: true),
        Choice(id: 'D', text: '${(rounded + 5).clamp(5, 200)} A', isCorrect: false),
      ]..shuffle(_rand);

      qs.add(Question(
        id: 'dbc_param_$i',
        text: 'A {kw} kW single-phase load at 230 V, PF {pf}, cable length ~{len} m. '
              'What is the **minimum design current** (rounded to nearest 5 A) considering voltage-drop?'
            .replaceFirst('{kw}', loadKW.toStringAsFixed(0))
            .replaceFirst('{pf}', pf.toString())
            .replaceFirst('{len}', length.toStringAsFixed(0)),
        choices: choices,
        topic: 'Electrical — Sizing & Voltage Drop',
        ref: 'Align with Dubai practices & DBC coordination with DEWA for LV distribution.',
        explanation: 'I_b = P/(V×PF). Check voltage drop; upsize if needed. Round to standard sizes.',
      ));
    }
    return qs;
  }
}
