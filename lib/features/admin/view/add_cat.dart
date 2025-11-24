import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taka_naqis/core/navigation_bar/navigation_bar_Admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../../../core/styles/themes.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/show_toast.dart';
import '../../../core/widgets/app_bar.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class AddCat extends StatelessWidget {
  const AddCat({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController tittleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){
          if(state is AddCategoriesSuccessState){
            AdminCubit.get(context).selectedImagesCat=[];
            tittleController.text='';
            showToastSuccess(
              text: "تمت العملية بنجاح",
              context: context,
            );
            navigateAndFinish(context, BottomNavBarAdmin());
          }
        },
        builder: (context,state){
          var cubit=AdminCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body:SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    CustomAppBarBack(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            GestureDetector(
                                onTap:(){
                                  cubit.pickImagesCat();
                                },
                                child:
                                cubit.selectedImagesCat.isEmpty?
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: secondPrimaryColor,
                                    border: Border.all(color: primaryColor, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor,
                                        blurRadius: 12,
                                        offset: Offset(0, 0),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.picture_frame,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "اختيار صورة",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipOval(
                                    child: Image.file(
                                      File(cubit.selectedImagesCat[0].path),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: tittleController,
                              hintText: 'العنوان',
                              prefixIcon: Icons.title,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'رجائا اخل العنوان';
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            ConditionalBuilder(
                              condition: state is !AddCategoriesLoadingState,
                              builder: (context){
                                return GestureDetector(
                                  onTap: (){
                                    if (formKey.currentState!.validate()) {
                                      cubit.addCat(
                                        tittle: tittleController.text.trim(),
                                        context: context,
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor.withOpacity(0.2),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                            offset: const Offset(5, 5),
                                          ),
                                        ],
                                        borderRadius:  BorderRadius.circular(12),
                                        color: secondPrimaryColor
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(width: 50,),
                                        Text('انشاء قسم جديد',
                                          style: TextStyle(color: Colors.white,fontSize: 16 ),),
                                        Container(
                                          margin: EdgeInsets.all(6),
                                          height: double.maxFinite,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:  BorderRadius.circular(12),
                                              color: Colors.white
                                          ),
                                          child: Icon(Icons.arrow_forward_ios_outlined,size: 22,color: primaryColor,),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
