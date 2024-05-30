import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/components/custom_profile_menu.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/dashboard.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page.dart';
import 'package:restaurant_rating_frontend/services/location_service.dart';
import 'package:restaurant_rating_frontend/services/time_service.dart';
import 'package:restaurant_rating_frontend/shared_preferences/user_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final double appBarHeight = 56.0;
  int userCityId = 0;
  String userCityName = 'City Name';

  @override
  void initState() {
    super.initState();
    getCityName();
  }

  Future<void> getCityName() async {
    try {
      final userInfo = await UserPreferences.getUserInfo();
      if (userInfo['cityId'] != null) {
        userCityId = int.parse(userInfo['cityId']!);

        final city = await LocationService.getCityById(userCityId);
        if (city.data != null && city.data!.name != null) {
          setState(() {
            userCityName = city.data!.name!;
          });
        } else {
          setState(() {
            userCityName = 'City Name';
          });
        }
      }
    } catch (e) {
      setState(() {
        userCityName = 'Konum Bulunamadı';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        tooltip: "Menü",
        icon: const Icon(Icons.menu, size: 30, color: AppColors.iconColor),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        color: AppColors.primaryWhite,
      ),
      backgroundColor: AppColors.seconderyYellow,
      iconTheme: const IconThemeData(color: AppColors.iconColor),
      title: SizedBox(
        width: 100,
        height: 50,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            HomePageStateData.currentPage = HomePageView.restaurantDetails;
            HomePageStateData.otherPage = HomePageView.scoreboard;
            DashboardPage.selectedPage = 0;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            );
          },
          icon: Image.asset(
            Paths.pathLogo,
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        Center(
          child: Row(
            children: [
              const Icon(
                Icons.access_time_filled_rounded,
                color: AppColors.iconColor,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              StreamBuilder<String>(
                stream: TimeService.getTime(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: AppColors.primaryWhite,
                    );
                  } else if (snapshot.hasError) {
                    return const Text(':(:(:(:(');
                  } else if (!snapshot.hasData) {
                    return const Text('Veri yok');
                  } else {
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(
                        color: AppColors.primaryWhite,
                        fontFamily: AppStrings.fontFamiliy,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Center(
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.iconColor,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(userCityName,
                  style: const TextStyle(
                      color: AppColors.primaryWhite,
                      fontFamily: AppStrings.fontFamiliy,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const ProfileMenu(),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
