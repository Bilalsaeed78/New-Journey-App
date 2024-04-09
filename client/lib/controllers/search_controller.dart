import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_journey_app/constants/string_manager.dart';
import 'package:new_journey_app/models/property_model.dart';

import 'property_controller.dart';

class SearchFilterController extends GetxController {
  final Rx<List<Property>> _searchedProperties = Rx<List<Property>>([]);
  List<Property> get searchedProperties => _searchedProperties.value;

  final searchTextController = TextEditingController();
  final minRent = TextEditingController();
  final maxRent = TextEditingController();

  RxList<double> location = <double>[].obs;
  RxBool isLocationPicked = false.obs;
  RxBool isRentFilterApplied = false.obs;
  RxBool isFilterApplied = false.obs;

  Rx<double> min = Rx(0);
  Rx<double> max = Rx(500000);

  void clearFields() {
    searchTextController.clear();
    isLocationPicked.value = false;
    isFilterApplied.value = false;
    isRentFilterApplied.value = false;
    min.value = 0;
    max.value = 500000;
    location.value = [];
    minRent.clear();
    maxRent.clear();
    _searchedProperties.value = [];
  }

  RxBool isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> searchOnFilters(PropertyController controller) async {
    try {
      toggleLoading();
      if (controller.location.isEmpty) {
        Get.snackbar(
          'Error!',
          "Apply filters to search.",
        );
        return;
      }
      isFilterApplied.value = true;
      final url = Uri.parse("${AppStrings.BASE_URL}/filter/location");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "location": {"coordinates": controller.location}
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List<Property> filteredProperties =
            (responseData['propertyList'] as List)
                .map((propertyJson) => Property.fromJson(propertyJson))
                .toList();
        _searchedProperties.value.addAll(filteredProperties);
      }
      controller.location.clear();
      Get.back();
    } catch (e) {
      isFilterApplied.value = false;
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    } finally {
      toggleLoading();
    }
  }
}
