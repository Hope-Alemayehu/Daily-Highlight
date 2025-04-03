import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/highlight.dart';

class StorageService {
  static const _highlightsKey = 'highlights';

  Future<List<Highlight>> getHighlights() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_highlightsKey) ?? [];
    return jsonList
        .map((json) => Highlight.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveHighlight(Highlight highlight) async {
    final prefs = await SharedPreferences.getInstance();
    final highlights = await getHighlights();
    highlights.add(highlight);
    await prefs.setStringList(
      _highlightsKey,
      highlights.map((h) => jsonEncode(h.toJson())).toList(),
    );
  }

  Future<void> deleteHighlight(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final highlights = await getHighlights();
    highlights.removeWhere((h) => h.id == id);
    await prefs.setStringList(
      _highlightsKey,
      highlights.map((h) => jsonEncode(h.toJson())).toList(),
    );
  }
}
