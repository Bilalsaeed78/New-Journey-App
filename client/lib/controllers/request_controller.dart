import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_journey_app/constants/string_manager.dart';
import 'package:new_journey_app/storage/local_storage.dart';

import '../models/request_model.dart';

class RequestController extends GetxController with LocalStorage {
  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<String?>? getPropertyAccomodationStatus(String propertyId) async {
    try {
      toggleLoading();
      final userId = getUserId();
      final url = Uri.parse(
          '${AppStrings.BASE_URL}/request/checkStatus?propertyId=$propertyId&guestId=$userId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final resp = jsonResponse['request'];
        return resp['status'];
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        "Failed to load data.",
      );
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<void> sendAccommodationRequest(RequestModel requestModel) async {
    try {
      toggleLoading();
      final requestBody = json.encode(requestModel.toJson());
      final url = Uri.parse("${AppStrings.BASE_URL}/request/");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          'Success',
          "Request send successfully.",
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        "Failed to send request.",
      );
    } finally {
      toggleLoading();
    }
  }
}
