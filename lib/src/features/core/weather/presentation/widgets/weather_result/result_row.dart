import 'package:flutter/widgets.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({required this.title, required this.data, super.key});

  final String title;
  final String data;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Text>[
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
