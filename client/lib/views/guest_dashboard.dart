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
import '../widgets/custom_button.dart';
import '../widgets/custom_search_filter.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/guest_drawer.dart';
import '../widgets/property_card.dart';
import 'search_location_screen.dart';

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
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        actions: [
          CircleAvatar(
            radius: 34,
            backgroundImage: user.profilePic != null &&
                    user.profilePic!.isNotEmpty
                ? NetworkImage(user.profilePic!)
                : const NetworkImage(
                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
            backgroundColor: AppColors.card,
          ),
          const SizedBox(
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
                      text: "${user.fullname!.split(" ").first}.",
                      fontSize: FontSize.titleFontSize,
                      color: AppColors.primary,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Txt(
                    text: "Find the best properties to rent.",
                    fontSize: FontSize.textFontSize - 1,
                    color: AppColors.secondary,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                const SizedBox(height: SizeManager.sizeM),
                CustomSearchBar(
                  controller: searchController.searchTextController,
                  onChanged: (value) async {
                    await searchController.searchOnText(
                        value, propertyController);
                  },
                  onFilterPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            width: double.infinity,
                            height: Get.height * 0.42,
                            decoration: const BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Txt(
                                        text: "Filter Properties",
                                        fontSize: FontSize.textFontSize + 2,
                                        color: Colors.black,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Txt(
                                        text:
                                            "Select filters to find best properties.",
                                        fontSize: FontSize.textFontSize - 2,
                                        color: AppColors.subtitleColor,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextFormField(
                                      controller: searchController.maxRent,
                                      labelText: "Max Rent (PKR)",
                                      hintText:
                                          "Input max rent you can go for.",
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      prefixIconData: Icons.attach_money,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter a value for max rent.";
                                        }
                                        if (double.parse(value) < 500.0) {
                                          return "Max rent must be greater or equal to 500 PKR.";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: SizeManager.sizeL,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(SearchLocationScreen(
                                          propertyController:
                                              propertyController,
                                        ));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.propertyContainer,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(Icons.map,
                                                color: AppColors.secondary),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Txt(
                                              text: 'Pick Location',
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Spacer(),
                                            Obx(() => propertyController
                                                    .isLocationPicked.value
                                                ? const Icon(Icons.check_box,
                                                    color: Colors.green)
                                                : const Icon(Icons.dangerous,
                                                    color: Colors.red)),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SizeManager.sizeL,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            buttonType: ButtonType.outline,
                                            textColor: AppColors.secondary,
                                            color: AppColors.divider,
                                            text: "Clear",
                                            onPressed: () async {
                                              searchController.clearFields();
                                              propertyController.clearFields();
                                              propertyController.clearLists();
                                              await propertyController
                                                  .loadData();
                                              propertyController
                                                  .isLocationPicked
                                                  .value = false;
                                              propertyController.location
                                                  .clear();
                                              Get.back();
                                            },
                                            hasInfiniteWidth: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: SizeManager.sizeL,
                                        ),
                                        Expanded(
                                          child: CustomButton(
                                            buttonType: ButtonType.outline,
                                            textColor: AppColors.primary,
                                            color: AppColors.primary,
                                            text: "Apply",
                                            onPressed: () async {
                                              await searchController
                                                  .searchOnFilters(
                                                propertyController,
                                              );
                                            },
                                            hasInfiniteWidth: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Obx(
                  () {
                    if (propertyController.isLoading.value ||
                        searchController.isLoading.value) {
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
                    } else if (searchController.isFilterApplied.value) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchController.searchedProperties.length,
                          itemBuilder: (context, index) {
                            var data =
                                searchController.searchedProperties[index];
                            return data.isOccupied
                                ? const SizedBox.shrink()
                                : PropertyCard(
                                    propertyController: propertyController,
                                    property: data,
                                    isGuest: true,
                                    isLocationFilterApplied: searchController
                                            .isLocationFilterApplied.isTrue
                                        ? true
                                        : false,
                                  );
                          },
                        ),
                      );
                    } else {
                      return Obx(
                        () => Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: propertyController.allProperties.length,
                            itemBuilder: (context, index) {
                              var data =
                                  propertyController.allProperties[index];
                              return data.isOccupied
                                  ? const SizedBox.shrink()
                                  : PropertyCard(
                                      propertyController: propertyController,
                                      property: propertyController
                                          .allProperties[index],
                                      isGuest: true,
                                      isLocationFilterApplied: false,
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
