import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/views/owner_history_screen.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../views/owner_dashboard.dart';
import '../views/profile_screen.dart';
import 'custom_text.dart';
import 'theme_mode_switch.dart';

class OwnerDrawer extends StatefulWidget {
  const OwnerDrawer({
    super.key,
    required this.controller,
  });

  final AuthController controller;

  @override
  State<OwnerDrawer> createState() => _OwnerDrawerState();
}

class _OwnerDrawerState extends State<OwnerDrawer> {
  bool isLoading = true;
  late User user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    user = (await widget.controller
        .getCurrentUserInfo(widget.controller.getUserId()!))!;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.background,
                backgroundColor: AppColors.primary,
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: user.profilePic != null &&
                            user.profilePic!.isNotEmpty
                        ? NetworkImage(user.profilePic!)
                        : const NetworkImage(
                            'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                    backgroundColor: AppColors.card,
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
                  buildDrawerTile("Profile", Icons.person, () {
                    Get.offAll(ProfileScreen(
                      user: user,
                      authController: widget.controller,
                      isOwner: true,
                    ));
                  }),
                  buildDrawerTile("Dashboard", Icons.home, () {
                    Get.offAll(OwnerDashboard(
                      user: user,
                    ));
                  }),
                  buildDrawerTile("History", Icons.history, () {
                    Get.offAll(OwnerHistoryScreen(
                      user: user,
                      authController: widget.controller,
                    ));
                  }),
                  buildDrawerTile("Logout", Icons.logout, () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: AppColors.background,
                        title: const Txt(
                          text: "Confirm Logout",
                          color: Colors.black,
                          fontSize: FontSize.textFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        content: const Txt(
                          text: "Are you sure you want to logout?",
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
                              text: "No",
                              color: Colors.black,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                              AppColors.primary,
                            )),
                            onPressed: () {
                              widget.controller.logout();
                            },
                            child: const Txt(
                              text: "Yes",
                              color: Colors.black,
                              fontSize: FontSize.subTitleFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Spacer(),
                  const ThemeModeSwitch(),
                  const SizedBox(height: 18),
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
