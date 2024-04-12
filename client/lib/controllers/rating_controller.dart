import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final reviewController = TextEditingController();

  Rx<double> rating = 1.0.obs;

  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void updateRating(double val) {
    rating.value = val;
  }
}
