import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/SingleFoodModel.dart';
import 'package:restaurant_rating_frontend/services/food_service.dart';

class FoodDetailsWidget extends StatefulWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onEditPressed;
  final bool isCurrentUser;
  final int foodId;

  const FoodDetailsWidget({
    Key? key,
    required this.onBackPressed,
    required this.onEditPressed,
    required this.isCurrentUser,
    required this.foodId,
  }) : super(key: key);

  @override
  State<FoodDetailsWidget> createState() => _FoodDetailsWidgetState();
}

class _FoodDetailsWidgetState extends State<FoodDetailsWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<SingleFoodModel?> getFoodById() async {
    try {
      return await FoodService.getFoodById(widget.foodId);
    } catch (e) {
      throw Exception("Ürün getirilirken bir hata oluştu.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.seconderyYellow,
        title: const Text(
          "Ürün Detayları",
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
          onPressed: widget.onBackPressed,
          color: AppColors.primaryWhite,
        ),
        actions: [
          if (widget.isCurrentUser)
            IconButton(
              tooltip: "Düzenle",
              iconSize: 30,
              icon: const Icon(Icons.edit_rounded),
              onPressed: widget.onEditPressed,
              color: AppColors.iconColor,
            ),
          const SizedBox(width: 10)
        ],
      ),
      body: FutureBuilder<SingleFoodModel?>(
        future: getFoodById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          } else {
            final foodModel = snapshot.data!;
            final foodData = foodModel.data;
            if (foodData == null) {
              return const Center(child: Text('No data found'));
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              color: AppColors.seconderyYellow,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            foodData.name ?? "Ürün Adı",
                            style: const TextStyle(
                              fontFamily: AppStrings.fontFamiliy,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: foodData.foodImage != null
                              ? Image.network(
                                  foodData.foodImage!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.food_bank,
                                  size: 100,
                                  color: AppColors.primaryWhite,
                                ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Fiyat: ${foodData.price?.toString() ?? 'N/A'} TL",
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
                      foodData.description ?? "Yemek Açıklaması",
                      style: const TextStyle(
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: AppColors.primaryWhite,
                      thickness: 2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Yorum Sayısı: ${foodData.commentCount?.toString() ?? 'N/A'}",
                      style: const TextStyle(
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Puan: ${foodData.ratePoint?.toString() ?? 'N/A'}",
                      style: const TextStyle(
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Puan veren kiş sayısı: ${foodData.rateCount?.toString() ?? 'N/A'}",
                      style: const TextStyle(
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: AppColors.primaryWhite,
                      thickness: 2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Menü adı: ${foodData.menuName ?? 'N/A'}",
                      style: const TextStyle(
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Mekan adı: ${foodData.placeName ?? 'N/A'}",
                      style: const TextStyle(
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
