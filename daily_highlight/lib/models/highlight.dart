// data model class
class Highlight {
  final String id;
  final String text;
  final DateTime date;

  Highlight({required this.id, required this.text, required this.date});

  // convert to/from tJSON for storage

  Map<String, dynamic> toJSON() => {
    'id': id,
    'text': text,
    'date': date.toIso8601String(),
  };

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
    id: json['id'],
    text: json['text'],
    date: DateTime.parse(json['date']),
  );
}
