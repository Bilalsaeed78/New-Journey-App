import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';
import 'package:new_journey_app/controllers/property_controller.dart';
import 'package:new_journey_app/views/add_property_screen.dart';
import 'package:new_journey_app/widgets/custom_button.dart';

import '../constants/font_manager.dart';
import '../constants/value_manager.dart';
import '../widgets/custom_text.dart';

class PropertyTypeSelectorScreen extends StatelessWidget {
  const PropertyTypeSelectorScreen(
      {super.key, required this.propertyController});

  final PropertyController propertyController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: MarginManager.marginL,
              vertical: MarginManager.marginM),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/logos_png/logo.png',
                ),
              ),
              const Txt(
                textAlign: TextAlign.start,
                text: "Property Type?",
                fontSize: FontSize.textFontSize,
                color: AppColors.secondary,
                fontWeight: FontWeightManager.bold,
              ),
              const Txt(
                textAlign: TextAlign.start,
                text: "Please select your type to add property.",
                fontSize: FontSize.subTitleFontSize + 2,
                color: AppColors.secondary,
                fontWeight: FontWeightManager.medium,
              ),
              const SizedBox(
                height: SizeManager.sizeXL,
              ),
              CustomButton(
                color: AppColors.primary,
                textColor: AppColors.secondary,
                text: "Room",
                onPressed: () {
                  Get.to(AddPropertyScreen(
                      propertyController: propertyController, type: "room"));
                },
                hasInfiniteWidth: true,
              ),
              const SizedBox(
                height: SizeManager.sizeL,
              ),
              CustomButton(
                color: AppColors.primary,
                textColor: AppColors.secondary,
                text: "Office",
                onPressed: () {
                  Get.to(AddPropertyScreen(
                      propertyController: propertyController, type: "office"));
                },
                hasInfiniteWidth: true,
              ),
              const SizedBox(
                height: SizeManager.sizeL,
              ),
              CustomButton(
                color: AppColors.primary,
                textColor: AppColors.secondary,
                text: "Apartment",
                onPressed: () {
                  Get.to(AddPropertyScreen(
                      propertyController: propertyController,
                      type: "apartment"));
                },
                hasInfiniteWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
