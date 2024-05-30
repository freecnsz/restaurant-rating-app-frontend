import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/create_pages/create_food_pages/create_food_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/create_pages/create_menu_page/create_menu_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/delete_pages/delete_food_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/delete_pages/delete_menu_pages.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/edit_pages/food_details_edit_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/food_details.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/menu_details.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/restaurant_details.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/restaurant_details_edit.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/show_menus.dart';

class UserRestaurantContainer extends StatefulWidget {
  final int placeId;
  final int cityId;
  const UserRestaurantContainer({
    super.key,
    required this.placeId,
    required this.cityId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _UserRestaurantContainerState createState() =>
      _UserRestaurantContainerState();
}

class _UserRestaurantContainerState extends State<UserRestaurantContainer> {
  @override
  Widget build(BuildContext context) {
    return _buildCurrentPageForUserRestaurant();
  }

  Widget _buildCurrentPageForUserRestaurant() {
    switch (HomePageStateData.currentPage) {
      case HomePageView.restaurantDetails:
        return RestaurantDetailsWidget(
          placeModel: HomePageStateData.userPlace ?? PlaceModel(),
          onBackPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.restaurantDetails;
            });
          },
          isUserPlace: true,
          onEditPressed: () {
            showDialog(
                context: context,
                builder: (context) => EditRestaurantDetailsPage(
                      placeId: widget.placeId,
                      placeModel: HomePageStateData.userPlace ?? PlaceModel(),
                    ));
          },
          onShowMenuPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.showMenu;
            });
          },
        );
      case HomePageView.showMenu:
        return ShowMenuWidget(
          onDeletePressed: () {
            showDialog(
                context: context,
                builder: (context) => DeleteMenuConfirmationDialog(
                      menuId: HomePageStateData
                              .selectedMenuModelForCurrentUser!.id ??
                          0,
                    ));
          },
          placeId: widget.placeId,
          isCurrentUser: true,
          title: "Menülerim",
          onBackPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.restaurantDetails;
            });
          },
          onAddPressed: () {
            showDialog(
                context: context,
                builder: (context) => AddMenuDialog(
                      placeId: widget.placeId,
                    ));
          },
          onEditPressed: () {
            setState(() {
              HomePageStateData.isEditingShowMenu =
                  !HomePageStateData.isEditingShowMenu;
            });
          },
          onForwardPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.menuDetails;
            });
          },
          isEditing: HomePageStateData.isEditingShowMenu,
        );
      case HomePageView.menuDetails:
        return MenuDetailsPage(
          onAddPressed: () {
            showDialog(
                context: context,
                builder: (context) => CreateFoodDialog(
                      menuId: HomePageStateData
                              .selectedMenuModelForCurrentUser!.id ??
                          0,
                    ));
          },
          onDeletePressed: () {
            showDialog(
                context: context,
                builder: (context) => DeleteFoodConfirmationDialog(
                      foodId: HomePageStateData
                              .selectedFoodModelForCurrentUser!.id ??
                          0,
                    ));
          },
          isEditing: HomePageStateData.isEditingMenuDetail,
          menuModel: HomePageStateData.selectedMenuModelForCurrentUser!,
          onBackPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.showMenu;
            });
          },
          isUserMenu: true,
          onEditPressed: () {
            setState(() {
              HomePageStateData.isEditingMenuDetail =
                  !HomePageStateData.isEditingMenuDetail;
            });
          },
          onShowForwardsPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.foodDetails;
            });
          },
        );
      case HomePageView.foodDetails:
        return FoodDetailsWidget(
          foodId: HomePageStateData.selectedFoodModelForCurrentUser!.id ?? 0,
          onEditPressed: () {
            showDialog(
                context: context,
                builder: (context) => EditFoodDetailsPage(
                      foodId: HomePageStateData
                              .selectedFoodModelForCurrentUser!.id ??
                          0,
                      onSave: (updatedFood) {
                        setState(() {});
                      },
                    ));
          },
          isCurrentUser: true,
          onBackPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.menuDetails;
            });
          },
        );
      default:
        return RestaurantDetailsWidget(
          placeModel: HomePageStateData.userPlace ?? PlaceModel(),
          onBackPressed: () {},
          isUserPlace: true,
          onEditPressed: () {
            showDialog(
                context: context,
                builder: (context) => EditRestaurantDetailsPage(
                      placeId: widget.placeId,
                      placeModel: HomePageStateData.userPlace ?? PlaceModel(),
                    ));
          },
          onShowMenuPressed: () {
            setState(() {
              HomePageStateData.currentPage = HomePageView.showMenu;
            });
          },
        );
    }
  }
}
