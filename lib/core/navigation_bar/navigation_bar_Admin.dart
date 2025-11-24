import 'package:iconsax/iconsax.dart';
import 'package:taka_naqis/core/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../features/admin/view/HomeAdmin.dart';
import '../../features/admin/view/OrdersAdmin.dart';
import '../../features/admin/view/details/details.dart';
import '../../features/user/view/Home.dart';
import '../../features/user/view/basket.dart';
import '../../features/user/view/favorites.dart';
import '../../features/user/view/orders.dart';
import '../../features/user/view/profile.dart';

class BottomNavBarAdmin extends StatefulWidget {
  @override
  _BottomNavBarAdminState createState() => _BottomNavBarAdminState();
}

class _BottomNavBarAdminState extends State<BottomNavBarAdmin> {
  int _selectedIndex = 3;
  final List<Widget> _widgetOptions = [
    Profile(),
    Details(),
    OrdersAdmin(),
    HomeAdmin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor,
              color: Colors.black,
              tabs: [
                GButton(
                  leading: _selectedIndex==0?Icon(Iconsax.user_octagon,color: Colors.white,):Icon(Iconsax.user_octagon),
                  icon: Icons.verified_user,
                  text: 'حسابي',
                ),
                GButton(
                  leading: _selectedIndex==1?Icon(Iconsax.setting,color: Colors.white,):Icon(Iconsax.setting),
                  icon: Icons.verified_user,
                  text: 'الاعدادات',
                ),
                GButton(
                  leading: _selectedIndex==2?Icon(Iconsax.box,color: Colors.white,):Icon(Iconsax.box),
                  icon: Icons.headphones,
                  text: 'طلباتي',
                ),
                GButton(
                  leading: _selectedIndex==3?Icon(Iconsax.home,color: Colors.white,):Icon(Iconsax.home),
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
    );
  }
}