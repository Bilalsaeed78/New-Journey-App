import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_journey_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../constants/font_manager.dart';
import '../constants/string_manager.dart';
import '../constants/themes/app_colors.dart';
import 'custom_text.dart';

class UserProfileDialog extends StatelessWidget {
  const UserProfileDialog({Key? key, required this.ownerId}) : super(key: key);

  final String ownerId;

  Future<User?>? getCurrentUserInfo(String id) async {
    final url = Uri.parse("${AppStrings.BASE_URL}/user/current/$id");
    final response = await http.get(
      url,
    );
    if (response.statusCode == 201) {
      final res = jsonDecode(response.body);
      final user = User.fromJson(res['user']);
      return user;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: getCurrentUserInfo(ownerId),
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
