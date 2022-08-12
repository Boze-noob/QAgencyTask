import 'package:flutter/material.dart';
import 'package:q_agency_task/_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          print("Index $index");
          _selectedIndex = index;
        }),
        items: [
          bottomNavBarItem("assets/icons/movies.png", "Movies", context),
          bottomNavBarItem("assets/icons/favourites.png", "Favourites", context)
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(String iconPath, String title, BuildContext context) {
  return BottomNavigationBarItem(
    icon: SizedBox(
      height: kBottomNavigationBarHeight,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: context.appTheme.theme.unselectedWidgetColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ),
    activeIcon: SizedBox(
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Divider(
            height: 2,
            thickness: 2,
            indent: 38, //38px from left side
            endIndent: 38, //38px from right side
            color: context.appTheme.theme.primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                color: context.appTheme.theme.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, color: context.appTheme.theme.primaryColor),
              )
            ],
          ),
          const SizedBox(
            height: 2,
          )
        ],
      ),
    ),
    label: "",
  );
}
