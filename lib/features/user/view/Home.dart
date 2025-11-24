import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:taka_naqis/features/user/view/Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/constant.dart';
import '../../auth/view/login.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../model/GetAdsModel.dart';
import 'ads.dart';
import 'details.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  static ScrollController? scrollController;
  static CarouselController carouselController = CarouselController();
  static int currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      UserCubit()..getGreeting()
        ..getAds(context: context)
        ..getCat(context: context)
        ..scrol()
        ..getProducts(context: context, page: '1'),
      child: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {
            if(state is AddToBasketSuccessState){
              showSuccessSnackBar(context,'تمت عملية اضافة المنتج الى السلة بنجاح');
            }
          },
          builder: (context, state) {
            var cubit=UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBar(),
                  cubit.getCatModel.isNotEmpty?Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                            child: ConditionalBuilder(
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
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color: primaryColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.network(
                                                      "$url/uploads/$imageUrl",
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
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
                                                  ? secondPrimaryColor.withOpacity(0.8)
                                                  : Colors.white,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              fallback: (c)=> Container(),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('الاقسام',style: TextStyle(fontSize: 18),textAlign: TextAlign.end,),
                              ],
                            ),
                          ),
                          SizedBox(height: 6,),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              controller: cubit.scrollControllerCatt,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.getCatModel.length,
                              reverse: true,
                              itemBuilder: (context, i) {
                                String rawImageUrl = cubit.getCatModel[i].images[0];
                                String cleanImageUrl = rawImageUrl.replaceAll(RegExp(r'[\[\]]'), '');
                                return GestureDetector(
                                  onTap: (){
                                    navigateTo(context, Section(categoriesId: cubit.getCatModel[i].id.toString()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        color: containerColor,
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1.0,
                                      ),
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: containerColor,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "$url/uploads/$cleanImageUrl",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            cubit.getCatModel[i].name,
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('الأكثر مبيعًا',style: TextStyle(fontSize: 18),textAlign: TextAlign.end,),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          cubit.products.isNotEmpty ?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GridView.custom(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 1,
                                childAspectRatio: 0.6,
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                childCount: cubit.products.length,
                                    (context, index) {
                                  String rawImageUrl = cubit.products[index].images[0];
                                  String cleanImageUrl = rawImageUrl.replaceAll(RegExp(r'[\[\]]'), '');
                                  return GestureDetector(
                                    onTap: () {
                                      navigateTo(context, Details(
                                        sellerId: cubit.products[index].seller.id.toString(),
                                        id: cubit.products[index].id.toString(),
                                        tittle: cubit.products[index].title.toString(),
                                        description: cubit.products[index].description.toString(),
                                        price: cubit.products[index].price.toString(),
                                        images: cubit.products[index].images,
                                        isFavorite: cubit.products[index].isFavorite,
                                        imageSeller: cubit.products[index].seller.image,
                                        locationSeller: cubit.products[index].seller.location,
                                        nameSeller: cubit.products[index].seller.name,
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
                                                  token != ''?
                                                  cubit.addToBasket(
                                                    productId: cubit.products[index].id.toString(),
                                                    quantity: '1',
                                                    context: context,
                                                  ):
                                                  navigateTo(context, Login());

                                                },
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.yellowAccent.withOpacity(0.15),
                                                        blurRadius: 20,
                                                        spreadRadius: 2,
                                                        offset: Offset(0, 0),
                                                      ),
                                                    ],
                                                    color: secondPrimaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(child: FaIcon(FontAwesomeIcons.basketShopping,size: 16,color: Colors.white,)),
                                                ),
                                              ),
                                              SizedBox(width: 5,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      cubit.products[index].title,
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
                                                          NumberFormat('#,###').format(cubit.products[index].price).toString(),
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
                            ),
                          ):
                          Container(),
                          SizedBox(height: 100,),
                        ],
                      ),
                      ),
                    ):
                  CircularProgressHome(),
                ],
              ),
          ));
          }),
    );
  }
}
