import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class DetailsOrdersAgent extends StatelessWidget {
  const DetailsOrdersAgent({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AgentCubit()..getOrdersAgent(context: context, page: '1', status: status ),
      child: BlocConsumer<AgentCubit,AgentStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AgentCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 26,),
                        Text(
                          textAlign: TextAlign.right,
                          status,
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
                  ),
                  SizedBox(height: 12,),
                  ConditionalBuilder(
                    condition: state is! GetOrdersAgentLoadingState,
                    builder: (context){
                      return ConditionalBuilder(
                        condition: cubit.ordersAgentModel!.orders.isNotEmpty,
                        builder: (c){
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cubit.ordersAgentModel!.orders.length,
                                      itemBuilder:(context,index){
                                        if (index == cubit.ordersAgentModel!.orders.length - 1 && !cubit.isLastPageOrdersAgent) {
                                          cubit.getOrdersAgent(page: (cubit.currentPageOrdersAgent + 1).toString(), context: context, status: status);
                                        }
                                        DateTime dateTime = DateTime.parse(cubit.ordersAgentModel!.orders[index].createdAt.toString());
                                        String formattedDate = DateFormat('yyyy/M/d').format(dateTime);
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                          margin: EdgeInsets.symmetric(horizontal: 22,vertical: 4),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: borderColor,
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                              color: containerColor
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      if(status == "قيد الانتضار"){
                                                        cubit.updateOrder(
                                                          context: context,
                                                          id: cubit.ordersAgentModel!.orders[index].id.toString(),
                                                          status: "قيد التوصيل",
                                                        );
                                                      }else if(status == "قيد التوصيل"){
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              backgroundColor: Colors.white,
                                                              content: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text("الى اي حالة تود تحديث الطلب"),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height: 12,),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: (){
                                                                          cubit.updateOrder(
                                                                            context: context,
                                                                            id: cubit.ordersAgentModel!.orders[index].id.toString(),
                                                                            status: "ملغي",
                                                                          );
                                                                          navigateBack(context);
                                                                        },
                                                                        child: Container(
                                                                          height: 40,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            color: Colors.redAccent
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text('ملغي',style: TextStyle(color: Colors.white),),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 4,),
                                                                      GestureDetector(
                                                                        onTap: (){
                                                                          cubit.updateOrder(
                                                                            context: context,
                                                                            id: cubit.ordersAgentModel!.orders[index].id.toString(),
                                                                            status: "مكتمل",
                                                                          );
                                                                          navigateBack(context);
                                                                        },
                                                                        child: Container(
                                                                          height: 40,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            color: primaryColor
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text('مكتمل',style: TextStyle(color: Colors.white),),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }

                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: cubit.ordersAgentModel!.orders[index].status == "قيد الانتضار"
                                                            ? Colors.yellow.withOpacity(0.5)
                                                            : cubit.ordersAgentModel!.orders[index].status == "مكتمل"
                                                            ? Colors.lightGreenAccent.withOpacity(0.5)
                                                            : cubit.ordersAgentModel!.orders[index].status == "قيد التوصيل"
                                                            ? Colors.deepOrange.withOpacity(0.5)
                                                            : Colors.redAccent.withOpacity(0.5),
                                                      ),
                                                      child: RotatedBox(
                                                        quarterTurns: 3,
                                                        child: Text(
                                                          cubit.ordersAgentModel!.orders[index].status,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text('${cubit.ordersAgentModel!.orders[index].id}#',
                                                              overflow: TextOverflow.ellipsis,),
                                                            Text(' : طلب رقم',
                                                              overflow: TextOverflow.ellipsis,),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(formattedDate,style: TextStyle(color: secondTextColor,fontSize: 12),),
                                                            SizedBox(width: 4,),
                                                            Text(' : تم الطلب',style: TextStyle(color: secondTextColor,fontSize: 12),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(cubit.ordersAgentModel!.orders[index].totalItems.toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
                                                            SizedBox(width: 4,),
                                                            Text(' : عدد الطلبات',style: TextStyle(color: secondTextColor,fontSize: 13),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text('د.ع ',style: TextStyle(color: secondPrimaryColor,fontSize: 13),),
                                                            Text(NumberFormat('#,###').format(cubit.ordersAgentModel!.orders[index].totalPrice).toString(),style: TextStyle(color: secondPrimaryColor,fontSize: 13),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(cubit.ordersAgentModel!.orders[index].phone),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(cubit.ordersAgentModel!.orders[index].address),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 12,),
                                                  Image.asset(
                                                    'assets/images/Group 142.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 6,),
                                              Container(width: double.maxFinite,height: 1,color: Colors.grey,),
                                              SizedBox(height: 6,),
                                              SizedBox(
                                                height: 80,
                                                child: ListView.builder(
                                                    itemCount: cubit.ordersAgentModel!.orders[index].items.length,
                                                    itemBuilder: (c,i){
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                border: Border.all(
                                                                  color: Colors.grey.shade300,
                                                                  width: 1.5,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(cubit.ordersAgentModel!.orders[index].items[i].productAgent.title.toString(),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                                style:TextStyle(height: 1.3),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 2,),
                                                                          Row(
                                                                            children: [
                                                                              Text(cubit.ordersAgentModel!.orders[index].items[i].priceAtOrder.toString()),
                                                                              Text(' : السعر'),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 2,),
                                                                          Row(
                                                                            children: [
                                                                              Text(cubit.ordersAgentModel!.orders[index].items[i].quantity.toString()),
                                                                              Text(' : العدد'),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(width: 6,),
                                                                      Image.network(
                                                                          '$url/uploads/${cubit.ordersAgentModel!.orders[index].items[i].productAgent.images[0]}',
                                                                      width: 60,
                                                                      height: 60,),
                                                                    ],
                                                                  ),
                                                            ),
                                                          ),
                                                          Text('${i+1}#'),
                                                        ],
                                                      );
                                                }),
                                              ),
                                            ],
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgress(),
                          ],
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
