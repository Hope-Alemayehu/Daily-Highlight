import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_highlight/models/highlight.dart';
import 'package:daily_highlight/services/storage_service.dart';

class HighlightInput extends StatefulWidget {
  const HighlightInput({Key? key}) : super(key: key);

  @override
  _HighlightInputState createState() => _HighlightInputState();
}

class _HighlightInputState extends State<HighlightInput> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _controller,
              maxLength: 140,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Today's highlight",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _submitHighlight,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your highlight';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _submitHighlight,
              child: const Text('Save Highlight'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitHighlight() async {
    if (_formKey.currentState!.validate()) {
      final highlight = Highlight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: _controller.text.trim(),
        date: DateTime.now(),
      );

      await Provider.of<StorageService>(
        context,
        listen: false,
      ).saveHighlight(highlight);

      _controller.clear();
      FocusScope.of(context).unfocus();

      // Refresh the list in parent widget
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Highlight saved!')));
      }
    }
  }
}
