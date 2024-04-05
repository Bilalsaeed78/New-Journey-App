import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/auth_controller.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../controllers/property_controller.dart';
import '../controllers/search_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_search_filter.dart';
import '../widgets/custom_text.dart';

class GuestDashbaord extends StatelessWidget {
  GuestDashbaord({super.key, required this.user});

  final User user;

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final propertyController = Get.put(PropertyController());
    final searchController = Get.put(SearchFilterController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: () => authController.logout(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Obx(() {
        if (authController.isLoading.value) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: MarginManager.marginL,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Txt(
                      text: "Welcome, ",
                      fontSize: FontSize.titleFontSize,
                      color: AppColors.secondary,
                      fontWeight: FontWeightManager.medium,
                    ),
                    Txt(
                      text: "${user.fullname.split(" ").first}.",
                      fontSize: FontSize.titleFontSize,
                      color: AppColors.primary,
                      fontWeight: FontWeightManager.bold,
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: AppColors.secondary,
                      child: Icon(
                        Icons.person,
                        size: 32,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.sizeXL),
                CustomSearchBar(
                  controller: searchController.searchTextController,
                  onChanged: (value) {},
                  onFilterPressed: () {},
                ),
                const SizedBox(height: SizeManager.sizeXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Chip(label: Txt(text: 'Rooms')),
                    Chip(label: Txt(text: 'Apartments')),
                    Chip(label: Txt(text: 'Offices')),
                  ],
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
