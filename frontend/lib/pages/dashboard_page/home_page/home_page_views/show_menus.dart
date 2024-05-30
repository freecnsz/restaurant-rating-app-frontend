import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/menu_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/services/menu_service.dart';

class ShowMenuWidget extends StatefulWidget {
  final bool isCurrentUser;
  final String title;
  final int placeId;
  final VoidCallback onBackPressed;
  final VoidCallback onAddPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onForwardPressed;
  final VoidCallback onDeletePressed;
  final bool isEditing;

  const ShowMenuWidget({
    Key? key,
    required this.isCurrentUser,
    required this.title,
    required this.placeId,
    required this.onBackPressed,
    required this.onAddPressed,
    required this.onEditPressed,
    required this.onForwardPressed,
    required this.onDeletePressed,
    required this.isEditing,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShowMenuWidgetState createState() => _ShowMenuWidgetState();
}

class _ShowMenuWidgetState extends State<ShowMenuWidget> {
  late Future<List<MenuModel>> menuFuture;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isEditing;
  }

  FutureBuilder<void> getMenuByPlaceId(int placeId) {
    menuFuture = MenuService.getMenuByPlaceId(placeId).then((value) {
      return value.data!;
    });
    return FutureBuilder<List<MenuModel>>(
      future: menuFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Menü bulunamadı!'));
        } else {
          final menus = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    final menu = menus[index];
                    return Card(
                      color: AppColors.primaryWhite,
                      child: ListTile(
                        title: Text(
                          menu.name!,
                          style: const TextStyle(
                            fontFamily: AppStrings.fontFamiliy,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.iconColor,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              menu.description!,
                              style: const TextStyle(
                                fontFamily: AppStrings.fontFamiliy,
                                fontSize: 16,
                                color: AppColors.iconColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text("|",
                                style: TextStyle(color: AppColors.iconColor)),
                            const SizedBox(width: 10),
                            Text(
                              menu.menuRate != null
                                  ? "Skor: ${menu.menuRate}"
                                  : "Henüz puan yok",
                              style: const TextStyle(
                                fontFamily: AppStrings.fontFamiliy,
                                fontSize: 16,
                                color: AppColors.iconColor,
                              ),
                            ),
                          ],
                        ),
                        trailing: _isEditing
                            ? IconButton(
                                tooltip: "Sil",
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    widget.isCurrentUser
                                        ? HomePageStateData
                                                .selectedMenuModelForCurrentUser =
                                            menu
                                        : HomePageStateData
                                                .selectedMenuModelForOtherUser =
                                            menu;
                                    widget.onDeletePressed();
                                  });
                                },
                                color: AppColors.iconColor,
                              )
                            : IconButton(
                                tooltip: "Detaylar",
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                                onPressed: () {
                                  widget.isCurrentUser
                                      ? HomePageStateData
                                              .selectedMenuModelForCurrentUser =
                                          menu
                                      : HomePageStateData
                                          .selectedMenuModelForOtherUser = menu;
                                  widget.onForwardPressed();
                                },
                                color: AppColors.iconColor,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: AppStrings.fontFamiliy,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryWhite,
          ),
        ),
        leading: IconButton(
          tooltip: "Geri dön",
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primaryWhite,
          onPressed: widget.onBackPressed,
        ),
        actions: [
          if (widget.isCurrentUser)
            IconButton(
              iconSize: 35,
              tooltip: "Menü ekle",
              icon: const Icon(
                Icons.add_rounded,
                size: 50,
                color: AppColors.iconColor,
              ),
              onPressed: widget.onAddPressed,
            ),
          const SizedBox(width: 15),
          if (widget.isCurrentUser)
            IconButton(
              iconSize: 35,
              tooltip: _isEditing ? "Kaydet" : "Düzenle",
              icon: Icon(_isEditing ? Icons.done_rounded : Icons.edit_rounded),
              onPressed: widget.onEditPressed,
              color: AppColors.iconColor,
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.seconderyYellow,
        padding: const EdgeInsets.all(16.0),
        child: getMenuByPlaceId(widget.placeId),
      ),
    );
  }
}
