import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/menu_model.dart';
import 'package:restaurant_rating_frontend/models/food_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/services/food_service.dart';

class MenuDetailsPage extends StatefulWidget {
  final bool isEditing;
  final MenuModel menuModel;
  final VoidCallback onBackPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onShowForwardsPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onAddPressed;
  final bool isUserMenu;

  const MenuDetailsPage(
      {Key? key,
      required this.isEditing,
      required this.menuModel,
      required this.onBackPressed,
      required this.onEditPressed,
      required this.onShowForwardsPressed,
      required this.onDeletePressed,
      required this.onAddPressed,
      required this.isUserMenu,
      re})
      : super(key: key);

  @override
  State<MenuDetailsPage> createState() => _MenuDetailsPageState();
}

class _MenuDetailsPageState extends State<MenuDetailsPage> {
  bool _isEditing = false;
  int menuId = 0;
  late Future<BaseFoodModel> foodItemsFuture;

  @override
  void initState() {
    super.initState();
    menuId = widget.menuModel.id!;
    _isEditing = widget.isEditing;
  }

  FutureBuilder<void> getFoodByMenuId(int menuId) {
    foodItemsFuture = FoodService.getFoodByMenuId(menuId);

    return FutureBuilder<BaseFoodModel>(
      future: foodItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text("Ürün bulunurken bir hata oluştu!",
                  style: TextStyle(
                    color: AppColors.iconColor,
                    fontSize: 16,
                    fontFamily: AppStrings.fontFamiliy,
                  )));
        } else if (!snapshot.hasData) {
          return const Center(
              child: Text('Ürün bulunamadı!',
                  style: TextStyle(
                    color: AppColors.iconColor,
                    fontSize: 16,
                    fontFamily: AppStrings.fontFamiliy,
                  )));
        } else {
          final items = snapshot.data!.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                color: AppColors.primaryWhite,
                child: ListTile(
                  title: Text(
                    item.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.iconColor,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '${item.price} TL',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.iconColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text("|",
                          style: TextStyle(color: AppColors.iconColor)),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star,
                        color: AppColors.iconColor,
                      ),
                      const SizedBox(width: 5),
                      RatingBarIndicator(
                        rating: item.ratePoint! > 0 ? item.ratePoint! : 0.0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: AppColors.iconColor,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      )
                    ],
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          tooltip: "Sil",
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            widget.isUserMenu
                                ? HomePageStateData
                                    .selectedFoodModelForCurrentUser = item
                                : HomePageStateData
                                    .selectedFoodModelForOtherUser = item;
                            widget.onDeletePressed();
                          },
                          color: AppColors.iconColor,
                        )
                      : IconButton(
                          tooltip: "Detaylar",
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: (() {
                            widget.isUserMenu
                                ? HomePageStateData
                                    .selectedFoodModelForCurrentUser = item
                                : HomePageStateData
                                    .selectedFoodModelForOtherUser = item;
                            widget.onShowForwardsPressed();
                          }),
                          color: AppColors.iconColor,
                        ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.seconderyYellow,
        title: const Text(
          "Menü Detayları",
          style: TextStyle(
            fontFamily: AppStrings.fontFamiliy,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryWhite,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: widget.onBackPressed,
          color: AppColors.primaryWhite,
        ),
        actions: [
          if (widget.isUserMenu)
            IconButton(
              iconSize: 30,
              tooltip: "Ürün Ekle",
              icon: const Icon(Icons.add),
              onPressed: () {
                widget.onAddPressed();
              },
              color: AppColors.iconColor,
            ),
          if (widget.isUserMenu)
            IconButton(
              iconSize: 30,
              tooltip: _isEditing ? "Kaydet" : "Düzenle",
              icon: Icon(_isEditing ? Icons.done_rounded : Icons.edit_rounded),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
                widget.onEditPressed();
              },
              color: AppColors.iconColor,
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.seconderyYellow,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.menuModel.name!,
              style: const TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  widget.menuModel.description!,
                  style: const TextStyle(
                    fontFamily: AppStrings.fontFamiliy,
                    fontSize: 16,
                    color: AppColors.primaryWhite,
                  ),
                ),
                const Spacer(),
                Text(
                  "Skor: ${widget.menuModel.menuRate}",
                  style: const TextStyle(
                    fontFamily: AppStrings.fontFamiliy,
                    fontSize: 20,
                    color: AppColors.primaryWhite,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              color: AppColors.primaryWhite,
              thickness: 2,
            ),
            const Text(
              "Ürünler:",
              style: TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                fontSize: 20,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: getFoodByMenuId(menuId),
            ),
          ],
        ),
      ),
    );
  }
}
