import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/components/custom_appbar.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/components/custom_drawer.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/home_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/profile_page/profile_page.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/settings_page/settings_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static int selectedPage = 0;

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedPage = DashboardPage.selectedPage;

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(onItemTap: _onItemTap),
      body: _pages[_selectedPage],
    );
  }
}
