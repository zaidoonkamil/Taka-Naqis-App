import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taka_naqis/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/navigation_bar/navigation_bar.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CompleteShopping extends StatelessWidget {
  const CompleteShopping({super.key, required this.items});

  void showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'تمت العملية',
        message: message,
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static bool isValidationPassed = false;
  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){
          if(state is AddOrderSuccessState){
            phoneController.text='';
            locationController.text='';
            showSuccessSnackBar(context, "تمت عملية الطلب بنجاح");
            navigateAndFinish(context, BottomNavBar());
          }
        },
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomAppBarBack(),
                          SizedBox(height: 12,),
                          Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(0, 3), // موضع الظل
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.payment,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'الدفع',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'نقدًا عند الاستلام',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 16,),
                                CustomTextField(
                                  hintText: 'ادخل رقم الهاتف',
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'رجائا ادخل رقم الهاتف';
                                    }
                                  },
                                ),
                                SizedBox(height: 16,),
                                CustomTextField(
                                  hintText: 'ادخل العنوان بالتفصيل',
                                  controller: locationController,
                                  keyboardType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'رجائا ادخل العنوان بالتفصيل';
                                    }
                                  },
                                ),
                                SizedBox(height: 12,),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: secondPrimaryColor,
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'التوصيل ٥ آلاف لكل المحافظات، وإذا طلبت ٤ منتجات أو أكثر يكون التوصيل مجاني',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(width: 12),
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
                                        color: primaryColor.withOpacity(0.5),
                                        blurRadius: 5,
                                        spreadRadius: 4,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:18 ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                if (formKey.currentState!.validate()) {
                                  cubit.addOrder(
                                    context: context,
                                      phone: phoneController.text.trim(),
                                      location: locationController.text.trim(),
                                      products: items,
                                  );
                                }
                              },
                              child:Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  color: secondPrimaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('تأكيد',
                                        style: TextStyle(color: Colors.white, fontSize: 16)),
                                  ],
                                ),
                              )
                                  .animate(onPlay: (controller) => controller.forward())
                                  .scale(duration: 500.ms, curve: Curves.easeOutBack)
                                  .shake(duration: 500.ms, hz: 3, ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
