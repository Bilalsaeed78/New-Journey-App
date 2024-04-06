import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:new_journey_app/controllers/property_controller.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../widgets/custom_text.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key, required this.propertyController});

  final PropertyController propertyController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              propertyController.multiImageController.hasNoImages
                  ? propertyController.isImagePicked.value = false
                  : propertyController.isImagePicked.value = true;
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.secondary,
            )),
        title: const Txt(
          text: "Add Images",
          color: AppColors.secondary,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: MarginManager.marginL,
        ),
        child: MultiImagePickerView(
          controller: propertyController.multiImageController,
          builder: (context, ImageFile imageFile) {
            return DefaultDraggableItemWidget(
              imageFile: imageFile,
              boxDecoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(RadiusManager.buttonRadius)),
              closeButtonAlignment: Alignment.topLeft,
              fit: BoxFit.cover,
              closeButtonIcon:
                  const Icon(Icons.delete_rounded, color: Colors.red),
              closeButtonBoxDecoration: null,
              showCloseButton: true,
              closeButtonMargin: const EdgeInsets.all(3),
              closeButtonPadding: const EdgeInsets.all(3),
            );
          },
          initialWidget: const DefaultInitialWidget(
            centerWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: AppColors.secondary,
                ),
                Txt(
                  text: "Add Images",
                  color: AppColors.secondary,
                  fontWeight: FontWeightManager.medium,
                ),
              ],
            ),
            backgroundColor: AppColors.propertContainer,
            margin: EdgeInsets.zero,
          ),
          addMoreButton: const DefaultAddMoreWidget(
              icon: Icon(
                Icons.add,
                color: AppColors.secondary,
              ),
              backgroundColor: AppColors.propertContainer),
        ),
      ),
    );
  }
}
