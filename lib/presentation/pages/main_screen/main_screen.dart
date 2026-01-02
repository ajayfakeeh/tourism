import 'package:flutter/material.dart';
import 'package:location/presentation/pages/add_place/add_place_page.dart';
import 'package:location/presentation/pages/home/homepage.dart';
import 'package:location/presentation/pages/main_screen/widgets/custom_bottom_navigation_bar.dart';
import 'package:location/presentation/pages/reviews/reviews_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AddPlacePage(),
    const ReviewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
