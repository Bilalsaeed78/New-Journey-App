import 'package:flutter/material.dart';
import 'package:new_journey_app/models/user_model.dart';
import 'package:new_journey_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import 'custom_text.dart';

class UserProfileDialog extends StatelessWidget {
  UserProfileDialog({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: authController.getCurrentUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching user information'),
          );
        } else {
          final user = snapshot.data!;
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: const SizedBox(
              width: double.infinity,
              child: Txt(
                textAlign: TextAlign.center,
                text: "Owner Details",
                color: Colors.black,
                fontSize: FontSize.textFontSize,
                fontWeight: FontWeightManager.semibold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                user.profilePic == null || user.profilePic!.isEmpty
                    ? const CircleAvatar(
                        maxRadius: 50,
                        backgroundColor: AppColors.secondary,
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      )
                    : CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: NetworkImage(user.profilePic!),
                        radius: 50,
                      ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Txt(
                    textAlign: TextAlign.center,
                    text: user.fullname,
                    color: Colors.black,
                    fontSize: FontSize.subTitleFontSize,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Txt(
                    textAlign: TextAlign.center,
                    text: user.contactNo,
                    color: Colors.black,
                    fontSize: FontSize.subTitleFontSize,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Txt(
                    textAlign: TextAlign.center,
                    text: user.email,
                    color: Colors.black,
                    fontSize: FontSize.subTitleFontSize,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
