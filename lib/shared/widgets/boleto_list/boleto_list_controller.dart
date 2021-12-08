import 'package:get/get.dart';
import 'package:payflow/shared/models/boleto.dart';

class BoletoListController extends GetxController {
  final _boletos = <Boleto>[].obs;
  // ignore: invalid_use_of_protected_member
  List<Boleto> get boletos => _boletos.value;
  set boletos(List<Boleto> value) => _boletos.value = value;

  BoletoListController() {
    updateBoletos();
    Boleto.observers.add(updateBoletos);
  }

  Future<void> updateBoletos() async {
    boletos = await Boleto.findAll();
  }

  @override
  void dispose() {
    Boleto.observers.remove(updateBoletos);
    super.dispose();
  }
}
