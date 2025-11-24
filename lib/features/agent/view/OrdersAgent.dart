import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/%20navigation/navigation.dart';
import 'package:taka_naqis/features/agent/view/details_orders_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class OrdersAgent extends StatelessWidget {
  const OrdersAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AgentCubit(),
      child: BlocConsumer<AgentCubit,AgentStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AgentCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomAppBar(),
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
                                        navigateTo(context, DetailsOrdersAgent(status: 'قيد الانتضار'));
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
                                        navigateTo(context, DetailsOrdersAgent(status: 'قيد التوصيل'));
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
                                        navigateTo(context, DetailsOrdersAgent(status: 'ملغي'));
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
                                        navigateTo(context, DetailsOrdersAgent(status: 'مكتمل'));
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
              ),
            ),
          );
        },
      ),
    );
  }
}
