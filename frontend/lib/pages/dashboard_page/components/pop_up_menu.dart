import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/login_page/login_page.dart';
import 'package:restaurant_rating_frontend/shared_preferences/user_preferences.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.seconderyYellow,
      iconColor: AppColors.iconColor,
      contentTextStyle: const TextStyle(
          fontFamily: AppStrings.fontFamiliy, color: AppColors.primaryWhite),
      content: const Text(
        AppStrings.textAreYouSureToLogout,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await UserPreferences.clearUserInfo();
            // Clear navigation stack and navigate to login page
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false,
            );
          },
          child: const Text(
            AppStrings.textYes,
            style: TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                color: AppColors.primaryWhite),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            AppStrings.textNo,
            style: TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                color: AppColors.primaryWhite),
          ),
        ),
      ],
    );
  }
}
