import 'package:flutter/material.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';
import 'package:new_journey_app/controllers/property_controller.dart';
import 'package:new_journey_app/widgets/custom_text.dart';
import 'package:new_journey_app/widgets/custom_text_form_field.dart';

import '../constants/value_manager.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key, required this.propertyController});

  final PropertyController propertyController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: const Txt(
          text: "Add Property",
          color: AppColors.background,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: MarginManager.marginL,
        ),
        child: Column(
          children: [
            CustomTextFormField(
              controller: propertyController.addressNum,
              labelText: "Address",
              hintText: "Room # 01, XYZ Street, NYC",
              autofocus: false,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              prefixIconData: Icons.credit_card,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Address cannot be empty.";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
