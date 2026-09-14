import 'package:flutter/material.dart';

class ActivityTwoScreen extends StatefulWidget {
  const ActivityTwoScreen({super.key});

  @override
  State<ActivityTwoScreen> createState() => _ActivityTwoScreenState();
}

class _ActivityTwoScreenState extends State<ActivityTwoScreen> {
  Color _selected = Colors.deepOrange;
  final List<Color> _palette = const [
    Colors.deepOrange,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity 2 — Color Picker')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;

            final preview = AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: isWide ? 260 : 180,
              decoration: BoxDecoration(
                color: _selected,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Text(
                  'Preview',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            );

            final grid = Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: _palette.map((c) {
                final selected = c == _selected; // ✅ FIXED — no .value
                return GestureDetector(
                  onTap: () => setState(() => _selected = c),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(color: Colors.black87, width: 3)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            );

            return Padding(
              padding: const EdgeInsets.all(20),
              child: isWide
                  ? Row(
                      children: [
                        Expanded(child: preview),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SingleChildScrollView(child: grid),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        preview,
                        const SizedBox(height: 24),
                        grid,
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}