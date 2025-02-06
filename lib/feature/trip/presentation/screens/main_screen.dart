import 'package:clean_archi_travel_app/feature/trip/presentation/screens/add_trip_screen.dart';
import 'package:clean_archi_travel_app/feature/trip/presentation/screens/my_trip_screen.dart';
import 'package:clean_archi_travel_app/feature/trip/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController pageController;
  final ValueNotifier<int> _indexPage = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => _indexPage.value = value,
        children: [
          TripScreen(),
          AddTripScreen(),
          MapScreen(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _indexPage,
        builder: (context, value, child) => BottomNavigationBar(
          currentIndex: value,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "My trips"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add trip"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          ],
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: Text(
      "Hi Yacine 👋\ntraveling today ? ",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    actions: [
      CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage("assets/images/pfp.png"),
      ),
    ],
  );
}
