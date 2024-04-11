import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_journey_app/constants/string_manager.dart';

import '../models/request_model.dart';

class RequestController extends GetxController {
  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  // Future<bool> getPropertyAccomodationStatus(String id) async {
  //   try {
  //     toggleLoading();
  //     final url = Uri.parse("${AppStrings.BASE_URL}/byProperty/$id");
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       final jsonResponse = jsonDecode(response.body);
  //     final status = jsonResponse[''];
  //     }
  //   } catch (e) {
  //     print("Error: ${e.toString()}");
  //     Get.snackbar(
  //       'Error',
  //       "Failed to load data.",
  //     );
  //   } finally {
  //     toggleLoading();
  //   }
  // }

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
