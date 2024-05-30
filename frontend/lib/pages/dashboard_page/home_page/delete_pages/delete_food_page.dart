import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/services/food_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class DeleteFoodConfirmationDialog extends StatefulWidget {
  final int foodId;
  const DeleteFoodConfirmationDialog({
    super.key,
    required this.foodId,
  });

  @override
  State<DeleteFoodConfirmationDialog> createState() =>
      _DeleteFoodConfirmationDialogState();
}

class _DeleteFoodConfirmationDialogState
    extends State<DeleteFoodConfirmationDialog> {
  Future<void> deleteFood() async {
    await FoodService.deleteFood(widget.foodId).then((value) => {
          if (value)
            {
              Navigator.of(context).pop(),
              CustomSnackbar.show(context, "Ürün başarıyla silindi",
                  backgroundColor: Colors.green, icon: Icons.check),
            }
          else
            {
              Navigator.of(context).pop(),
              CustomSnackbar.show(context, "Ürün silinirken bir hata oluştu",
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
        "Ürünü silmek istediğinize emin misiniz?",
      ),
      actions: [
        TextButton(
          onPressed: () async {
            deleteFood();
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
