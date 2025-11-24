import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taka_naqis/features/auth/view/login.dart';

import '../ navigation/navigation.dart';
import '../../features/user/view/basket.dart';
import '../../features/user/view/notifications.dart';
import '../styles/themes.dart';
import 'constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(26),
          bottomLeft: Radius.circular(26),
        ),
        border: Border(
          bottom: BorderSide(
            color: containerColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: (){
                  token != ''?
                  navigateTo(context, Basket()):
                  navigateTo(context, Login());
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FaIcon(FontAwesomeIcons.basketShopping,size: 20,) )),
            Image.asset('assets/images/$logo',width: 80,height: 80,),
            GestureDetector(
                onTap: (){
                 token != ''?
                 navigateTo(context, NotificationsUser()):
                 navigateTo(context, Login());
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FaIcon(FontAwesomeIcons.solidBell,size: 20,) )),
          ],
        ),
      ),
    );
  }
}

class CustomAppBarBack extends StatelessWidget {
  const CustomAppBarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(26),
          bottomLeft: Radius.circular(26),
        ),
        border: Border(
          bottom: BorderSide(
            color: containerColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: (){
                  navigateBack(context);
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.arrow_back_ios_new) )),
            Image.asset('assets/images/$logo',width: 80,height: 80,),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.person,size: 20,) ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBarAdmin extends StatelessWidget {
  const CustomAppBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(26),
          bottomLeft: Radius.circular(26),
        ),
        border: Border(
          bottom: BorderSide(
            color: containerColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GestureDetector(
            //     onTap: (){
            //       token != ''?
            //       navigateTo(context, Basket()):
            //       navigateTo(context, Login());
            //     },
            //     child: Container(
            //         padding: EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: primaryColor,
            //             width: 1,
            //           ),
            //           shape: BoxShape.circle,
            //           color: Colors.white,
            //         ),
            //         child: FaIcon(FontAwesomeIcons.basketShopping,size: 20,) )),
            Image.asset('assets/images/$logo',width: 80,height: 80,),
            // GestureDetector(
            //     onTap: (){
            //       token != ''?
            //       navigateTo(context, NotificationsUser()):
            //       navigateTo(context, Login());
            //     },
            //     child: Container(
            //         padding: EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: primaryColor,
            //             width: 1,
            //           ),
            //           shape: BoxShape.circle,
            //           color: Colors.white,
            //         ),
            //         child: FaIcon(FontAwesomeIcons.solidBell,size: 20,) )),
          ],
        ),
      ),
    );
  }
}
