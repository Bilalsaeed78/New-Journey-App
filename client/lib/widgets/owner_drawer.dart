import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../views/owner_dashboard.dart';
import 'custom_text.dart';

class OwnerDrawer extends StatelessWidget {
  const OwnerDrawer({
    super.key,
    required this.user,
    required this.controller,
  });

  final User user;
  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundColor: AppColors.secondaryLight,
              backgroundImage: NetworkImage(
                  'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Txt(
              text: user.fullname,
              color: AppColors.secondary,
              fontSize: FontSize.titleFontSize,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const Divider(),
            buildDrawerTile("Profile", Icons.person, () {}),
            buildDrawerTile("Dashboard", Icons.home, () {
              Get.offAll(OwnerDashboard(
                user: user,
              ));
            }),
            buildDrawerTile("History", Icons.history, () {}),
            buildDrawerTile("Logout", Icons.logout, () {
              controller.logout();
            }),
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerTile(String text, IconData icon, Function onPressed) {
    return ListTile(
      title: Txt(
        text: text,
        color: AppColors.secondary,
        fontSize: FontSize.subTitleFontSize,
        fontWeight: FontWeight.normal,
      ),
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      onTap: () => onPressed(),
    );
  }
}
