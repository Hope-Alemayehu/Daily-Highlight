import 'package:flutter/material.dart';
import '../models/highlight.dart';

class HighlightCard extends StatelessWidget {
  final Highlight highlight;
  final Function() onDelete;

  const HighlightCard({required this.highlight, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(highlight.text, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${highlight.date.day}/${highlight.date.month}/${highlight.date.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
