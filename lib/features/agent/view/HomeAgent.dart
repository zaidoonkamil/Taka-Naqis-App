import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:taka_naqis/features/agent/cubit/states.dart';
import 'package:taka_naqis/features/agent/view/add_products.dart';
import 'package:taka_naqis/features/user/model/GetAdsModel.dart';
import 'package:taka_naqis/features/user/view/Section.dart';
import 'package:taka_naqis/features/user/view/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../user/view/ads.dart';
import '../../user/view/details.dart';
import '../cubit/cubit.dart';

class HomeAgent extends StatelessWidget {
  const HomeAgent({super.key});

  static ScrollController? scrollController;
  static CarouselController carouselController = CarouselController();
  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AgentCubit()..getGreeting()
        ..getAds(context: context)
        ..getProfile(context: context)
        ..getProducts(context: context, page: '1'),
      child: BlocConsumer<AgentCubit, AgentStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit=AgentCubit.get(context);
            return SafeArea(
                child: Scaffold(
                  body:cubit.profileModel != null
                      //&& cubit.getCatModel.isNotEmpty
                      ?Column(
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  navigateTo(context, NotificationsUser());
                                },
                                child: Image.asset('assets/images/notif.png')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('..! ${cubit.getGreeting()}',style: TextStyle(color:secondTextColor),textAlign: TextAlign.end,),
                                    Text(cubit.profileModel!.name,textAlign: TextAlign.end,),
                                  ],
                                ),
                                SizedBox(width: 4,),
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/logo.jpeg',
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                              child: Column(
                                children: [
                                  ConditionalBuilder(
                                    condition:cubit.getAdsModel.isNotEmpty,
                                    builder:(c){
                                      return Stack(
                                        children: [
                                          CarouselSlider(
                                            items: cubit.getAdsModel.isNotEmpty
                                                ? cubit.getAdsModel.expand<Widget>((GetAds ad) =>
                                                ad.images.map<Widget>((String imageUrl) => Builder(
                                                  builder: (BuildContext context) {
                                                    String formattedDate =
                                                    DateFormat('yyyy/M/d').format(ad.createdAt);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        navigateTo(
                                                          context,
                                                          AdsUser(
                                                            tittle: ad.title,
                                                            desc: ad.description,
                                                            image: imageUrl,
                                                            time: formattedDate,
                                                          ),
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        child: Image.network(
                                                          "$url/uploads/$imageUrl",
                                                          fit: BoxFit.cover,
                                                          width: double.infinity,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )),
                                            ).toList()
                                                : <Widget>[],
                                            options: CarouselOptions(
                                              height: 156,
                                              viewportFraction: 0.94,
                                              enlargeCenterPage: true,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: true,
                                              autoPlay: true,
                                              autoPlayInterval: const Duration(seconds: 6),
                                              autoPlayAnimationDuration: const Duration(seconds: 1),
                                              autoPlayCurve: Curves.fastOutSlowIn,
                                              scrollDirection: Axis.horizontal,
                                              onPageChanged: (index, reason) {
                                                currentIndex = index;
                                                cubit.slid();
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 8,
                                            left: 0,
                                            right: 0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: cubit.getAdsModel.asMap().entries.map((entry) {
                                                return Container(
                                                  width: 8,
                                                  height: 7.0,
                                                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: currentIndex == entry.key
                                                        ? primaryColor.withOpacity(0.8)
                                                        : Colors.white,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    fallback: (c)=> Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 60.0),
                                      child: Container(),
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  GestureDetector(
                                    onTap: (){
                                      navigateTo(context, AddProducts());
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('اضافة منتج',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  cubit.productsModel != null?
                                  GridView.custom(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 1,
                                      childAspectRatio: 0.6,
                                    ),
                                    childrenDelegate: SliverChildBuilderDelegate(
                                      childCount: cubit.productsModel!.products.length, (context, index) {
                                      if (index == cubit.productsModel!.products.length - 1 && !cubit.isLastPageProducts) {
                                        cubit.getProducts(page: (cubit.currentPageProducts + 1).toString(), context: context);
                                      }
                                      String rawImageUrl = cubit.productsModel!.products[index].images[0];
                                      String cleanImageUrl = rawImageUrl.replaceAll(RegExp(r'[\[\]]'), '');
                                      return GestureDetector(
                                        onTap: () {
                                          navigateTo(context, Details(
                                            sellerId: cubit.productsModel!.products[index].seller.id.toString(),
                                            id: cubit.productsModel!.products[index].id.toString(),
                                            tittle: cubit.productsModel!.products[index].title.toString(),
                                            description: cubit.productsModel!.products[index].description.toString(),
                                            price: cubit.productsModel!.products[index].price.toString(),
                                            images: cubit.productsModel!.products[index].images,
                                            isFavorite: cubit.productsModel!.products[index].isFavorite,
                                            imageSeller: cubit.productsModel!.products[index].seller.image,
                                            locationSeller: cubit.productsModel!.products[index].seller.location,
                                            nameSeller: cubit.productsModel!.products[index].seller.name,
                                          ));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: borderColor,
                                              width: 1.0,
                                            ),
                                            color: containerColor,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.network(
                                                  '$url/uploads/$cleanImageUrl',
                                                  width: double.maxFinite,
                                                  height: 143,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap:(){
                                                      cubit.deleteProducts(idProducts: cubit.productsModel!.products[index].id.toString(), context: context);
                                                    },
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          cubit.productsModel!.products[index].title,
                                                          style: TextStyle(fontSize: 14),
                                                          textAlign: TextAlign.end,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(height: 6,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              'د.ع',
                                                              maxLines: 1,
                                                              style: TextStyle(color: secondPrimaryColor,fontSize: 13),
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.end,
                                                            ),
                                                            Text(
                                                              NumberFormat('#,###').format(cubit.productsModel!.products[index].price).toString(),
                                                              maxLines: 1,
                                                              style: TextStyle(color: secondPrimaryColor,fontSize: 13),
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    ),
                                  ):
                                  Container(),
                                ],
                              )
                          ),
                        ),
                      ),
                    ],
                  ):Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgress()),
                    ],
                  ),
                ));
          }),
    );
  }
}
