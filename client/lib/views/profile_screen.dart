import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';
import 'package:new_journey_app/controllers/auth_controller.dart';
import 'package:new_journey_app/controllers/profile_controller.dart';
import 'package:new_journey_app/widgets/custom_text.dart';

import '../models/user_model.dart';
import '../widgets/owner_drawer.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.user, required this.authController});

  final User user;
  final AuthController authController;

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: OwnerDrawer(
        controller: authController,
        user: user,
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        title: const Txt(text: 'Profile'),
        centerTitle: true,
      ),
      body: Obx(
        () => profileController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: AppColors.primary,
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: 80,
                              backgroundImage: profileController.profilePhoto !=
                                      null
                                  ? Image.file(profileController.profilePhoto!)
                                      .image
                                  : profileController.user.profilePic != ""
                                      ? NetworkImage(
                                          profileController.user.profilePic!)
                                      : const NetworkImage(
                                          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                              backgroundColor: AppColors.background,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () =>
                                    profileController.pickProfile(),
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: AppColors.secondary,
                                  size: 36,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Txt(
                      textAlign: TextAlign.center,
                      // text: profileController.userName == ""
                      //     ? profileController.jobseeker.fullname.capitalizeFirstOfEach
                      //     : profileController.userName.capitalizeFirstOfEach,
                      text: profileController.user.fullname.capitalizeFirst,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Txt(
                      textAlign: TextAlign.center,
                      text: profileController.user.email,
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    ListTile(
                      onTap: () {},
                      tileColor: AppColors.primaryLight.withOpacity(0.6),
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.secondary,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                      title: const Txt(
                        textAlign: TextAlign.start,
                        text: 'Update User Details',
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    ListTile(
                      onTap: () {},
                      tileColor: AppColors.primaryLight.withOpacity(0.6),
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.secondary,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                      title: const Txt(
                        textAlign: TextAlign.start,
                        text: 'Change Password',
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    const Txt(
                      textAlign: TextAlign.start,
                      text: 'Powered By New Journey ©',
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
