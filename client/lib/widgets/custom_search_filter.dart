import 'package:flutter/material.dart';
import 'package:new_journey_app/constants/themes/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onFilterPressed;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.secondary,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(
                    fontFamily: "Work Sans",
                    color: AppColors.secondary,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterPressed,
          ),
        ],
      ),
    );
  }
}
