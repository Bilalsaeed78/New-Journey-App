import 'package:flutter/material.dart';
import 'package:new_journey_app/widgets/custom_text.dart';

import '../constants/themes/app_colors.dart';

class AddRatingScreen extends StatelessWidget {
  const AddRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        title: const Txt(
          text: "Add Ratings",
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
