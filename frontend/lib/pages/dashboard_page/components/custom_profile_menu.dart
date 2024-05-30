import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/components/pop_up_menu.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/dashboard.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/containers/home_page_state_data_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page.dart';
import 'package:restaurant_rating_frontend/shared_preferences/user_preferences.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await UserPreferences.getUserInfo();
      setState(() {
        username = userInfo['username']!;
        if (username.length > 15) {
          username = '${username.substring(0, 15)}...';
        }
      });
    } catch (e) {
      setState(() {
        username = "Kullanıcı Adı Yok";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.primaryBlack),
      ),
      icon: const Icon(
        Icons.account_circle,
        size: 35,
        color: AppColors.iconColor,
      ),
      color: AppColors.primaryWhite,
      tooltip: "Hesabım",
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Text(
            username,
            style: const TextStyle(
              color: AppColors.iconColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.fontFamiliy,
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 0,
          child: ListTile(
            leading: Icon(
              Icons.info,
              color: AppColors.iconColor,
            ),
            title: Text(
              'Hesap bilgileri',
              style: TextStyle(
                color: AppColors.iconColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColors.iconColor,
              ),
              title: Text(
                'Ayarlar',
                style: TextStyle(
                  color: AppColors.iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppStrings.fontFamiliy,
                ),
              )),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: AppColors.iconColor,
            ),
            title: Text('Çıkış yap',
                style: TextStyle(
                  color: AppColors.iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppStrings.fontFamiliy,
                )),
          ),
        )
      ],
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          HomePageStateData.currentPage = HomePageView.restaurantDetails;
          HomePageStateData.otherPage = HomePageView.scoreboard;
          DashboardPage.selectedPage = 1;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );
        break;
      case 1:
        setState(() {
          HomePageStateData.currentPage = HomePageView.restaurantDetails;
          HomePageStateData.otherPage = HomePageView.scoreboard;
          DashboardPage.selectedPage = 2;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );

        break;
      case 2:
        showDialog(
          context: context,
          builder: (context) => const LogoutConfirmationDialog(),
        );
        break;
    }
  }
}
