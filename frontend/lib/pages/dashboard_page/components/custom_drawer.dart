import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/components/pop_up_menu.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemTap;

  const CustomDrawer({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Diğer seçenekler',
      backgroundColor: AppColors.primaryWhite,
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: 100,
              height: 50,
              child: Image.asset(
                Paths.pathLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDrawerItem(
            context,
            title: AppStrings.buttonHome,
            icon: Icons.home_filled,
            index: 0,
            onItemTap: onItemTap,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDrawerItem(
            context,
            title: AppStrings.buttonProfile,
            icon: Icons.account_circle_rounded,
            index: 1,
            onItemTap: onItemTap,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDrawerItem(
            context,
            title: AppStrings.buttonSettings,
            icon: Icons.settings,
            index: 2,
            onItemTap: onItemTap,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20.0),
            child: _buildDrawerItem(
              context,
              title: AppStrings.buttonLogout,
              icon: Icons.logout,
              index: 3,
              onItemTap: (index) {
                Navigator.pop(
                    context); // Close the drawer before showing dialog
                showDialog(
                  context: context,
                  builder: (context) => const LogoutConfirmationDialog(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int index,
    required Function(int) onItemTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.iconColor,
              fontFamily: AppStrings.fontFamiliy,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        tileColor: AppColors.primaryWhite,
        trailing: Icon(
          icon,
          color: AppColors.iconColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.primaryBlack),
        ),
        onTap: () {
          if (index != 3) {
            onItemTap(index);
            Navigator.pop(context); // Close the drawer after selection
          } else {
            Navigator.pop(context); // Close the drawer before showing dialog
            showDialog(
              context: context,
              builder: (context) => const LogoutConfirmationDialog(),
            );
          }
        },
      ),
    );
  }
}
