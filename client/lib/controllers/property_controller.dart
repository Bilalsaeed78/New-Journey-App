import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/storage/local_storage.dart';

class PropertyController extends GetxController with LocalStorage {
  final overviewController = TextEditingController();
  final rentalPriceController = TextEditingController();
  final floorController = TextEditingController();
  final roomsController = TextEditingController();
  final maxCapacityController = TextEditingController();
  final contactController = TextEditingController();
  final cabinsController = TextEditingController();
  final propertyAddressController = TextEditingController();
  var liftAvailable = false;
  var wifiAvailable = false;
  var acAvailable = false;

  void clearFields() {
    overviewController.clear();
    rentalPriceController.clear();
    floorController.clear();
    roomsController.clear();
    maxCapacityController.clear();
    contactController.clear();
    cabinsController.clear();
    liftAvailable = false;
    wifiAvailable = false;
    acAvailable = false;
  }

  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  // multipart images
}
