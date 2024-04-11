import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/request_controller.dart';
import 'package:new_journey_app/models/request_model.dart';
import 'package:new_journey_app/models/user_model.dart';

import '../constants/themes/app_colors.dart';
import 'custom_text.dart';

class RequestTile extends StatefulWidget {
  const RequestTile({
    super.key,
    required this.requestModel,
    required this.requestController,
  });

  final RequestModel requestModel;
  final RequestController requestController;

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  late User user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading = true;
      user = (await widget.requestController
          .getCurrentUserInfo(widget.requestModel.guestId))!;
      isLoading = false;
      setState(() {});
    } catch (error) {
      isLoading = false;
      Get.snackbar(
        'Error',
        "Failed to load data.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
        : Padding(
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
              title: Txt(text: user.fullname.split(" ").first.capitalizeFirst),
              subtitle: Txt(text: widget.requestModel.status.capitalizeFirst),
              trailing: SizedBox(
                width: Get.width * 0.25,
                child: Row(children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_box,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.disabled_by_default,
                      color: AppColors.error,
                    ),
                  ),
                ]),
              ),
            ),
          );
  }
}
