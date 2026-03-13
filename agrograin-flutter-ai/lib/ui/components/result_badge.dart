import 'package:flutter/material.dart';

class ResultBadge extends StatelessWidget {
  final String type;

  const ResultBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type.toLowerCase()) {
      case 'cereja':
        bg = Colors.green.shade100;
        fg = Colors.green.shade700;
        break;
      case 'verde':
        bg = Colors.lightGreen.shade100;
        fg = Colors.lightGreen.shade800;
        break;
      case 'passa':
        bg = Colors.yellow.shade100;
        fg = Colors.yellow.shade800;
        break;
      case 'seco':
        bg = Colors.brown.shade100;
        fg = Colors.brown.shade800;
        break;
      default:
        bg = Colors.grey.shade200;
        fg = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
