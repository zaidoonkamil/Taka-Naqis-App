import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:taka_naqis/core/widgets/show_toast.dart';
import 'package:taka_naqis/features/user/view/chat.dart';
import 'package:taka_naqis/features/user/view/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/constant.dart';
import '../../auth/view/login.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()
        ..getProfile(context: context),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: ConditionalBuilder(
                  condition: true,
                  builder: (context)=>SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        adminOrUser != 'admin'? CustomAppBar():CustomAppBarAdmin(),
                        SizedBox(height: 18,),
                        token != ''?  cubit.profileModel != null? Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: 1.0,
                            ),
                              borderRadius: BorderRadius.circular(12),
                              color: containerColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(cubit.profileModel!.name),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(cubit.profileModel!.phone,style: TextStyle(color: Colors.grey),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: secondPrimaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.yellow,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryColor.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ):CircularProgress():Container(),
                        SizedBox(height: 16,),
                        GestureDetector(
                          onTap: () async {
                            final url =
                             'https://www.facebook.com/share/1C1UbUpFjL';
                            await launch(
                              url,
                              enableJavaScript: true,
                            ).catchError((e) {
                              showToastError(
                                text: e.toString(),
                                context: context,
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('فيسبوك',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: secondPrimaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.yellow,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.ad_units_outlined,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url =
                                'https://www.instagram.com/takanaqs';
                            await launch(
                              url,
                              enableJavaScript: true,
                            ).catchError((e) {
                              showToastError(
                                text: e.toString(),
                                context: context,
                              );
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('انستجرام',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: secondPrimaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.yellow,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.code,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        adminOrUser == 'user'?Column(
                          children: [
                            GestureDetector(
                              onTap: ()  {
                                token != ''?
                                navigateTo(context, Favorites()):
                                showToastInfo(text: 'يجب عليك تسجيل الدخول اولا', context: context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: containerColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('المفضلة',style: TextStyle(fontSize: 14),),
                                    SizedBox(width: 12,),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: secondPrimaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.yellow,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: ()  {
                                token != ''?
                                navigateTo(context, Chat(userId: int.parse(id))):
                                showToastInfo(text: 'يجب عليك تسجيل الدخول اولا', context: context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: containerColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('دردش معنا',style: TextStyle(fontSize: 14),),
                                    SizedBox(width: 12,),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: secondPrimaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.yellow,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.chat,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ):Container(),
                        token ==''?Container(): GestureDetector(
                          onTap: () async {
                           signOut(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('تسجيل الخروج',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon (4).png'),

                              ],
                            ),
                          ),
                        ),
                        token ==''?Container():GestureDetector(
                          onTap: () async {
                            showToastInfo(text: 'تم تقديم طلب حذف الحساب', context: context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: containerColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('حذف الحساب',style: TextStyle(fontSize: 14),),
                                SizedBox(width: 12,),
                                Image.asset('assets/images/Icon (5).png'),

                              ],
                            ),
                          ),
                        ),
                        token !=''?Container(): Column(
                          children: [
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                navigateTo(context, Login());
                              },
                              child: Container(
                                width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: secondPrimaryColor,
                                  ),
                                  child: Center(child: Text('تسجيل الدخول',style: TextStyle(color: Colors.white),))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  fallback: (context){
                    return Column(
                      children: [
                        Container(
                          height: 62,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Image.asset('assets/images/shopping-cart-02.png',
                                    height: 34,
                                    width: 34,
                                  ),
                                ),
                                Image.asset('assets/images/Logo.png',
                                  height: 34,
                                  width: 34,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgress(),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          );
        },
      ),
    );
  }
}
