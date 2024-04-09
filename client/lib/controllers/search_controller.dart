import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/property_model.dart';

class SearchFilterController extends GetxController {
  final Rx<List<Property>> _searchedProperties = Rx<List<Property>>([]);
  List<Property> get searchedProperties => _searchedProperties.value;

  final searchTextController = TextEditingController();
  final minRent = TextEditingController();
  final maxRent = TextEditingController();

  RxList<double> location = <double>[].obs;
  RxBool isLocationPicked = false.obs;
  RxBool isRentFilterApplied = false.obs;
  Rx<bool> isFilterApplied = false.obs;

  Rx<double> min = Rx(0);
  Rx<double> max = Rx(500000);

  void clearFields() {
    searchTextController.clear();
    isLocationPicked.value = false;
    isRentFilterApplied.value = false;
    min.value = 0;
    max.value - 500000;
    location.value = [];
    minRent.clear();
    maxRent.clear();
    _searchedProperties.value = [];
  }

  Future<void> searchOnFilters(
      List<double> location, List<Property> properties) async {}
}
