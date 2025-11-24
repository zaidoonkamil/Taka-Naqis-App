import 'package:flutter/material.dart';

import '../../core/ navigation/navigation.dart';
import '../../core/navigation_bar/navigation_bar.dart';
import '../../core/navigation_bar/navigation_bar_Admin.dart';
import '../../core/navigation_bar/navigation_bar_agent.dart';
import '../../core/network/local/cache_helper.dart';
import '../../core/widgets/constant.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      classId = CacheHelper.getData(key: 'classId') ?? 1;
      className = CacheHelper.getData(key: 'class') ?? 'السادس العلمي';
      if(CacheHelper.getData(key: 'token') == null){
        token='';
        if (onBoarding == true) {
          widget = BottomNavBar();
        } else {
          widget = OnboardingScreen();
        }
      }else{
        if(CacheHelper.getData(key: 'role') == null){
          widget = BottomNavBar();
          adminOrUser='user';
        }else{
          adminOrUser = CacheHelper.getData(key: 'role');
          if (adminOrUser == 'admin') {
          widget = BottomNavBarAdmin();
          }else if (adminOrUser == 'agent') {
           widget = BottomNavBarAgent();
          }else{
            widget = BottomNavBar();
          }
        }
        token = CacheHelper.getData(key: 'token') ;
        id = CacheHelper.getData(key: 'id') ??'' ;
      }

      navigateAndFinish(context, widget);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(child:
                Image.asset('assets/images/$logo',width: 150,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}