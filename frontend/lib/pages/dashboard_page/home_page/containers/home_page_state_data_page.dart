import 'package:restaurant_rating_frontend/models/food_model.dart';
import 'package:restaurant_rating_frontend/models/menu_model.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page.dart';

class HomePageStateData {
  static MenuModel? selectedMenuModelForCurrentUser;
  static MenuModel? selectedMenuModelForOtherUser;
  static List<PlaceModel> places = [];
  static PlaceModel? userPlace;
  static PlaceModel? otherPlace;
  static bool isEditingFoodDetail = false;
  static bool isEditingMenuDetail = false;
  static bool isEditingPlaceDetail = false;
  static bool isEditingRestaurantDetail = false;
  static bool isEditingShowMenu = false;
  static HomePageView currentPage = HomePageView.restaurantDetails;
  static HomePageView otherPage = HomePageView.scoreboard;
  static FoodModel? selectedFoodModelForCurrentUser;
  static FoodModel? selectedFoodModelForOtherUser;
}
