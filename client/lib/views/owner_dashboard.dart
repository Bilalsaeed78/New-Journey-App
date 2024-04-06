import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';
import 'package:new_journey_app/controllers/property_controller.dart';
import 'package:new_journey_app/views/add_property_screen.dart';
import 'package:new_journey_app/views/property_type_selector_screen.dart';

import '../constants/font_manager.dart';
import '../constants/value_manager.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/owner_drawer.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final propertyController = Get.put(PropertyController());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: OwnerDrawer(
        controller: authController,
        user: user,
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        actions: const [
          CircleAvatar(
            maxRadius: 25,
            backgroundColor: AppColors.secondary,
            child: Icon(
              Icons.person,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
      body: Obx(
        () {
          if (authController.isLoading.value) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: MarginManager.marginL,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Txt(
                        text: "Welcome, ",
                        fontSize: FontSize.titleFontSize,
                        color: AppColors.secondary,
                        fontWeight: FontWeightManager.medium,
                      ),
                      Txt(
                        text: "${user.fullname.split(" ").first}.",
                        fontSize: FontSize.titleFontSize,
                        color: AppColors.primary,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: SizeManager.sizeXS),
                  const SizedBox(
                    width: double.infinity,
                    child: Txt(
                      textAlign: TextAlign.start,
                      text: "Find all your added properties here",
                      fontSize: FontSize.subTitleFontSize + 2,
                      color: AppColors.secondary,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                  const SizedBox(height: SizeManager.sizeXL),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          height: Get.height * 0.37,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            vertical: MarginManager.marginM,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.propertContainer,
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
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZYeGcaJ7ynYqcqk8hniNgWCfYU9cQezq8qepHFgWKVTZAIzzHQaRV39MCz6rtJqr5CBA&usqp=CAU',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: MarginManager.marginM,
                                ),
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Txt(
                                        textAlign: TextAlign.start,
                                        text: "Blushie's House",
                                        color: Colors.black,
                                        fontSize: FontSize.textFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Txt(
                                        textAlign: TextAlign.start,
                                        text: "215 AC Street, NYC, NewYork",
                                        color: Colors.black,
                                        fontSize: FontSize.subTitleFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primaryLight,
                                              child: Icon(
                                                Icons.group,
                                                color: AppColors.secondary,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Txt(
                                              text: "5 Person",
                                              color: AppColors.secondary,
                                              fontSize:
                                                  FontSize.subTitleFontSize,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primaryLight,
                                              child: Icon(
                                                Icons.attach_money,
                                                color: AppColors.secondary,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Txt(
                                              text: "12000 RS / Month",
                                              color: AppColors.secondary,
                                              fontSize:
                                                  FontSize.subTitleFontSize,
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
                      },
                    ),
                  ),
                  const SizedBox(height: SizeManager.sizeXL),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.to(PropertyTypeSelectorScreen());
        },
        child: const Icon(
          Icons.add,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
