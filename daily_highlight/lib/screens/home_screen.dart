import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_highlight/models/highlight.dart';
import 'package:daily_highlight/services/storage_service.dart';
import 'package:daily_highlight/widgets/highlight_card.dart';
import 'package:daily_highlight/widgets/highlight_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Highlight'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Highlight>>(
        future: Provider.of<StorageService>(context).getHighlights(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final highlights = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: highlights.length,
            itemBuilder: (context, index) {
              final highlight = highlights[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(highlight.text),
                  subtitle: Text(
                    '${highlight.date.day}/${highlight.date.month}/${highlight.date.year}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteHighlight(context, highlight.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const HighlightInput(),
          ),
    );
  }

  Future<void> _deleteHighlight(BuildContext context, String id) async {
    await Provider.of<StorageService>(
      context,
      listen: false,
    ).deleteHighlight(id);
    setState(() {}); // Refresh UI
  }
}
