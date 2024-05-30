import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';

class MenuTypeDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const MenuTypeDropdown({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225,
      height: 35,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryBlack),
          ),
          filled: true,
          fillColor: AppColors.primaryWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryWhite),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        style: const TextStyle(
          color: AppColors.primaryBlack,
          fontFamily: AppStrings.fontFamiliy,
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: AppColors.primaryBlack),
            ),
          );
        }).toList(),
        dropdownColor: AppColors.primaryWhite,
        iconEnabledColor: AppColors.iconColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
