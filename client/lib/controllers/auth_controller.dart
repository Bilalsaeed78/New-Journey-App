import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/storage/local_storage.dart';
import 'package:new_journey_app/views/signup_screen.dart';

import '../views/login_screen.dart';

class AuthController extends GetxController with LocalStorage {
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  late String userTypeController = 'Guest';

  Rx<bool> isObscure = true.obs;
  Rx<bool> isLoading = false.obs;

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void checkLoginStatus() {
    final userType = getUserType();
    if (userType == null || userType.isEmpty) {
      Get.off(const LoginScreen());
    } else {
      if (userType == "guest") {
      } else {}
    }
  }

  Future<void> login(String email, String password) async {
    try {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        toggleLoading();
      }
    } catch (err) {
      toggleLoading();
      Get.snackbar(
        'Error Logging in',
        err.toString(),
      );
    }
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String cnic,
  }) async {
    try {
      if (signupFormKey.currentState!.validate()) {
        signupFormKey.currentState!.save();
        toggleLoading();
      }
    } catch (err) {
      toggleLoading();
      Get.snackbar(
        'Error registering.',
        err.toString(),
      );
    }
  }

  void logout() async {
    removeToken();
    Get.offAll(const LoginScreen());
  }

  void clearfields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    cnicController.clear();
    userTypeController = 'Guest';
  }
}
