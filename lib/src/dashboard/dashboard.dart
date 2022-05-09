import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/dashboard/components/dashboardScreen.dart';
import 'package:hard_and_soft_mobile/src/templates/appBarTemplate.dart';
import 'package:hard_and_soft_mobile/src/utils/routes.dart';

class Dashboard extends StatefulWidget {
  final int index;

  const Dashboard({Key? key, required this.index}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int _selectedIndex = widget.index;

  final routes = [
    RouteJSON(title: "Dashboard", screen: const DashboardScreen()),
    RouteJSON(title: "Pannel", screen: const DashboardScreen()),
    RouteJSON(title: "Settings", screen: const DashboardScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(title: routes[_selectedIndex].title!),
      body: routes[_selectedIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speed),
            label: "Pannel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
