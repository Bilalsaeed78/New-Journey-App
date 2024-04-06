import 'package:flutter/material.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';

import 'custom_text.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: const Icon(
            Icons.location_on,
            color: AppColors.secondary,
          ),
          minLeadingWidth: 40,
          title: Txt(
            text: location,
            maxLines: 2,
            useOverflow: true,
            fontSize: 14,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: AppColors.divider,
        ),
      ],
    );
  }
}
