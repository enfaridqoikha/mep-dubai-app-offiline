import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme_manager.dart';
import 'screens/quiz_screen.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeController());

void main() => runApp(const ProviderScope(child: App()));

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'MEP Dubai — Exam Simulator',
      theme: theme.theme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEP Dubai — Exam Simulator'),
        actions: [
          IconButton(onPressed: theme.toggleDark, icon: const Icon(Icons.dark_mode)),
          PopupMenuButton<MaterialColor>(
            tooltip: 'Accent color',
            onSelected: (c) => theme.setAccent(c),
            itemBuilder: (ctx) => [
              Colors.blue, Colors.green, Colors.teal, Colors.deepPurple, Colors.orange, Colors.red
            ].map((c) => PopupMenuItem(value: c, child: CircleAvatar(backgroundColor: c))).toList(),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Practice DEWA-style Electrical, Mechanical & Plumbing questions.',
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizScreen())),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Exam'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
