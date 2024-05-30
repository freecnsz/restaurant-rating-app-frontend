import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/services/menu_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class DeleteMenuConfirmationDialog extends StatefulWidget {
  final int menuId;
  const DeleteMenuConfirmationDialog({
    super.key,
    required this.menuId,
  });

  @override
  State<DeleteMenuConfirmationDialog> createState() =>
      _DeleteMenuConfirmationDialogState();
}

class _DeleteMenuConfirmationDialogState
    extends State<DeleteMenuConfirmationDialog> {
  Future<void> deleteMenu() async {
    await MenuService.deleteMenu(widget.menuId).then((value) => {
          if (value)
            {
              Navigator.of(context).pop(),
              CustomSnackbar.show(context, "Menü başarıyla silindi",
                  backgroundColor: Colors.green, icon: Icons.check),
            }
          else
            {
              Navigator.of(context).pop(),
              CustomSnackbar.show(context, "Menü silinirken bir hata oluştu",
                  backgroundColor: Colors.red, icon: Icons.error),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.seconderyYellow,
      iconColor: AppColors.iconColor,
      contentTextStyle: const TextStyle(
          fontFamily: AppStrings.fontFamiliy, color: AppColors.primaryWhite),
      content: const Text(
        "Menüyü silmek istediğinize emin misiniz?",
      ),
      actions: [
        TextButton(
          onPressed: () async {
            deleteMenu();
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
