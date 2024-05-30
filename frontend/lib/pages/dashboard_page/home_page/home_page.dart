import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/score_board_container_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/user_container_page.dart';
import 'package:restaurant_rating_frontend/services/place_service.dart';
import 'package:restaurant_rating_frontend/shared_preferences/user_preferences.dart';

enum HomePageView {
  restaurantDetails,
  scoreboard,
  showMenu,
  otherRestaurantDetails,
  menuDetails,
  foodDetails,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  bool _hasError = false;
  int userPlaceId = 0;
  int userCityId = 0;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await UserPreferences.getUserInfo();
      setState(() {
        userPlaceId = int.parse(userInfo['placeId']!);
        userCityId = int.parse(userInfo['cityId']!);
      });

      await Future.wait([_loadPlaces(), _loadUserPlace()]);
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUserPlace() async {
    try {
      final result = await PlaceService.getPlaceById(userPlaceId);
      setState(() {
        HomePageStateData.userPlace = result.data!;
      });
    } catch (e) {
      throw Exception('Failed to load user place: $e');
    }
  }

  Future<void> _loadPlaces() async {
    try {
      final result = await PlaceService.getPlaceByCityId(userCityId);
      setState(() {
        HomePageStateData.places = result.data!;
        if (HomePageStateData.places.isNotEmpty) {
          HomePageStateData.places
              .sort((a, b) => b.ratePoint!.compareTo(a.ratePoint!));
        }
      });
    } catch (e) {
      throw Exception('Failed to load places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _isLoading
                  ? _buildLoadingWidget()
                  : _hasError
                      ? _buildErrorWidget(
                          "Mekan bilgileri yüklenirken bir hata oluştu :(")
                      : UserRestaurantContainer(
                          placeId: userPlaceId, cityId: userCityId),
            ),
          ),
          const VerticalDivider(
            color: AppColors.iconColor,
            thickness: 2,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _isLoading
                  ? _buildLoadingWidget()
                  : _hasError
                      ? _buildErrorWidget(
                          "FoodLig yüklenirken bir hata oluştu :(")
                      : const ScoreBoardContainer(),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildErrorWidget(String message) {
    return Container(
      color: AppColors.seconderyYellow,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
              color: AppColors.iconColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.fontFamiliy),
        ),
      ),
    );
  }

  Container _buildLoadingWidget() {
    return Container(
      color: AppColors.seconderyYellow,
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.iconColor),
        ),
      ),
    );
  }
}
