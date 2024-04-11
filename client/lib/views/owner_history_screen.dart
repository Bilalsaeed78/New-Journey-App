import 'package:flutter/material.dart';
import 'package:new_journey_app/controllers/auth_controller.dart';
import 'package:new_journey_app/widgets/owner_drawer.dart';

import '../constants/themes/app_colors.dart';
import '../models/user_model.dart';
import '../widgets/custom_text.dart';

class OwnerHistoryScreen extends StatelessWidget {
  const OwnerHistoryScreen(
      {super.key, required this.user, required this.authController});

  final User user;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: OwnerDrawer(user: user, controller: authController),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.secondary),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: const Txt(
          text: "Renting History",
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
