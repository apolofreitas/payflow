import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final String initialRoute;
  final Map<String, Widget> routes;
  late final RxString _currentRoute = initialRoute.obs;

  HomeController({
    required this.initialRoute,
    required this.routes,
  });

  get curretRoute => _currentRoute.value;

  get currentPage {
    var page = routes[_currentRoute];

    if (page == null) throw 'Unknown route $_currentRoute';

    return page;
  }

  void navigateTo(String page) {
    _currentRoute.value = page;
  }
}
