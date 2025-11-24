import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taka_naqis/core/widgets/app_bar.dart';
import 'package:taka_naqis/features/agent/cubit/cubit.dart';
import 'package:taka_naqis/features/agent/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../../../core/styles/themes.dart';
import '../../../../core/widgets/background.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/show_toast.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController tittleController = TextEditingController();
  static TextEditingController descController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController categoryIdController = TextEditingController();
  static TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AgentCubit()..getCat(context: context),
      child: BlocConsumer<AgentCubit,AgentStates>(
        listener: (context,state){
          if(state is AddProductsSuccessState){
            AgentCubit.get(context).selectedImages=[];
            tittleController.text='';
            descController.text='';
            priceController.text='';
            categoryIdController.text='';
            categoryNameController.text='';
            showToastSuccess(
              text: "تمت العملية بنجاح",
              context: context,
            );
          }
        },
        builder: (context,state){
          var cubit=AgentCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body:Column(
                children: [
                  CustomAppBarBack(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                      onTap:(){
                                        cubit.pickImages();
                                      },
                                      child:
                                      cubit.selectedImages.isEmpty?
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
                                            File(cubit.selectedImages[0].path),
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
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    controller: priceController,
                                    hintText: 'السعر',
                                    keyboardType: TextInputType.number,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'رجائا اخل السعر';
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    controller: categoryNameController,
                                    hintText: 'القسم',
                                    keyboardType: TextInputType.none,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.white,
                                        builder: (context) {
                                          return SizedBox(
                                            width: double.maxFinite,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Text("اختر القسم"),
                                                SizedBox(height: 10,),
                                                Expanded(
                                                  child: ListView.builder(
                                                      itemCount: cubit.getCatModel.length,
                                                      itemBuilder: (c,i){
                                                    return GestureDetector(
                                                      onTap: (){
                                                        categoryNameController.text=cubit.getCatModel[i].name.toString();
                                                        categoryIdController.text=cubit.getCatModel[i].id.toString();
                                                        navigateBack(context);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Text(cubit.getCatModel[i].name,style: TextStyle(fontSize: 16),),
                                                          SizedBox(height: 6,),
                                                          Container(width: double.maxFinite,height: 1,color: Colors.grey,),
                                                          SizedBox(height: 6,),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'رجائا اخل القسم';
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    controller: descController,
                                    hintText: 'الوصف',
                                    prefixIcon: Icons.description_outlined,
                                    keyboardType: TextInputType.text,
                                    maxLines: 5,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'رجائا اخل الوصف';
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  ConditionalBuilder(
                                    condition: state is !AddProductsLoadingState,
                                    builder: (context){
                                      return GestureDetector(
                                        onTap: (){
                                          if (formKey.currentState!.validate()) {
                                            cubit.addProducts(
                                                tittle: tittleController.text.trim(),
                                                desc:descController.text.trim(),
                                                price: priceController.text.trim(),
                                                categoryId: categoryIdController.text.trim(),
                                                context: context);
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
                                              Text('اضافة المنتج',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
