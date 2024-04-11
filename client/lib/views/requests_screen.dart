import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../widgets/custom_text.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        title: const Txt(
          text: "Renters Request",
          color: AppColors.secondary,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: MarginManager.marginM, vertical: MarginManager.marginS),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                iconColor: AppColors.primary,
                tileColor: AppColors.whiteShade,
                leading: const CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                    )),
                title: const Txt(text: "Ali"),
                subtitle: const Txt(text: "Pending"),
                trailing: SizedBox(
                  width: Get.width * 0.25,
                  child: Row(children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.check,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.error,
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
