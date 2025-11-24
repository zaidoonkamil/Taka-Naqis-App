import 'package:taka_naqis/core/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../features/agent/view/HomeAgent.dart';
import '../../features/agent/view/OrdersAgent.dart';
import '../../features/user/view/profile.dart';

class BottomNavBarAgent extends StatefulWidget {
  @override
  _BottomNavBarAgentState createState() => _BottomNavBarAgentState();
}

class _BottomNavBarAgentState extends State<BottomNavBarAgent> {
  int _selectedIndex = 2;
  final List<Widget> _widgetOptions = [
    Profile(),
    OrdersAgent(),
    HomeAgent(),
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
                  leading: _selectedIndex==0?Icon(Icons.person,color: Colors.white,):Icon(Icons.person_outline),
                  icon: Icons.verified_user,
                  text: 'حسابي',
                ),
                GButton(
                  leading: _selectedIndex==1?Image.asset('assets/images/package-moving (2).png'):Image.asset('assets/images/package-moving.png'),
                  icon: Icons.headphones,
                  text: 'طلباتي',
                ),
                GButton(
                  leading: _selectedIndex==2?FaIcon(FontAwesomeIcons.house,color: Colors.white, size: 20):FaIcon(FontAwesomeIcons.house, size: 20),
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