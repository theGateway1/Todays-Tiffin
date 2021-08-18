import 'dart:convert';

class Menu {
  int id;
  String i1;
  String i2;
  String i3;
  String i4;
  String i5;
  String i6;
  String i7;
  String i8;
  String updated;
  Menu({
    required this.id,
    required this.i1,
    required this.i2,
    required this.i3,
    required this.i4,
    required this.i5,
    required this.i6,
    required this.i7,
    required this.i8,
    required this.updated,
  });

  Menu copyWith({
    int? id,
    String? i1,
    String? i2,
    String? i3,
    String? i4,
    String? i5,
    String? i6,
    String? i7,
    String? i8,
    String? updated,
  }) {
    return Menu(
      id: id ?? this.id,
      i1: i1 ?? this.i1,
      i2: i2 ?? this.i2,
      i3: i3 ?? this.i3,
      i4: i4 ?? this.i4,
      i5: i5 ?? this.i5,
      i6: i6 ?? this.i6,
      i7: i7 ?? this.i7,
      i8: i8 ?? this.i8,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'i1': i1,
      'i2': i2,
      'i3': i3,
      'i4': i4,
      'i5': i5,
      'i6': i6,
      'i7': i7,
      'i8': i8,
      'updated': updated,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      i1: map['i1'],
      i2: map['i2'],
      i3: map['i3'],
      i4: map['i4'],
      i5: map['i5'],
      i6: map['i6'],
      i7: map['i7'],
      i8: map['i8'],
      updated: map['updated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Menu(id: $id, i1: $i1, i2: $i2, i3: $i3, i4: $i4, i5: $i5, i6: $i6, i7: $i7, i8: $i8, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menu &&
        other.id == id &&
        other.i1 == i1 &&
        other.i2 == i2 &&
        other.i3 == i3 &&
        other.i4 == i4 &&
        other.i5 == i5 &&
        other.i6 == i6 &&
        other.i7 == i7 &&
        other.i8 == i8 &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        i1.hashCode ^
        i2.hashCode ^
        i3.hashCode ^
        i4.hashCode ^
        i5.hashCode ^
        i6.hashCode ^
        i7.hashCode ^
        i8.hashCode ^
        updated.hashCode;
  }
}
