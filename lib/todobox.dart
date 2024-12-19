import 'package:flutter/material.dart';

class Todobox extends StatelessWidget {
  final String name; // Updated naming
  final bool isChecked;
  final Function(bool?)? onChanged;

  const Todobox({
    super.key,
    required this.name,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
          Text(
            name,
            style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
