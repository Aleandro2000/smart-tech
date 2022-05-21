import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/dashboard/components/dashboardScreen.dart';
import 'package:hard_and_soft_mobile/src/dashboard/components/pannelScreens.dart';
import 'package:hard_and_soft_mobile/src/dashboard/components/settingsScreen.dart';
import 'package:hard_and_soft_mobile/src/templates/dashboardAppBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/models/routes.dart';
import 'package:hard_and_soft_mobile/src/utils/themeColors.dart';

class Dashboard extends StatefulWidget {
  final int index;

  const Dashboard({Key? key, required this.index}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int _selectedIndex = widget.index;

  final List<RouteJSON> routes = [
    RouteJSON(title: "Dashboard", screen: const DashboardScreen()),
    RouteJSON(title: "Pannel", screen: const PannelScreen()),
    RouteJSON(title: "Settings", screen: const SettingsScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBarTemplate(title: routes[_selectedIndex].title!),
      body: routes[_selectedIndex].screen,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting, // Shifting
          selectedItemColor: ThemeColors.selectedNavbarItem,
          unselectedItemColor: ThemeColors.unselectedNavbarItem,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
              backgroundColor: ThemeColors.backgroundNavbarTheme,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.speed),
              label: "Pannel",
              backgroundColor: ThemeColors.backgroundNavbarTheme,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              backgroundColor: ThemeColors.backgroundNavbarTheme,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
