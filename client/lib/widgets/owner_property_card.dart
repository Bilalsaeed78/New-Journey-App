import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../models/room_model.dart';
import 'custom_text.dart';

class OwnerPropertyCard extends StatelessWidget {
  const OwnerPropertyCard({
    super.key,
    this.room,
  });

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.37,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: MarginManager.marginM,
      ),
      decoration: BoxDecoration(
        color: AppColors.propertyContainer,
        borderRadius: BorderRadius.circular(
          RadiusManager.buttonRadius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Image.network(
              room!.images[0],
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: MarginManager.marginM,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
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
                              text: room!.roomNumber,
                              useOverflow: true,
                              color: Colors.black,
                              fontSize: FontSize.textFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.6,
                            child: Txt(
                              textAlign: TextAlign.start,
                              useOverflow: true,
                              text: room!.address,
                              color: Colors.black,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Chip(
                      backgroundColor: AppColors.primaryLight,
                      label: Txt(
                        text: 'Room',
                        color: AppColors.secondary,
                        fontSize: FontSize.subTitleFontSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.primaryLight,
                          child: Icon(
                            Icons.group,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Txt(
                          text: "${room!.maxCapacity} Person",
                          color: AppColors.secondary,
                          fontSize: FontSize.subTitleFontSize,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.primaryLight,
                          child: Icon(
                            Icons.attach_money,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Txt(
                          text:
                              "${room!.rentalPrice.toStringAsFixed(0)} RS / Month",
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
          )
        ],
      ),
    );
  }
}
