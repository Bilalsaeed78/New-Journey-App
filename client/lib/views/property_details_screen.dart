import 'package:flutter/material.dart';
import 'package:new_journey_app/widgets/carousel_slider.dart';

import '../constants/themes/app_colors.dart';
import '../widgets/custom_text.dart';

class PropertyDetailsScreem extends StatefulWidget {
  const PropertyDetailsScreem({super.key, required this.propertyData});

  final Map<String, dynamic> propertyData;

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
      body: Column(
        children: [
          Expanded(
            child:
                CustomCarouselSlider(imagesUrls: widget.propertyData['images']),
          ),
        ],
      ),
    );
  }
}
