import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/widgets/custom_text.dart';

import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../controllers/rating_controller.dart';
import '../widgets/custom_button.dart';

class AddRatingScreen extends StatelessWidget {
  AddRatingScreen({super.key});

  final ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.secondary),
        title: const Txt(
          text: "Add Ratings",
          color: AppColors.secondary,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: MarginManager.marginL,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: RatingBar(
                initialRating: ratingController.rating.value,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: AppColors.primary),
                  half: const Icon(Icons.star_half, color: AppColors.primary),
                  empty: const Icon(Icons.star_border_outlined,
                      color: AppColors.primary),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  ratingController.updateRating(rating);
                },
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: ratingController.reviewController,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary)),
                  label: Txt(
                    text: "Review",
                  ),
                  labelStyle:
                      TextStyle(fontSize: 16, color: AppColors.secondary),
                  floatingLabelStyle:
                      TextStyle(fontSize: 16, color: AppColors.secondary),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary)),
                  prefixIcon: Icon(
                    Icons.reviews,
                    color: AppColors.primary,
                  ),
                  alignLabelWithHint: true),
              maxLines: 4,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 50),
            Obx(
              () => CustomButton(
                color: AppColors.primary,
                hasInfiniteWidth: true,
                loadingWidget: ratingController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: AppColors.primary,
                        ),
                      )
                    : null,
                onPressed: () {},
                text: "Add Ratings",
                textColor: AppColors.background,
                buttonType: ButtonType.loading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
