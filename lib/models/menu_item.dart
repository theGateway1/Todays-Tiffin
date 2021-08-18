import 'dart:convert';

class Menu {
  int id;
  String note;
  String updated;
  Menu({
    required this.id,
    required this.note,
    required this.updated,
  });

  Menu copyWith({
    int? id,
    String? note,
    String? updated,
  }) {
    return Menu(
      id: id ?? this.id,
      note: note ?? this.note,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': note,
      'updated': updated,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      note: map['body'],
      updated: map['updated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));

  @override
  String toString() => 'Menu(id: $id, note: $note, updated: $updated)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menu &&
        other.id == id &&
        other.note == note &&
        other.updated == updated;
  }

  @override
  int get hashCode => id.hashCode ^ note.hashCode ^ updated.hashCode;
}
