import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_highlight/models/highlight.dart';
import 'package:daily_highlight/services/storage_service.dart';
// import 'package:daily_highlight/widgets/highlight_card.dart';
import 'package:daily_highlight/widgets/highlight_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Highlight>> _highlightsFuture;

  @override
  void initState() {
    super.initState();
    _refreshHighlights();
  }

  void _refreshHighlights() {
    setState(() {
      _highlightsFuture =
          Provider.of<StorageService>(context, listen: false).getHighlights();
    });
  }

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
      body: RefreshIndicator(
        onRefresh: () async => _refreshHighlights(),
        child: FutureBuilder<List<Highlight>>(
          future: _highlightsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final highlights = snapshot.data ?? [];
            return ListView.builder(
              itemCount: highlights.length,
              itemBuilder: (context, index) {
                final highlight = highlights[index];
                return ListTile(
                  title: Text(highlight.text),
                  subtitle: Text(highlight.date.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteHighlight(highlight.id),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const HighlightInput(),
      isScrollControlled: true,
    );
  }

  Future<void> _deleteHighlight(String id) async {
    await Provider.of<StorageService>(
      context,
      listen: false,
    ).deleteHighlight(id);
    _refreshHighlights();
  }
}
