import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';

class RestaurantDetailsWidget extends StatelessWidget {
  final PlaceModel placeModel;
  final bool isUserPlace;
  final VoidCallback onBackPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onShowMenuPressed;

  const RestaurantDetailsWidget({
    Key? key,
    required this.placeModel,
    required this.isUserPlace,
    required this.onBackPressed,
    required this.onEditPressed,
    required this.onShowMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isUserPlace
          ? null
          : AppBar(
              backgroundColor: AppColors.seconderyYellow,
              title: const Text(
                "Restoran Detayları",
                style: TextStyle(
                  fontFamily: AppStrings.fontFamiliy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryWhite,
                ),
              ),
              leading: IconButton(
                tooltip: "Geri dön",
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: onBackPressed,
                color: AppColors.primaryWhite,
              ),
            ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.seconderyYellow,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placeModel.name ?? "Restoran Adı",
                        style: const TextStyle(
                          fontFamily: AppStrings.fontFamiliy,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        placeModel.placeTypeName ?? "Restoran Türü",
                        style: const TextStyle(
                          fontFamily: AppStrings.fontFamiliy,
                          fontSize: 12,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.restaurant,
                    size: 100,
                    color: AppColors.primaryWhite,
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
            const SizedBox(height: 8),
            Text(
              placeModel.description ?? "Restoran Açıklaması",
              style: const TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                fontSize: 16,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: AppColors.primaryWhite,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Skor: ${placeModel.ratePoint?.toString() ?? 'N/A'}",
                  style: const TextStyle(
                    fontFamily: AppStrings.fontFamiliy,
                    fontSize: 20,
                    color: AppColors.primaryWhite,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "(${placeModel.rateCount?.toString() ?? 'N/A'} kişi puanladı)",
                  style: const TextStyle(
                    fontFamily: AppStrings.fontFamiliy,
                    fontSize: 16,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              color: AppColors.primaryWhite,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Text(
              "Adres: ${placeModel.address ?? 'N/A'}",
              style: const TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                fontSize: 16,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: AppColors.primaryWhite,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Text(
              "${placeModel.districtName ?? 'N/A'} / ${placeModel.cityName ?? 'N/A'}",
              style: const TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                fontSize: 16,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(height: 8),
            const Spacer(),
            isUserPlace
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        tooltip: "Düzenle",
                        onPressed: onEditPressed,
                        backgroundColor: AppColors.iconColor,
                        child: const Icon(Icons.edit),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        tooltip: "Menüleri Göster",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: onShowMenuPressed,
                        backgroundColor: AppColors.iconColor,
                        child: const Icon(Icons.menu_book),
                      ),
                    ],
                  )
                : FloatingActionButton(
                    tooltip: "Menüleri Göster",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: onShowMenuPressed,
                    backgroundColor: AppColors.iconColor,
                    child: const Icon(Icons.menu_book),
                  ),
          ],
        ),
      ),
    );
  }
}
