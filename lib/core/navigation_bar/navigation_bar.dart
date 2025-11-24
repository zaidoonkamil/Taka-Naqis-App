import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taka_naqis/core/styles/themes.dart';

import '../../features/user/view/Home.dart';
import '../../features/user/view/orders.dart';
import '../../features/user/view/profile.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = [
    Profile(),
    Orders(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _widgetOptions[_selectedIndex],

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30,left: 14,right: 14),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(
                    color: secondPrimaryColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: secondPrimaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor: secondPrimaryColor,

                    tabs: [
                      GButton(
                        leading: _selectedIndex==0?Icon(Iconsax.user_octagon,color: Colors.white,):Icon(Iconsax.user_octagon),
                        icon: Icons.verified_user,
                        text: 'حسابي',
                      ),
                      GButton(
                        leading: _selectedIndex==1?Icon(Iconsax.box,color: Colors.white,):Icon(Iconsax.box),
                        icon: Icons.headphones,
                        text: 'طلباتي',
                        ),

                      GButton(
                        leading: _selectedIndex==2?Icon(Iconsax.home,color: Colors.white,):Icon(Iconsax.home),
                        text: 'الرئيسية',
                        icon: Icons.home,
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
