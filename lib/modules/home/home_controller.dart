import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeController {
  RxString currentPage = ''.obs;

  void setPage(String page) {
    currentPage.value = page;
  }
}
