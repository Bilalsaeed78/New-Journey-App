import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/auth_controller.dart';
import 'package:new_journey_app/controllers/property_controller.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../controllers/search_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_search_filter.dart';
import '../widgets/custom_text.dart';
import '../widgets/guest_drawer.dart';
import '../widgets/property_card.dart';

class GuestDashbaord extends StatelessWidget {
  const GuestDashbaord({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final propertyController = Get.put(PropertyController());
    final searchController = Get.put(SearchFilterController());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: GuestDrawer(
        controller: authController,
        user: user,
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        actions: const [
          CircleAvatar(
            maxRadius: 25,
            backgroundColor: AppColors.secondary,
            child: Icon(
              Icons.person,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            width: 12,
          ),
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
                      text: "Hello, ",
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
                  ],
                ),
                const SizedBox(height: SizeManager.sizeXL),
                CustomSearchBar(
                  controller: searchController.searchTextController,
                  onChanged: (value) {},
                  onFilterPressed: () {},
                ),
                const SizedBox(height: SizeManager.sizeL),
                Obx(
                  () {
                    if (propertyController.isLoading.value) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    } else if (propertyController.allProperties.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: SizeManager.sizeL),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/no_data.svg",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.scaleDown,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Center(
                                  child: Txt(
                                    text: "No properties are added yet!",
                                    color: AppColors.secondary,
                                    fontSize: FontSize.subTitleFontSize,
                                  ),
                                ),
                                const SizedBox(height: 120),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Obx(
                        () => Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: propertyController.allProperties.length,
                            itemBuilder: (context, index) {
                              return PropertyCard(
                                propertyController: propertyController,
                                property:
                                    propertyController.allProperties[index],
                                isGuest: true,
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: SizeManager.sizeXL),
              ],
            ),
          );
        }
      }),
    );
  }
}
