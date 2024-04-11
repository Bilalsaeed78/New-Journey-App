import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/history_controller.dart';
import 'package:new_journey_app/views/property_details_screen.dart';
import 'package:new_journey_app/views/renters_history_listing_screen.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../controllers/property_controller.dart';
import '../models/property_model.dart';
import 'custom_text.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({
    super.key,
    required this.propertyController,
    required this.property,
    required this.isGuestRoutes,
    this.historyController,
  });

  final PropertyController propertyController;
  final HistoryController? historyController;
  final Property property;
  final bool isGuestRoutes;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  late Map<String, dynamic> propertyData;
  bool isLoading = true;
  var status = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      if (widget.property.type == 'room') {
        var data = await widget.propertyController
            .getData('room', widget.property.propertyId);
        if (widget.historyController != null) {
          status = (await widget.historyController!
              .getPropertyAccomodationStatus(widget.property.id!))!;
        }
        setState(() {
          propertyData = data['room'];
          isLoading = false;
        });
      } else if (widget.property.type == 'office') {
        var data = await widget.propertyController
            .getData('office', widget.property.propertyId);
        if (widget.historyController != null) {
          status = (await widget.historyController!
              .getPropertyAccomodationStatus(widget.property.id!))!;
        }
        setState(() {
          propertyData = data['office'];
          isLoading = false;
        });
      } else {
        var data = await widget.propertyController
            .getData('apartment', widget.property.propertyId);
        if (widget.historyController != null) {
          status = (await widget.historyController!
              .getPropertyAccomodationStatus(widget.property.id!))!;
        }
        setState(() {
          propertyData = data['apartment'];
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              widget.isGuestRoutes
                  ? Get.to(PropertyDetailsScreem(
                      propertyData: propertyData,
                      type: widget.property.type,
                      propertyController: widget.propertyController,
                      propertyId: widget.property.id!,
                      isGuest: true,
                      isHistoryRoutes: true,
                    ))
                  : Get.to(RentersListingScreen(
                      propertyId: widget.property.id!,
                    ));
            },
            child: Container(
              height: Get.height * 0.32,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                vertical: MarginManager.marginM,
                horizontal: MarginManager.marginL,
              ),
              decoration: BoxDecoration(
                color: AppColors.propertyContainer,
                borderRadius: BorderRadius.circular(
                  RadiusManager.buttonRadius,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.network(
                      propertyData['images'][0],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: MarginManager.marginM,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: Get.width * 0.5,
                              child: Txt(
                                text: widget.property.type == 'room'
                                    ? propertyData['room_number']
                                    : (widget.property.type == 'apartment'
                                        ? propertyData['apartment_number']
                                        : propertyData['office_address']),
                                textAlign: TextAlign.start,
                                useOverflow: true,
                                color: Colors.black,
                                fontSize: FontSize.textFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.5,
                              child: Txt(
                                textAlign: TextAlign.start,
                                useOverflow: true,
                                text: propertyData['address'],
                                color: Colors.black,
                                fontSize: FontSize.subTitleFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (widget.isGuestRoutes && status != "")
                          Chip(
                            side: BorderSide.none,
                            backgroundColor: AppColors.primaryLight,
                            labelPadding: const EdgeInsets.all(0),
                            label: Txt(
                              text: status.capitalizeFirst,
                              color: AppColors.secondary,
                              useOverflow: true,
                              fontSize: FontSize.subTitleFontSize,
                            ),
                          ),
                        if (!widget.isGuestRoutes)
                          Chip(
                            side: BorderSide.none,
                            backgroundColor: AppColors.primaryLight,
                            labelPadding: const EdgeInsets.all(0),
                            label: Txt(
                              text: widget.property.isOccupied
                                  ? "Occupied"
                                  : "Vacant",
                              color: AppColors.secondary,
                              useOverflow: true,
                              fontSize: FontSize.subTitleFontSize,
                            ),
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
