import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/constant.dart';
import '../../auth/view/login.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'details.dart';


class Section extends StatelessWidget {
  const Section({super.key, required this.categoriesId});

  final String categoriesId;
  static ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      UserCubit()..getGreeting()..getCatCatProducts(context: context,page: '1',id: categoriesId)..initScrollControllerCat(context, categoriesId),
      child: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit=UserCubit.get(context);
            return SafeArea(
              child: Scaffold(
                  body:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 24,),
                            const Text(
                              textAlign: TextAlign.right,
                              'الاقسام',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                                onTap: (){
                                  navigateBack(context);
                                },
                                child: Icon(Icons.keyboard_arrow_right_outlined,size: 32,)),
                          ],
                        ),
                        SizedBox(height: 12,),
                        Expanded(
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: UserCubit.scrollControllerCat,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: cubit.productCat.length,
                            itemBuilder: (context, index) {
                              final product = cubit.productCat[index];
                              String rawImageUrl = product.images[0];
                              String cleanImageUrl = rawImageUrl.replaceAll(RegExp(r'[\[\]]'), '');

                              return GestureDetector(
                                onTap: () {
                                  navigateTo(context, Details(
                                    sellerId: product.seller.id.toString(),
                                    id: product.id.toString(),
                                    tittle: product.title,
                                    description: product.description,
                                    price: product.price.toString(),
                                    images: product.images,
                                    isFavorite: product.seller.isVerified,
                                    imageSeller: product.seller.image,
                                    nameSeller: product.seller.name,
                                    locationSeller: product.seller.location,
                                  ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: borderColor, width: 1.0),
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
                                            onTap: () {
                                              token != ''?
                                              cubit.addToBasket(
                                                productId: product.id.toString(),
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
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    product.title,
                                                    style: TextStyle(fontSize: 14),
                                                    textAlign: TextAlign.end,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 6),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text('د.ع', style: TextStyle(color: primaryColor, fontSize: 13)),
                                                      Text(
                                                        NumberFormat('#,###').format(product.price),
                                                        style: TextStyle(color: primaryColor, fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                        )
                      ],
                    ),
                  )
              ),
            );
          }),
    );
  }
}
