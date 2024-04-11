import 'package:flutter/material.dart';

import '../constants/themes/app_colors.dart';
import '../widgets/custom_text.dart';

class GuestHistoryScreen extends StatelessWidget {
  const GuestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        title: const Txt(
          text: "Properties History",
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
