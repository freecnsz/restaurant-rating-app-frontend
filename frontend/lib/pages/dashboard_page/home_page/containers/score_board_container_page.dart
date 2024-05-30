import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/models/menu_model.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/food_details.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/menu_details.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/restaurant_details.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/score_board.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page_views/show_menus.dart';

class ScoreBoardContainer extends StatefulWidget {
  const ScoreBoardContainer({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ScoreBoardContainerState createState() => _ScoreBoardContainerState();
}

class _ScoreBoardContainerState extends State<ScoreBoardContainer> {
  MenuModel? get menuModel => null;

  @override
  Widget build(BuildContext context) {
    return _buildCurrentPageForScoreBoard();
  }

  Widget _buildCurrentPageForScoreBoard() {
    switch (HomePageStateData.otherPage) {
      case HomePageView.scoreboard:
        return ScoreboardWidget(
          places: HomePageStateData.places,
          onPlaceSelected: (place) {
            setState(() {
              HomePageStateData.otherPlace = place;
              HomePageStateData.otherPage = HomePageView.otherRestaurantDetails;
            });
          },
        );
      case HomePageView.otherRestaurantDetails:
        return RestaurantDetailsWidget(
          placeModel: HomePageStateData.otherPlace ?? PlaceModel(),
          onBackPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.scoreboard;
            });
          },
          isUserPlace: false,
          onEditPressed: () {},
          onShowMenuPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.showMenu;
            });
          },
        );
      case HomePageView.showMenu:
        return ShowMenuWidget(
          onDeletePressed: () {},
          placeId: HomePageStateData.otherPlace!.id ?? 0,
          isCurrentUser: false,
          title: "Menüler",
          onBackPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.otherRestaurantDetails;
            });
          },
          onAddPressed: () {},
          onEditPressed: () {},
          onForwardPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.menuDetails;
            });
          },
          isEditing: false,
        );
      case HomePageView.menuDetails:
        return MenuDetailsPage(
          onAddPressed: () {},
          onDeletePressed: () {},
          isEditing: false,
          menuModel: HomePageStateData.selectedMenuModelForOtherUser!,
          onBackPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.showMenu;
            });
          },
          isUserMenu: false,
          onEditPressed: () {},
          onShowForwardsPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.foodDetails;
            });
          },
        );
      case HomePageView.foodDetails:
        return FoodDetailsWidget(
          foodId: HomePageStateData.selectedFoodModelForOtherUser!.id ?? 0,
          onEditPressed: () {},
          isCurrentUser: false,
          onBackPressed: () {
            setState(() {
              HomePageStateData.otherPage = HomePageView.menuDetails;
            });
          },
        );
      default:
        return ScoreboardWidget(
          places: HomePageStateData.places,
          onPlaceSelected: (place) {
            setState(() {
              HomePageStateData.otherPlace = place;
              HomePageStateData.otherPage = HomePageView.otherRestaurantDetails;
            });
          },
        );
    }
  }
}
