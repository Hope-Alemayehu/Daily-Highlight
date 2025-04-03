import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_highlight/models/highlight.dart';
import 'package:daily_highlight/services/storage_service.dart';

class HighlightInput extends StatefulWidget {
  const HighlightInput({super.key});

  @override
  State<HighlightInput> createState() => _HighlightInputState();
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
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Today's highlight",
                contentPadding: EdgeInsets.all(16),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your highlight';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _saveHighlight,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveHighlight() async {
    if (_formKey.currentState!.validate()) {
      final highlight = Highlight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: _controller.text,
        date: DateTime.now(),
      );
      await Provider.of<StorageService>(
        context,
        listen: false,
      ).saveHighlight(highlight);
      Navigator.pop(context);
      _controller.clear();
    }
  }
}
