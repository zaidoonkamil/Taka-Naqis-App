import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taka_naqis/core/widgets/app_bar.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'details.dart';


class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
     UserCubit()..getFavorites(context: context),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBarBack(),
                  SizedBox(height: 12,),
                  ConditionalBuilder(
                    condition: state is! GetFavoritesLoadingState,
                    builder: (context){
                      return ConditionalBuilder(
                        condition: cubit.favoritesModel!.productsFavorites.isNotEmpty,
                        builder: (c){
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cubit.favoritesModel!.productsFavorites.length,
                                      itemBuilder:(context,index){
                                        return GestureDetector(
                                          onTap: () {
                                            navigateTo(context, Details(
                                              sellerId: cubit.favoritesModel!.productsFavorites[index].seller.id.toString(),
                                              id: cubit.favoritesModel!.productsFavorites[index].id.toString(),
                                              tittle: cubit.favoritesModel!.productsFavorites[index].title.toString(),
                                              description: cubit.favoritesModel!.productsFavorites[index].description.toString(),
                                              price: cubit.favoritesModel!.productsFavorites[index].price.toString(),
                                              images: cubit.favoritesModel!.productsFavorites[index].images,
                                              isFavorite: true,
                                              imageSeller: cubit.favoritesModel!.productsFavorites[index].seller.image,
                                              locationSeller: cubit.favoritesModel!.productsFavorites[index].seller.location,
                                              nameSeller: cubit.favoritesModel!.productsFavorites[index].seller.name,
                                            ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: borderColor,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                                color: containerColor
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                         cubit.updateFavorites(idItem: cubit.favoritesModel!.productsFavorites[index].id.toString(), context: context);
                                                        },
                                                        child: Image.asset('assets/images/Card options icon.png')),
                                                    SizedBox(width: 12,),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Expanded(
                                                                child: Text(cubit.favoritesModel!.productsFavorites[index].title,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.end,),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text('د.ع',style: TextStyle(color: primaryColor),),
                                                                  SizedBox(width: 4,),
                                                                  Text(NumberFormat('#,###').format(cubit.favoritesModel!.productsFavorites[index].price).toString(),style: TextStyle(color: primaryColor),),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 12,),
                                                    Container(
                                                      width: 64,
                                                      height: 64,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(6.0),
                                                        child: Image.network(
                                                          '$url/uploads/${cubit.favoritesModel!.productsFavorites[index].images[0]}',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(height: 20,),
                                ],
                              ),
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
                          child: CustomCircularProgress(),
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
