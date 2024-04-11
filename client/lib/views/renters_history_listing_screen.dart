import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/request_controller.dart';

import '../constants/font_manager.dart';
import '../constants/themes/app_colors.dart';
import '../constants/value_manager.dart';
import '../widgets/custom_text.dart';
import '../widgets/request_tile.dart';

class RentersListingScreen extends StatefulWidget {
  const RentersListingScreen({super.key, required this.propertyId});
  final String propertyId;

  @override
  State<RentersListingScreen> createState() => _RentersListingScreenState();
}

class _RentersListingScreenState extends State<RentersListingScreen> {
  final requestController = Get.put(RequestController());
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      await requestController.getPropertyRequests(widget.propertyId);
    } catch (e) {
      Get.snackbar(
        'Error',
        "Failed to load data.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.secondary),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: const Txt(
          text: "Renter Requests List",
          color: AppColors.secondary,
        ),
      ),
      body: Obx(() {
        if (requestController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (requestController.myPropertyRequests.isEmpty) {
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: SizeManager.sizeL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/no_data.svg",
                    height: 200,
                    width: 200,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Txt(
                      text: "No request available.",
                      color: AppColors.secondary,
                      fontSize: FontSize.subTitleFontSize,
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(
                horizontal: MarginManager.marginM,
                vertical: MarginManager.marginS),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: requestController.myPropertyRequests.length,
              itemBuilder: (context, index) {
                var data = requestController.myPropertyRequests[index];
                return RequestTile(
                  requestController: requestController,
                  requestModel: data,
                  isHistoryRoute: true,
                );
              },
            ),
          );
        }
      }),
    );
  }
}
