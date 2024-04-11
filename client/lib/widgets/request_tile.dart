import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/request_controller.dart';
import 'package:new_journey_app/models/request_model.dart';
import 'package:new_journey_app/models/user_model.dart';

import '../constants/themes/app_colors.dart';
import 'custom_text.dart';
import 'user_profile_dialog.dart';

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
      await Future.delayed(const Duration(seconds: 1));
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
    return isLoading ? _buildShimmerEffect() : _buildTileContent();
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Colors.white),
        title: Container(color: Colors.white, height: 20.0, width: 100.0),
        subtitle: Container(color: Colors.white, height: 12.0, width: 150.0),
      ),
    );
  }

  Padding _buildTileContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        iconColor: AppColors.primary,
        tileColor: AppColors.whiteShade,
        leading: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return UserProfileDialog(
                  ownerId: user.uid!,
                );
              },
            );
          },
          child: const CircleAvatar(
              backgroundColor: AppColors.secondary,
              child: Icon(
                Icons.person,
                color: AppColors.primary,
              )),
        ),
        title: Txt(
          text: user.fullname,
          useOverflow: true,
        ),
        subtitle: Txt(text: widget.requestModel.status.capitalizeFirst),
        trailing: SizedBox(
          width: Get.width * 0.27,
          child: Row(children: [
            IconButton(
              onPressed: () async {
                await widget.requestController
                    .updateRequestStatus(widget.requestModel.id!, 'accepted');
              },
              icon: const Icon(
                Icons.check_box,
                color: AppColors.success,
                size: 30,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                await widget.requestController
                    .updateRequestStatus(widget.requestModel.id!, 'rejected');
              },
              icon: const Icon(
                Icons.disabled_by_default,
                color: AppColors.error,
                size: 30,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
