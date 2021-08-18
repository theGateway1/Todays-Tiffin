import 'dart:convert';

class Menu {
  int id;
  String note;
  Menu({
    required this.id,
    required this.note,
  });

  Menu copyWith({
    int? id,
    String? note,
  }) {
    return Menu(
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': note,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      note: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));

  @override
  String toString() => 'Menu(id: $id, note: $note)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menu && other.id == id && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ note.hashCode;
}
