import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';
import 'package:new_journey_app/controllers/property_controller.dart';
import 'package:new_journey_app/views/images_viewer_screen.dart';
import 'package:new_journey_app/widgets/custom_text.dart';
import 'package:new_journey_app/widgets/custom_text_form_field.dart';

import '../constants/font_manager.dart';
import '../constants/value_manager.dart';
import '../widgets/custom_button.dart';
import '../widgets/packages/group_radio_buttons/grouped_buttons.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen(
      {super.key, required this.propertyController, required this.type});

  final PropertyController propertyController;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        title: Txt(
          text: "Add ${type.capitalizeFirst!}",
          color: AppColors.secondary,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: MarginManager.marginL,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              CustomTextFormField(
                controller: propertyController.propertyAddressController,
                labelText: "Property Address",
                hintText: "Complete property address",
                autofocus: false,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.home,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Address cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              CustomTextFormField(
                controller: propertyController.overviewController,
                labelText: "Description",
                autofocus: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              CustomTextFormField(
                controller: propertyController.contactController,
                labelText: "Contact Number",
                autofocus: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.call,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Contact number cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              CustomTextFormField(
                controller: propertyController.rentalPriceController,
                labelText: "Rent per month",
                autofocus: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.attach_money,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Rent cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              CustomTextFormField(
                controller: propertyController.maxCapacityController,
                labelText: "Capacity",
                autofocus: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.group,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Capacity cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              if (type == 'office')
                Column(
                  children: [
                    const SizedBox(
                      height: SizeManager.sizeS,
                    ),
                    RadioButtonFormField(
                      labels: const ['Yes', 'No'],
                      icons: const [Icons.check, Icons.close],
                      onChange: (String label, int index) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.liftAvailable = v;
                      },
                      onSelected: (String label) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.liftAvailable = v;
                      },
                      decoration: InputDecoration(
                        labelText: 'Lift Available',
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: FontSize.textFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: FontSize.textFontSize,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondary,
                            width: 1,
                          ),
                          borderRadius:
                              BorderRadius.circular(RadiusManager.fieldRadius),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeM,
                    ),
                    CustomTextFormField(
                      controller: propertyController.cabinsController,
                      labelText: "No. of Cabins",
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.keyboard,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Cabins cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeM,
                    ),
                    RadioButtonFormField(
                      labels: const ['Yes', 'No'],
                      icons: const [Icons.check, Icons.close],
                      onChange: (String label, int index) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.acAvailable = v;
                      },
                      onSelected: (String label) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.acAvailable = v;
                      },
                      decoration: InputDecoration(
                        labelText: 'AC Available',
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: FontSize.textFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: FontSize.textFontSize,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondary,
                            width: 1,
                          ),
                          borderRadius:
                              BorderRadius.circular(RadiusManager.fieldRadius),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeM,
                    ),
                  ],
                ),
              if (type == 'room')
                Column(
                  children: [
                    const SizedBox(
                      height: SizeManager.sizeS,
                    ),
                    RadioButtonFormField(
                      labels: const ['Yes', 'No'],
                      icons: const [Icons.check, Icons.close],
                      onChange: (String label, int index) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.wifiAvailable = v;
                      },
                      onSelected: (String label) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.wifiAvailable = v;
                      },
                      decoration: InputDecoration(
                        labelText: 'Wifi Available',
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: FontSize.textFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: FontSize.textFontSize,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondary,
                            width: 1,
                          ),
                          borderRadius:
                              BorderRadius.circular(RadiusManager.fieldRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              if (type == 'apartment')
                Column(
                  children: [
                    CustomTextFormField(
                      controller: propertyController.floorController,
                      labelText: "Floors",
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.stairs,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Floors cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeM,
                    ),
                    CustomTextFormField(
                      controller: propertyController.roomsController,
                      labelText: "No. of Rooms",
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.meeting_room,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Rooms cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeXL,
                    ),
                    RadioButtonFormField(
                      labels: const ['Yes', 'No'],
                      icons: const [Icons.check, Icons.close],
                      onChange: (String label, int index) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.liftAvailable = v;
                      },
                      onSelected: (String label) {
                        bool v = label == 'Yes' ? true : false;
                        propertyController.liftAvailable = v;
                      },
                      decoration: InputDecoration(
                        labelText: 'Lift Available',
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: FontSize.textFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: FontSize.textFontSize,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondary,
                            width: 1,
                          ),
                          borderRadius:
                              BorderRadius.circular(RadiusManager.fieldRadius),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeM,
                    ),
                  ],
                ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(ImageViewerScreen(
                            propertyController: propertyController));
                      },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(RadiusManager.buttonRadius),
                          color: AppColors.propertContainer,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image,
                              color: AppColors.secondary,
                            ),
                            Txt(
                              text: "Add ${type.capitalizeFirst!} Images",
                              color: AppColors.secondary,
                              fontWeight: FontWeightManager.medium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return propertyController.isImagePicked.isFalse
                        ? const Icon(
                            Icons.close_outlined,
                            color: AppColors.error,
                          )
                        : const Icon(
                            Icons.check_box,
                            color: AppColors.success,
                          );
                  }),
                ],
              ),
              const SizedBox(
                height: SizeManager.sizeM,
              ),
              // Location Picker
              const SizedBox(
                height: SizeManager.sizeL,
              ),
              CustomButton(
                color: AppColors.primary,
                hasInfiniteWidth: true,
                loadingWidget: propertyController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: AppColors.primary,
                        ),
                      )
                    : null,
                onPressed: () {},
                text: "Add",
                textColor: AppColors.background,
                buttonType: ButtonType.loading,
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
