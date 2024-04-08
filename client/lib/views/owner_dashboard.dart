import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';
import 'package:new_journey_app/controllers/property_controller.dart';
import 'package:new_journey_app/views/property_type_selector_screen.dart';

import '../constants/font_manager.dart';
import '../constants/value_manager.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/owner_drawer.dart';
import '../widgets/property_card.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final propertyController = Get.put(PropertyController());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: OwnerDrawer(
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
      body: Container(
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
              ],
            ),
            const SizedBox(height: SizeManager.sizeXS),
            const SizedBox(
              width: double.infinity,
              child: Txt(
                textAlign: TextAlign.start,
                text: "Find all your added properties here",
                fontSize: FontSize.subTitleFontSize + 2,
                color: AppColors.secondary,
                fontWeight: FontWeightManager.medium,
              ),
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
                } else if (propertyController.myProperties.isEmpty) {
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
                        itemCount: propertyController.myProperties.length,
                        itemBuilder: (context, index) {
                          return PropertyCard(
                            propertyController: propertyController,
                            property: propertyController.myProperties[index],
                            isGuest: false,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.to(PropertyTypeSelectorScreen(
            propertyController: propertyController,
          ));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
