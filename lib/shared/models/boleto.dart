import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/services/database.dart';
import 'package:sqflite/sqflite.dart';

class Boleto {
  int? id;
  String name;
  String dueDate;
  double value;
  String barcode;
  bool wasPaid;
  static final observers = <VoidCallback>[];

  Boleto({
    required this.name,
    required this.dueDate,
    required this.value,
    required this.barcode,
    this.wasPaid = false,
  });

  static Future<Boleto?> find(int id) async {
    final boletoMaps = await DatabaseService.db.query(
      'boletos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (boletoMaps.isEmpty) return null;
    final boletoMap = boletoMaps[0];
    final boleto = Boleto.fromMap(boletoMap);
    id = boleto.id!;
    return boleto;
  }

  static Future<List<Boleto>> findAll() async {
    final boletoMaps = await DatabaseService.db.query('boletos');
    final boleto = boletoMaps.map((boleto) => fromMap(boleto)).toList();
    return boleto;
  }

  Future<void> save() async {
    final boletoId = await DatabaseService.db.insert(
      'boletos',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    id = boletoId;
    notifyAll();
  }

  Future<void> delete() async {
    await DatabaseService.db.delete(
      'boletos',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyAll();
  }

  void notifyAll() {
    for (final observer in observers) {
      observer();
    }
  }

  Map<String, dynamic> toMap() {
    if (id != null) {
      return {
        'id': id,
        'name': name,
        'dueDate': dueDate,
        'value': value,
        'barcode': barcode,
        'wasPaid': wasPaid,
      };
    }
    return {
      'name': name,
      'dueDate': dueDate,
      'value': value,
      'barcode': barcode,
      'wasPaid': wasPaid,
    };
  }

  static Boleto fromMap(Map<String, dynamic> map) {
    if (map['id'] != null) {
      final boleto = Boleto(
        name: map['name'],
        dueDate: map['dueDate'],
        value: map['value'],
        barcode: map['barcode'],
        wasPaid: map['wasPaid'] == 1,
      );
      boleto.id = map['id'];
      return boleto;
    }
    return Boleto(
      name: map['name'],
      dueDate: map['dueDate'],
      value: map['value'],
      barcode: map['barcode'],
      wasPaid: map['wasPaid'] == 1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Boleto &&
        other.name == name &&
        other.dueDate == dueDate &&
        other.value == value &&
        other.barcode == barcode &&
        other.wasPaid == wasPaid;
  }

  @override
  String toString() {
    return 'Boleto(id: $id, name: $name, dueDate: $dueDate, value: $value, barcode: $barcode, wasPaid: $wasPaid)';
  }

  @override
  int get hashCode {
    return name.hashCode ^
        dueDate.hashCode ^
        value.hashCode ^
        barcode.hashCode ^
        wasPaid.hashCode;
  }
}
