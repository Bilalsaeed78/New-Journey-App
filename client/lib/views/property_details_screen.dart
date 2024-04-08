import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/property_controller.dart';
import 'package:new_journey_app/views/add_property_screen.dart';
import 'package:new_journey_app/widgets/carousel_slider.dart';
import 'package:new_journey_app/widgets/custom_button.dart';
import 'package:map_launcher/map_launcher.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../widgets/custom_text.dart';
import '../widgets/user_profile_dialog.dart';

class PropertyDetailsScreem extends StatefulWidget {
  const PropertyDetailsScreem(
      {super.key,
      required this.propertyData,
      required this.type,
      required this.propertyController,
      required this.propertyId});

  final PropertyController propertyController;
  final Map<String, dynamic> propertyData;
  final String type;
  final String propertyId;

  @override
  State<PropertyDetailsScreem> createState() => _PropertyDetailsScreemState();
}

class _PropertyDetailsScreemState extends State<PropertyDetailsScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        title: const Txt(
          text: "Property Details",
          color: AppColors.secondary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.32,
              child: CustomCarouselSlider(
                  imagesUrls: widget.propertyData['images']),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: MarginManager.marginL,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * 0.5,
                              child: Txt(
                                textAlign: TextAlign.start,
                                text: widget.type == 'room'
                                    ? widget.propertyData['room_number']
                                    : (widget.type == 'apartment'
                                        ? widget
                                            .propertyData['apartment_number']
                                        : widget
                                            .propertyData['office_address']),
                                color: Colors.black,
                                fontSize: FontSize.textFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.6,
                              child: Txt(
                                textAlign: TextAlign.start,
                                text: widget.propertyData['address'],
                                color: Colors.black,
                                fontSize: FontSize.subTitleFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Chip(
                        backgroundColor: AppColors.primary,
                        side: BorderSide.none,
                        labelPadding: const EdgeInsets.all(0),
                        label: Txt(
                          text: widget.type.capitalizeFirst,
                          color: AppColors.secondary,
                          useOverflow: true,
                          fontSize: FontSize.subTitleFontSize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SizeManager.sizeM,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Txt(
                      textAlign: TextAlign.start,
                      text: widget.propertyData['overview'],
                      color: Colors.black,
                      fontSize: FontSize.subTitleFontSize - 2,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: SizeManager.sizeM,
                  ),
                  CustomButton(
                    buttonType: ButtonType.outline,
                    textColor: AppColors.secondary,
                    color: AppColors.background,
                    text: "See Owner Details",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return UserProfileDialog();
                        },
                      );
                    },
                    hasInfiniteWidth: true,
                  ),
                  const SizedBox(
                    height: SizeManager.sizeM,
                  ),
                  Container(
                    height: Get.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColors.secondary,
                                  child: Icon(
                                    Icons.group,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Txt(
                                  text:
                                      "${widget.propertyData['max_capacity']} Persons",
                                  color: AppColors.secondary,
                                  fontSize: FontSize.subTitleFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColors.secondary,
                                  child: Icon(
                                    Icons.attach_money,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Txt(
                                  text:
                                      "${widget.propertyData['rental_price']} RS / Month",
                                  color: AppColors.secondary,
                                  fontSize: FontSize.subTitleFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.secondary,
                                  child: Icon(
                                    widget.type == 'room' ||
                                            widget.type == 'office'
                                        ? Icons.wifi
                                        : Icons.door_sliding,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Txt(
                                  text: widget.type == 'room' ||
                                          widget.type == 'office'
                                      ? widget.propertyData['wifiAvailable']
                                          ? "Wifi Available"
                                          : "Wifi Not Available"
                                      : widget.propertyData['liftAvailable']
                                          ? "Lift Available"
                                          : "Lift Not Available",
                                  color: AppColors.secondary,
                                  fontSize: FontSize.subTitleFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColors.secondary,
                                  child: Icon(
                                    Icons.call,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Txt(
                                  text:
                                      "${widget.propertyData['contact_number']}",
                                  color: AppColors.secondary,
                                  fontSize: FontSize.subTitleFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.type != 'room')
                    const Column(
                      children: [
                        SizedBox(
                          height: SizeManager.sizeM,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Txt(
                            textAlign: TextAlign.start,
                            text: "Additional Services",
                            color: Colors.black,
                            fontSize: FontSize.textFontSize,
                            fontWeight: FontWeightManager.semibold,
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.sizeM,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.type == 'office')
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              child: Icon(
                                Icons.ac_unit,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Txt(
                              text: widget.propertyData['acAvailable']
                                  ? "ACAvailable"
                                  : "AC Not Available",
                              color: AppColors.secondary,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      if (widget.type == 'office')
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              child: Icon(
                                Icons.keyboard,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Txt(
                              text:
                                  "${widget.propertyData['cabinsAvailable'].toString()} Cabins",
                              color: AppColors.secondary,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      if (widget.type == 'apartment')
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              child: Icon(
                                Icons.door_back_door,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Txt(
                              text:
                                  "${widget.propertyData['rooms'].toString()} Rooms",
                              color: AppColors.secondary,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      if (widget.type == 'apartment')
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              child: Icon(
                                Icons.stairs,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Txt(
                              text:
                                  "${widget.propertyData['floor'].toString()} Floors",
                              color: AppColors.secondary,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: SizeManager.sizeL,
                  ),
                  CustomButton(
                    buttonType: ButtonType.textWithImage,
                    textColor: AppColors.secondary,
                    color: AppColors.divider,
                    text: "Show location on map",
                    image: const Icon(
                      Icons.pin_drop,
                      color: AppColors.secondary,
                    ),
                    onPressed: () async {
                      final availableMaps = await MapLauncher.installedMaps;
                      var coords =
                          widget.propertyData['location']['coordinates'];
                      await availableMaps.first.showMarker(
                        coords: Coords(coords[1], coords[0]),
                        title: widget.propertyData['address'],
                      );
                    },
                    hasInfiniteWidth: true,
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
                          text: "Delete",
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: AppColors.background,
                                title: const Txt(
                                  text: "Confirm Delete Property",
                                  color: Colors.black,
                                  fontSize: FontSize.textFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                content: const Txt(
                                  text: "Are you sure you want to delete?",
                                  color: Colors.black,
                                  fontSize: FontSize.subTitleFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Txt(
                                      text: "Cancel",
                                      color: Colors.black,
                                      fontSize: FontSize.subTitleFontSize,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                      AppColors.primary,
                                    )),
                                    onPressed: () async {
                                      if (widget.type == 'room') {
                                        await widget.propertyController
                                            .deleteProperty(
                                                widget.propertyData['_id'],
                                                'room',
                                                widget.propertyId);
                                      } else if (widget.type == 'office') {
                                        await widget.propertyController
                                            .deleteProperty(
                                                widget.propertyData['_id'],
                                                'office',
                                                widget.propertyId);
                                      } else {
                                        await widget.propertyController
                                            .deleteProperty(
                                                widget.propertyData['_id'],
                                                'apartment',
                                                widget.propertyId);
                                      }
                                    },
                                    child: const Txt(
                                      text: "Delete",
                                      color: Colors.black,
                                      fontSize: FontSize.subTitleFontSize,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
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
                          text: "Edit",
                          onPressed: () {
                            if (widget.type == 'room') {
                              Get.to(AddPropertyScreen(
                                propertyController: widget.propertyController,
                                type: 'room',
                                data: widget.propertyData,
                                isEdit: true,
                              ));
                            } else if (widget.type == 'office') {
                              Get.to(AddPropertyScreen(
                                propertyController: widget.propertyController,
                                type: 'office',
                                data: widget.propertyData,
                                isEdit: true,
                              ));
                            } else {
                              Get.to(AddPropertyScreen(
                                propertyController: widget.propertyController,
                                type: 'apartment',
                                data: widget.propertyData,
                                isEdit: true,
                              ));
                            }
                          },
                          hasInfiniteWidth: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SizeManager.sizeL,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
