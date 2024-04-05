import 'package:get/get.dart';

import '../views/login_screen.dart';

class AuthController extends GetxController {
  void checkLoginStatus() {
    // final userType = getUserType();
    Get.offAll(const LoginScreen());
    // if (userType == null || userType.isEmpty) {
    //   Get.off(const LoginScreen());
    // } else {
    //   if (userType == "Seller") {
    //     Get.offAll(const SellerHomeScreen());
    //   } else {
    //     Get.offAll(const BuyerHomeScreen());
    //   }
    // }
  }
}
