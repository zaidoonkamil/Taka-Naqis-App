import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../../../core/styles/themes.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/show_toast.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';


class AddAgent extends StatelessWidget {
  const AddAgent({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){
          if(state is SignUpSuccessState){
            AdminCubit.get(context).selectedImagesAgent=[];
            userNameController.text='';
            phoneController.text='';
            locationController.text='';
            passwordController.text='';
            rePasswordController.text='';
            showToastSuccess(
              text: "تم انشاء الحساب بنجاح",
              context: context,
            );
          }
        },
        builder: (context,state){
          var cubit=AdminCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  navigateBack(context);
                                },
                                child: Icon(Icons.arrow_back_ios_new_rounded,size: 34,)),
                            Text('حساب جديد',style: TextStyle(color: primaryColor,fontSize: 22,fontWeight: FontWeight.bold),),
                            Container(width: 25,),
                          ],
                        ),
                        const SizedBox(height: 70),
                        GestureDetector(
                            onTap:(){
                              cubit.pickImagesAgent();
                            },
                            child:
                            cubit.selectedImagesAgent.isEmpty?
                            Image.asset('assets/images/Group 1171275632 (1).png'):Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipOval(
                                child: Image.file(
                                  File(cubit.selectedImagesAgent[0].path),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        const SizedBox(height: 16),

                        CustomTextField(
                          hintText: 'الاسم الثلاثي',
                          prefixIcon: Icons.person_outline,
                          controller: userNameController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل الاسم الثلاثي';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            CustomTextField(
                              controller: phoneController,
                              hintText: 'رقم الهاتف',
                              prefixIcon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'رجائا اخل رقم الهاتف';
                                }
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              height: 48,
                              width: 80,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '+964',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: locationController,
                          hintText: 'الموقع',
                          prefixIcon: Icons.location_on_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل الرمز السري';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'كلمة السر',
                          prefixIcon: Icons.lock,
                          obscureText: cubit.isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              cubit.togglePasswordVisibility();
                            },
                            child: Icon(
                              cubit.isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل الرمز السري';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: rePasswordController,
                          hintText: 'اعد كتابة كلمة السر',
                          prefixIcon: Icons.lock,
                          obscureText: cubit.isPasswordHidden2,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              cubit.togglePasswordVisibility2();
                            },
                            child: Icon(
                              cubit.isPasswordHidden2 ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اعد ادخال الرمز السري';
                            }
                          },
                        ),
                        const SizedBox(height: 60),
                        ConditionalBuilder(
                          condition: state is !SignUpLoadingState,
                          builder: (c){
                            return GestureDetector(
                              onTap: (){
                                if (formKey.currentState!.validate()) {
                                  if(passwordController.text == rePasswordController.text){
                                    cubit.signUpAgent(
                                      name: userNameController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      location: locationController.text.trim(),
                                      password: passwordController.text.trim(),
                                      role: 'agent',
                                      context: context,
                                    );
                                  }else{
                                    showToastError(
                                      text: "كلمة السر غير متطابقة",
                                      context: context,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: const Offset(5, 5),
                                      ),
                                    ],
                                    borderRadius:  BorderRadius.circular(16),
                                    color: primaryColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(width: 50,),
                                    Text('تسجيل الدخول',
                                      style: TextStyle(color: Colors.white,fontSize: 18 ),),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
