import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:taka_naqis/core/widgets/app_bar.dart';
import 'package:taka_naqis/features/user/view/complete_shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class Basket extends StatelessWidget {
  const Basket({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          UserCubit()..getBasket(context: context),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBarBack(),
                  SizedBox(height: 16,),
                  ConditionalBuilder(
                    condition: state is! GetBasketLoadingState,
                    builder: (context){
                      return ConditionalBuilder(
                        condition: cubit.basketModel.isNotEmpty,
                        builder: (c){
                          return Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: 50,
                                  color: primaryColor.withOpacity(0.2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('لديك ${cubit.basketModel.length} منتجات في سله التسوق',style: TextStyle(color: primaryColor,fontSize: 14),)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 6,),
                                GestureDetector(
                                  onTap: (){
                                    List<Map<String, dynamic>> itemsMap = cubit.basketModel.map((item) {
                                      return {
                                        'productId': item.productId,
                                        'quantity': item.quantity,
                                      };
                                    }).toList();

                                    navigateTo(context, CompleteShopping(items: itemsMap));
                                  },
                                  child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    height: state is! GetBasketLoadingState && cubit.basketModel.isNotEmpty ? 50 : 0,
                                      width: double.infinity,
                                      color: primaryColor.withOpacity(0.2),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: state is! GetBasketLoadingState && cubit.basketModel.isNotEmpty
                                            ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.arrow_back, color: primaryColor),
                                            Text('اضغط لاكمال الشراء', style: TextStyle(color: primaryColor, fontSize: 14)),
                                            SizedBox(width: 20),
                                          ],
                                        ) : null,
                                      ),
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Container(
                                  width: double.maxFinite,
                                  height: 50,
                                  color: primaryColor.withOpacity(0.2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ' د.ع ',
                                        style: TextStyle(color: primaryColor, fontSize: 14),
                                      ),
                                      Text(
                                        NumberFormat('#,###').format(cubit.getTotalPrice()),
                                        style: TextStyle(color: primaryColor, fontSize: 14),
                                      ),
                                      Text(
                                        ' : المجموع الكلي',
                                        style: TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: cubit.basketModel.length,
                                            itemBuilder:(context,index){
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1.0,
                                                    ),
                                                    color: Colors.white
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: (){
                                                                  cubit.deleteBasket(idItem: cubit.basketModel[index].id.toString(), context: context);
                                                                },
                                                                child: Image.asset('assets/images/Card options icon.png')),
                                                            SizedBox(height: 20,),
                                                            Row(
                                                              children: [
                                                                Text('د.ع ',style: TextStyle(color: secondPrimaryColor,fontWeight: FontWeight.bold),),
                                                                Text(NumberFormat('#,###').format(cubit.basketModel[index].product.price).toString(),style: TextStyle(color: secondPrimaryColor),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(cubit.basketModel[index].product.title,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,),
                                                              ],
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    cubit.minusBasket(index: index, context: context);
                                                                  },
                                                                  child: Container(
                                                                    width: 25,
                                                                    height: 25,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.grey[300],
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                    child: const Icon(Icons.remove, color: Colors.black, size: 18),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 8),
                                                                Text(
                                                                  '${cubit.basketModel[index].quantity}',
                                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                ),
                                                                const SizedBox(width: 8),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    cubit.addBasket(index: index);
                                                                  },
                                                                  child: Container(
                                                                    width: 25,
                                                                    height: 25,
                                                                    decoration: BoxDecoration(
                                                                      color: primaryColor,
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(width: 12,),
                                                        Column(
                                                          children: [
                                                            Container(
                                                              width: 83,
                                                              height: 92,
                                                              color: containerColor,
                                                              child: Image.network(
                                                                '$url/uploads/${cubit.basketModel[index].product.images[0]}',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        fallback: (context)=>
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('لا يوجد منتجات ليتم عرضها'),
                                ],
                              ),
                            ),
                      );
                    },
                    fallback: (context)=>
                        Expanded(
                          child: CircularProgressBasket(),
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
