import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/models/boleto.dart';

class InsertBoletoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  get form => formKey.currentState!;

  String name = '';
  String dueDate = '';
  double value = 0;
  String barcode = '';

  String? validateName(String? value) =>
      value?.isEmpty == true ? "O nome não pode ser vazio" : null;
  String? validateDueDate(String? value) => (value?.length ?? 0) < 10
      ? "A data de vencimento é um campo obrigatório"
      : null;
  String? validateValue(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateBarcode(String? value) => (value?.length ?? 0) == 0
      ? "O código do boleto é um campo obrigatório"
      : null;

  Future<void> registerBoleto() async {
    final boleto = Boleto(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );

    await boleto.save();
  }
}
