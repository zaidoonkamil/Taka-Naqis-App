import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'details_orders_Admin.dart';


class OrdersAdmin extends StatelessWidget {
  const OrdersAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AdminCubit(),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AdminCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBarAdmin(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        navigateTo(context, DetailsOrdersAdmin(status: 'قيد الانتضار'));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'قيد الانتضار',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        navigateTo(context, DetailsOrdersAdmin(status: 'قيد التوصيل'));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'قيد التوصيل',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 12),
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        navigateTo(context, DetailsOrdersAdmin(status: 'ملغي'));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ملغي',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        navigateTo(context, DetailsOrdersAdmin(status: 'مكتمل'));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'مكتمل',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
          );
        },
      ),
    );
  }
}
