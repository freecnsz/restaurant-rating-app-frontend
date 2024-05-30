import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';

class LabeledTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final bool obscureText;
  final MainAxisAlignment mainAxisAlignment;

  const LabeledTextFormField({
    Key? key,
    required this.labelText,
    required this.obscureText,
    this.hintText,
    this.controller,
    this.validator,
    required this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            labelText,
            style: const TextStyle(
              fontFamily: AppStrings.fontFamiliy,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryWhite,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 225,
          height: 35,
          child: TextFormField(
            key: key,
            obscureText: obscureText,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppColors.iconColor,
            enableSuggestions: true,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: AppColors.primaryBlack),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primaryWhite),
              ),
              filled: true,
              fillColor: AppColors.primaryWhite,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primaryWhite),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: validator,
            autocorrect: true,
            enableIMEPersonalizedLearning: true,
            scrollController: ScrollController(),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
